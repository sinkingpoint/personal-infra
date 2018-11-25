services = node['nginx']['servers'] || []

service 'nginx' do
  action :nothing
end

template '/etc/nginx/proxy.conf' do
  source 'proxy-conf.erb'
end

services.each do | service |
  template "/etc/nginx/sites-available/#{service['name']}.conf" do
    source 'nginx-conf.erb'
    variables ({
      server_name: service['name'],
      listen_port: service['port']
    })
    notifies :reload, 'service[nginx]'
  end

  link "/etc/nginx/sites-enabled/#{service['name']}" do
    to "/etc/nginx/sites-available/#{service['name']}.conf"
    notifies :reload, 'service[nginx]'
  end
end