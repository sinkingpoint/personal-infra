docker_image 'linuxserver/ombi' do
  repo 'linuxserver/ombi'
  tag 'latest'
  action :pull
end

apps_mount_point = node['plex']['apps_mount_point']

docker_container 'jackett' do
  repo 'linuxserver/ombi'
  tag 'latest'
  port [
    ':3579:3579'
  ]
  network_mode 'up_plexnet'
  env ['PGID=1000', 'PUID=1000', 'TZ=Europe/London']
  volumes [
    "#{apps_mount_point}/ombi:/config:rw"
  ]
end