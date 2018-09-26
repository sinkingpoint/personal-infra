docker_image 'linuxserver/sonarr' do
  repo 'linuxserver/sonarr'
  tag 'latest'
  action :pull
end

apps_mount_point = node['plex']['apps_mount_point']
media_mount_point = node['plex']['media_mount_point']

docker_container 'sonarr' do
  repo 'linuxserver/sonarr'
  tag 'latest'
  port [
    '7878'
  ]
  network_mode 'plexnet'
  env ['PGID=1000', 'PUID=1000', 'TZ=Europe/London']
  volumes [
    "#{apps_mount_point}/sonarr:/config",
    "#{media_mount_point}/Downloads/completed:/data/completed",
    "#{media_mount_point}/TV Shows:/tv"
  ]
end