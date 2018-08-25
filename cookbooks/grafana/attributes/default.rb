default['grafana']['root_password'] = 'changeme'
override['nginx']['servers'] = [
  {
    name: 'grafana.sinkingpoint.com',
    port: 8080
  }
]