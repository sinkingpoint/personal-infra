docker_service 'default' do
  group 'docker'
  action [:create, :start]
end

docker_image 'bookstack' do
  repo 'solidnerd/bookstack'
  tag '0.23.0'
  action :pull
end

docker_container 'bookstack' do
  repo 'solidnerd/bookstack'
  tag '0.23.0'
  port '8080:8080'
  env ['DB_HOST=corvus.in.sinkingpoint.com:3306', 'DB_DATABASE=wiki', 'DB_USERNAME=wiki', "DB_PASSWORD=#{node['bookstack']['db']['password']}"]
end
