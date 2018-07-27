FROM chef-base

ADD . /opt/chef/cookbooks/db
RUN berks install -b /opt/chef/cookbooks/db/Berksfile
