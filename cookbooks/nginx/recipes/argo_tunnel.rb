deb_file = ::File.join(Chef::Config['file_cache_path'], 'cloudflared.deb')
remote_file deb_file do
  source 'https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.deb'
  mode 0644
end

dpkg_package 'argotunnel' do
  source deb_file
  action :install
end

directory '/etc/cloudflared'

file '/etc/cloudflared/cert.pem' do
  content node['cloudflare']['argotunnel_creds']
end

services = node['nginx']['servers'] || []
services.each do |server|
  systemd_unit "#{server['name']}-argo-tunnel.service" do
    content <<-EOS
    [Unit]
    Description=Cloudflare Argo Tunnel for a Local service
    After=network.target

    [Service]
    ExecStart=/usr/local/bin/cloudflared --hostname #{server['name']} http://localhost:80
    Restart=always
    EOS

    action [:create, :enable, :start]
  end
end
