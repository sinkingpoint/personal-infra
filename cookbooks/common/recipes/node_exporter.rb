node_exporter 'main' do
  web_listen_address "#{node['exporters']['listen_ip']}:9100"
  collector_textfile_directory node['prometheus']['node_exporter']['dir']
  action [:enable, :start]
end
