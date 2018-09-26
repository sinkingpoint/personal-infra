docker_image 'linuxserver/radarr' do
  repo 'linuxserver/radarr'
  tag 'latest'
  action :pull
end

apps_mount_point = node['plex']['apps_mount_point']
media_mount_point = node['plex']['media_mount_point']

docker_container 'radarr' do
  repo 'linuxserver/radarr'
  tag 'latest'
  port [
    ':7878:7878'
  ]
  network_mode 'up_plexnet'
  env ['PGID=1000', 'PUID=1000', 'TZ=Europe/London']
  volumes [
    "#{media_mount_point}/Downloads/completed:/data/completed:rw",
    "#{media_mount_point}/Movies:/movies:rw",
    "#{apps_mount_point}/radarr:/config:rw"
  ]
end