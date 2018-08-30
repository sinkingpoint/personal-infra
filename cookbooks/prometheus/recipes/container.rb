docker_service 'default' do
  group 'docker'
  action [:create, :start]
end

docker_image 'prometheus' do
  repo 'prom/prometheus'
  tag 'v2.3.2'
  action :pull
end

docker_container 'prometheus' do
  repo 'prom/prometheus'
  tag 'v2.3.2'
  port '8080:9090'
  volumes [
    '/opt/prometheus/prometheus.yml:/etc/prometheus/prometheus.yml',
    '/opt/prometheus/storage:/prometheus',
    '/opt/prometheus/rules:/rules'
  ]
end
