docker_service 'default' do
  group 'docker'
  action [:create, :start]
end

docker_image 'grafana' do
  repo 'grafana/grafana'
  tag '5.2.3'
  action :pull
end

mount_point = ::File.join(node['grafana']['mount_point'], 'grafana')

directory mount_point do
  user 472
  group 472
end

docker_container 'grafana' do
  repo 'grafana/grafana'
  tag '5.2.3'
  port '8081:3000'
  restart_policy 'always'
  volumes [
    "#{mount_point}:/var/lib/grafana",
  ]
  env [
    "GF_SERVER_ROOT_URL=http://grafana.sinkingpoint.com", 
    "GF_SECURITY_ADMIN_PASSWORD=#{node['grafana']['root_password']}"
  ]
end
