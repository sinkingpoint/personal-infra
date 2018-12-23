override['plex']['plex_mount_point'] = '/l1-za/plex'
override['plex']['apps_mount_point'] = '/l1-za/storage/apps'
override['plex']['media_mount_point'] = '/l1-za/storage/media'

override['nginx']['servers'] = [
  {
    name: 'radarr.sinkingpoint.com',
    port: 7878,
    tunnel: false
  },
  {
    name: 'prometheus.sinkingpoint.com',
    port: 8080
  },
  {
    name: 'grafana.sinkingpoint.com',
    port: 8081
  },
  {
    name: 'plexpy.sinkingpoint.com',
    port: 8181
  },
  {
    name: 'sonarr.sinkingpoint.com',
    port: 8989,
    tunnel: false
  },
  {
    name: 'alertmanager.sinkingpoint.com',
    port: 9090
  },
  {
    name: 'transmission.sinkingpoint.com',
    port: 9091,
    tunnel: false
  },
  {
    name: 'jackett.sinkingpoint.com',
    port: 9117,
    tunnel: false
  },
  {
    name: 'plex.sinkingpoint.com',
    port: 32400
  },
  {
    name: 'ombi.sinkingpoint.com',
    port: 3579
  },
  {
    name: 'cadvisor.sinkingpoint.com',
    port: 9101,
    tunnel: false
  }
]
