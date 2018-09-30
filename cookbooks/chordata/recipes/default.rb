include_recipe 'common::packages'
include_recipe 'common::user'
include_recipe 'common::node_exporter'

docker_service 'default' do
  group 'docker'
  action [:create, :start]
end

include_recipe 'plex'
