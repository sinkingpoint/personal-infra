default['grafana']['root_password'] = 'changeme'
default['grafana']['mount_point'] = '/opt/grafana'
override['nginx']['servers'] = [
  {
    name: 'grafana.sinkingpoint.com',
    port: 8081
  }
]

default['backups']['s3_bucket'] = 'sinking-database-backups'