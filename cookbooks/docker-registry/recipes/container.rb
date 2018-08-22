docker_service 'default' do
  group 'docker'
  action [:create, :start]
end

docker_image 'registry' do
  repo 'registry'
  tag '2'
  action :pull
end

docker_container 'bookstack' do
  repo 'registry'
  tag '2'
  port '8080:5000'
  env [
    'REGISTRY_STORAGE=s3',
    'REGISTRY_STORAGE_S3_REGION=eu-west-2',
    "REGISTRY_STORAGE_S3_BUCKET=#{node['docker-registry']['bucket']}"
  ]
end
