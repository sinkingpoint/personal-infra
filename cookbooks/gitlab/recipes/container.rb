docker_service 'default' do
  group 'docker'
  action [:create, :start]
end

docker_image 'gitlab' do
  repo 'gitlab/gitlab-ce'
  tag 'latest'
  action :pull
end

mount_point = ::File.join(node['gitlab']['mount_point'], 'gitlab')

directory mount_point do
  user 998
  group 998
  recursive true
end

docker_container 'gitlab' do
  repo 'gitlab/gitlab-ce'
  tag 'latest'
  restart_policy 'always'
  port [
    ':5080:80',
    ':5443:443',
    ':5022:22'
  ]
  volumes [
    "#{::File.join(mount_point, 'config')}:/etc/gitlab:rw",
    "#{::File.join(mount_point, 'logs')}:/var/log/gitlab:rw",
    "#{::File.join(mount_point, 'data')}:/var/opt/gitlab:rw"
  ]
end
