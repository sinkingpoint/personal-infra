docker_image 'tautulli/tautulli' do
  repo 'tautulli/tautulli'
  tag 'latest'
  action :pull
end

plex_mount_point = node['plex']['plex_mount_point']

docker_container 'plexpy' do
  repo 'tautulli/tautulli'
  tag 'latest'
  port [
    ':8181:8181'
  ]
  network_mode 'up_plexnet'
  env ['PGID=100', 'PUID=1026', 'TZ=Europe/London']
  volumes [
    "#{plex_mount_point}/logs:/logs:rw",
    "#{plex_mount_point}/config:/config:rw"
  ]
end