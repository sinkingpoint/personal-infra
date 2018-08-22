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
  variables ({
    exporter_listen_ip: node['prometheus']['exporters']['listen_ip']
  })
  notifies :restart, 'docker_container[prometheus]'
end