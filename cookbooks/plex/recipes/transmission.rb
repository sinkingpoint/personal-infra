docker_image 'haugene/transmission-openvpn' do
  repo 'haugene/transmission-openvpn'
  tag 'latest'
  action :pull
end

media_mount_point = node['plex']['media_mount_point']

docker_container 'transmission' do
  repo 'haugene/transmission-openvpn'
  tag 'latest'
  port [
    '9091'
  ]
  privileged true
  cap_add 'NET_ADMIN'
  network_mode 'plexnet'
  env [
    "OPENVPN_PROVIDER=#{node['transmission']['vpn']['provider']}",
    "OPENVPN_CONFIG=#{node['transmission']['vpn']['config']}",
    "OPENVPN_USERNAME=#{node['transmission']['vpn']['username']}",
    "OPENVPN_PASSWORD=#{node['transmission']['vpn']['password']}",
    "OPENVPN_OPTS=#{node['transmission']['vpn']['options']}",
    'PGID=1000',
    'PUID=1000',
  ]
  volumes [
    "#{media_mount_point}/Downloads:/data",
    '/etc/localtime:/etc/localtime:ro'
  ]
end