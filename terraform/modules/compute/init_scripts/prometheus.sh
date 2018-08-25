#!/bin/bash

export HOME=/root
REPO_PATH=/opt/provision-repo

apt-get update
apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common python-pip jq
apt-get purge -y awscli
pip install awscli
wget -qO - https://packages.chef.io/chef.asc | apt-key add -

echo "deb https://packages.chef.io/repos/apt/stable stretch main" > /etc/apt/sources.list.d/chef-stable.list

apt-get update
apt-get install -y chefdk git

if [[ ! -d "${REPO_PATH}" ]]; then
    git clone https://github.com/sinkingpoint/personal-infra "${REPO_PATH}"
else
    cd "${REPO_PATH}" && git pull origin master
fi

heat_org=$(/usr/local/bin/aws ssm get-parameter --name heat_org --region eu-west-2 | jq -r '.Parameter.Value')
heat_account=$(/usr/local/bin/aws ssm get-parameter --name heat_account --region eu-west-2 | jq -r '.Parameter.Value')
heat_token=$(/usr/local/bin/aws ssm get-parameter --name heat_token --region eu-west-2 | jq -r '.Parameter.Value')

output_file=$(mktemp)
cat > "${output_file}" <<EOF
{
    "prometheus": {
        "exporters": {
            "heat_org": "${heat_org}",
            "heat_account": "${heat_account}",
            "heat_token": "${heat_token}"
        }
    }
}
EOF

find "${REPO_PATH}/cookbooks" -type f -name Berksfile -exec berks vendor -b {} "${REPO_PATH}/cookbooks" \;
cd "${REPO_PATH}" && chef-client  -j "${output_file}" -z -r 'common,nginx,prometheus'

if [[ ! -f /opt/prometheus/last_backup.txt ]]; then
  /opt/prometheus/scripts/restore_db.sh
  date +%s > /opt/prometheus/last_backup.txt
fi