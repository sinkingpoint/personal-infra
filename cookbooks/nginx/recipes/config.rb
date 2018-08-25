services = node['nginx']['servers'] || []
services.each do | service |
  template "/etc/nginx/sites-available/#{service['name']}.conf" do
    source 'nginx-conf.erb'
    variables ({
      server_name: service['name'],
      listen_port: service['port']
    })
  end

  link "/etc/nginx/sites-enabled/#{service['name']}" do
    to "/etc/nginx/sites-available/#{service['name']}.conf"
  end
end