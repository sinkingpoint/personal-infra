#!/bin/bash

export HOME=/root
REPO_PATH=/opt/provision-repo

apt-get update
apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
wget -qO - https://packages.chef.io/chef.asc | apt-key add -

echo "deb https://packages.chef.io/repos/apt/stable stretch main" > /etc/apt/sources.list.d/chef-stable.list

apt-get update
apt-get install -y chefdk git

if [[ ! -d "${REPO_PATH}" ]]; then
    git clone https://github.com/sinkingpoint/personal-infra "${REPO_PATH}"
else
    cd "${REPO_PATH}" && git pull origin master
fi

if [[ ! -f /opt/prometheus/last_backup.txt ]]; then
  /opt/prometheus/scripts/restore_db.sh
  date +%s > /opt/db/last_backup.txt
fi

find "${REPO_PATH}/cookbooks" -type f -name Berksfile -exec berks vendor -b {} "${REPO_PATH}/cookbooks" \;
cd "${REPO_PATH}" && chef-client -z -r 'common,prometheus'
