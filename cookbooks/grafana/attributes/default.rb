default['grafana']['root_password'] = 'changeme'
override['nginx']['servers'] = [
  {
    name: 'grafana.sinkingpoint.com',
    port: 8081
  }
]

default['prometheus']['node_exporter']['dir'] = '/opt/node_exporter/text_files'
default['backups']['s3_bucket'] = 'sinking-database-backups'