docker_image 'utilities_exporter' do
  repo 'sinkingpoint/utilities_exporter'
  tag 'master'
  action :pull
end

docker_container 'utilities_exporter' do
  repo 'sinkingpoint/utilities_exporter'
  tag 'master'
  port '8000:8000'
  env [
    "HEAT_ORG=#{node['prometheus']['exporters']['heat_org']}", 
    "HEAT_ACCOUNT=#{node['prometheus']['exporters']['heat_account']}",
    "HEAT_TOKEN=#{node['prometheus']['exporters']['heat_token']}"
  ]
end