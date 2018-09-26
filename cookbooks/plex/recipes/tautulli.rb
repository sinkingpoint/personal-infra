docker_image 'tautulli/tautulli' do
  repo 'tautulli/tautulli'
  tag 'latest'
  action :pull
end

plex_mount_point = node['plex']['plex_mount_point']

docker_container 'tautulli' do
  repo 'tautulli/tautulli'
  tag 'latest'
  port [
    '8181'
  ]
  network_mode 'plexnet'
  env ['PGID=1000', 'PUID=1000', 'TZ=Europe/London']
  volumes [
    "#{plex_mount_point}/config:/config",
    "#{plex_mount_point}/logs:/logs:ro"
  ]
end