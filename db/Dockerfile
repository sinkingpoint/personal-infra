FROM chef-base

ADD . /opt/chef/cookbooks/db
RUN berks vendor -b /opt/chef/cookbooks/db/Berksfile /opt/chef/cookbooks

RUN cd /opt/chef/cookbooks && chef-client -z -r db
