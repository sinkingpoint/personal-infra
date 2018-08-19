directory '/opt/prometheus/storage' do
  user 65534
  group 65534
  recursive true
  action :create
end

template '/opt/prometheus/prometheus.yml' do
  user 65534
  group 65534
  source 'prometheus.yml.erb'
  notifies :restart, 'docker_container[prometheus]'
end