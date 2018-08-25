default['prometheus']['exporters']['listen_ip'] = (node['network']['interfaces']['eth0']['addresses'].select { |a, details| details[:family] == 'inet'}).keys[0]
override['nginx']['servers'] = [
  {
    name: 'prometheus.sinkingpoint.com',
    port: 8080
  },
  {
    name: 'alertmanager.sinkingpoint.com',
    port: 8080
  }
]