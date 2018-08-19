node_exporter 'main' do
  web_listen_address "#{node['exporters']['listen_ip']}:9100"
  action [:enable, :start]
end
