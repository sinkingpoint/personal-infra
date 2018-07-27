FROM debian:stretch-20180716

RUN apt-get update && \
    apt-get install -y apt-transport-https wget gnupg2

RUN wget -qO - https://packages.chef.io/chef.asc | apt-key add - && \
    echo "deb https://packages.chef.io/repos/apt/stable stretch main" > /etc/apt/sources.list.d/chef-stable.list && \
    apt-get update && \
    apt-get install -y chefdk

RUN mkdir -p /opt/chef/cookbooks
