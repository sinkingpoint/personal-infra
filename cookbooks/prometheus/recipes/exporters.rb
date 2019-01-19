docker_image 'cadvisor' do
  repo 'google/cadvisor'
  tag 'latest'
end

docker_container 'cadvisor' do
  repo 'google/cadvisor'
  tag 'latest'
  port [
    ':9101:8080'
  ]
  volumes [
    "/:/rootfs:ro",
    "/var/run:/var/run:ro",
    "/sys:/sys:ro",
    "/var/lib/docker:/var/lib/docker:ro",
    "/dev/disk:/dev/disk:ro"
  ]
end

textfile_collector_dir = node['prometheus']['node_exporter']['dir'] || '/opt/textfile_collectors'

directory ::File.join(textfile_collector_dir, 'scripts') do
  user 'prometheus'
  group 'prometheus'
  action :create
  recursive true
end

directory ::File.join(textfile_collector_dir, 'metrics') do
  user 'prometheus'
  group 'prometheus'
  action :create
  recursive true
end

node['prometheus']['textfile_collectors'].each do | file |
  script_name = file.chomp('.erb')
  template ::File.join(textfile_collector_dir, 'scripts', script_name) do
    user 'prometheus'
    group 'prometheus'
    mode 0755
    source file
  end

  cron ('collect_' + file) do
    user 'prometheus'
    command "#{::File.join(textfile_collector_dir, 'scripts', script_name)} > #{::File.join(textfile_collector_dir, 'metrics', script_name + '.prom')}"
  end
end
