
docker_image 'alertmanager' do
  repo 'prom/alertmanager'
  tag 'v0.15.2'
  action :pull
end

docker_container 'alertmanager' do
  repo 'prom/alertmanager'
  tag 'v0.15.2'
  port '8080:9090'
end
