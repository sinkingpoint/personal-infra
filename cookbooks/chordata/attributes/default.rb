override['plex']['plex_mount_point'] = '/l1-za/plex'
override['plex']['apps_mount_point'] = '/l1-za/storage/apps'
override['plex']['media_mount_point'] = '/l1-za/storage/media'

override['nginx']['servers'] = [
  {
    name: 'grafana.sinkingpoint.com',
    port: 8081
  }, 
  {
    name: 'prometheus.sinkingpoint.com',
    port: 8080
  },
  {
    name: 'alertmanager.sinkingpoint.com',
    port: 9090
  }
]
