interface = node['network']['interfaces']['eth0'] || node['network']['interfaces']['eno1']
default['prometheus']['exporters']['listen_ip'] = (interface['addresses'].select { |a, details| details[:family] == 'inet'}).keys[0]
override['nginx']['servers'] = [
  {
    name: 'prometheus.sinkingpoint.com',
    port: 8080
  },
  {
    name: 'alertmanager.sinkingpoint.com',
    port: 9090
  }
]

default['alertmanager']['slack_webhook'] = 'https://cats'
override['prometheus']['node_exporter']['dir'] = '/opt/textfile_exporters'
default['prometheus']['textfile_collectors'] = [
  'container_status_exporter.sh.erb'
]
