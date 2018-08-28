docker_service 'default' do
  group 'docker'
  action [:create, :start]
end

docker_image 'jenkins' do
  repo 'jenkins/jenkins'
  tag 'lts-slim'
  action :pull
end

directory '/opt/jenkins/storage' do
  user 1000
  group 1000
  recursive true
end

docker_container 'prometheus' do
  repo 'jenkins/jenkins'
  tag 'lts-slim'
  port [
    '8080:8080',
    '50000:50000'
  ]
  
  volumes [
    '/opt/jenkins/storage:/var/jenkins_home'
  ]
end
