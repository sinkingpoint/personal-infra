interface = node['network']['interfaces']['eth0'] || node['network']['interfaces']['eno1']
default['exporters']['listen_ip'] = (interface['addresses'].select { |a, details| details[:family] == 'inet'}).keys[0]
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