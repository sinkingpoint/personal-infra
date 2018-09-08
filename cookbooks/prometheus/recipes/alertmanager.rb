directory '/opt/alertmanager'

template '/opt/alertmanager/alertmanager.yml' do
  source 'alertmanager.yml.erb'
  variables ({
    webhook_url: node['alertmanager']['slack_webhook']
  })
end

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
  volumes [
    '/opt/alertmanager/alertmanager.yml:/etc/alertmanager/alertmanager.yml',
  ]
end
