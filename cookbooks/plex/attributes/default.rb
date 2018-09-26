default['plex']['plex_mount_point'] = '/opt/plex'
default['plex']['apps_mount_point'] = '/opt/apps'
default['plex']['media_mount_point'] = '/opt/media'

default['transmission']['vpn']['provider'] = 'NORDVPN'
default['transmission']['vpn']['config'] = 'uk379.nordvpn.com.tcp'
default['transmission']['vpn']['username'] = 'nota'
default['transmission']['vpn']['password'] = 'realpassword'
default['transmission']['vpn']['options'] = '--inactive 3600 --ping 10 --ping-exit 60'