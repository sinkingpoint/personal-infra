export HOME=/home/admin
REPO_PATH=/opt/provision-repo

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
wget -qO - https://packages.chef.io/chef.asc | sudo apt-key add -

echo "deb https://packages.chef.io/repos/apt/stable stretch main" | sudo tee /etc/apt/sources.list.d/chef-stable.list

sudo apt-get update
sudo apt-get install -y chefdk git

if [[ ! -d "${REPO_PATH}" ]]; then
    sudo mkdir "${REPO_PATH}" && sudo chown admin:admin "${REPO_PATH}"
    git clone https://github.com/sinkingpoint/personal-infra "${REPO_PATH}"
else
    cd "${REPO_PATH}" && git pull origin master
fi

find "${REPO_PATH}/cookbooks" -type f -name Berksfile -exec berks vendor -b {} "${REPO_PATH}/cookbooks" \;
cd "${REPO_PATH}" && sudo chef-client -z -r 'build_slave'

sudo rm -rf "${REPO_PATH}"