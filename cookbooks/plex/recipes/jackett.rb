docker_image 'linuxserver/jackett' do
  repo 'linuxserver/jackett'
  tag 'latest'
  action :pull
end

apps_mount_point = node['plex']['apps_mount_point']

docker_container 'jackett' do
  repo 'linuxserver/jackett'
  tag 'latest'
  port [
    '9117'
  ]
  network_mode 'plexnet'
  env ['PGID=1000', 'PUID=1000', 'TZ=Europe/London']
  volumes [
    "#{apps_mount_point}/jackett:/config"
  ]
end