
docker_image 'alertmanager' do
  repo 'prom/alertmanager'
  tag 'v0.15.2'
  action :pull
end

docker_container 'alertmanager' do
  repo 'prom/alertmanager'
  tag 'v0.15.2'
  restart_policy 'always'
  port '9090:9093'
end
