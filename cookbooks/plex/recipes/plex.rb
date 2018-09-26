docker_image 'linuxserver/plex' do
  repo 'linuxserver/plex'
  tag 'latest'
  action :pull
end

plex_mount_point = node['plex']['plex_mount_point']
media_mount_point = node['plex']['media_mount_point']

docker_container 'plex' do
  repo 'linuxserver/plex'
  tag 'latest'
  port [
    ':32400:32400',
    ':1900:1900',
    ':3005:3005',
    ':5353:5353',
    ':8324:8324',
    ':32410:32410',
    ':32412:32412',
    ':32413:32413',
    ':32414:32414',
    ':32469:32469'
  ]
  network_mode 'host'
  env ['PGID=100', 'PUID=1026', 'TZ=Europe/London', 'VERSION=latest']
  volumes [
    "#{plex_mount_point}/config:/config:rw",
    "#{plex_mount_point}/logs:/config/Library/Application Support/Plex Media Server/Logs:rw",
    "#{media_mount_point}:/data:rw",
    "#{plex_mount_point}/transcode:/transcode:rw"
  ]
end