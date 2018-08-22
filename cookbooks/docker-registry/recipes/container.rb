docker_service 'default' do
  group 'docker'
  action [:create, :start]
end

# We use ocasta/docker-registry here because the upstream
# docker registry image doesn't support eu-west-2 as a region
# yet. https://github.com/docker/distribution-library-image/issues/63

docker_image 'registry' do
  repo 'ocasta/docker-registry'
  tag 'master'
  action :pull
end

docker_container 'ocasta/docker-registry' do
  repo 'ocasta/docker-registry'
  tag 'master'
  port '8080:5000'
  env [
    'REGISTRY_STORAGE=s3',
    'REGISTRY_STORAGE_S3_REGION=eu-west-2',
    "REGISTRY_STORAGE_S3_BUCKET=#{node['docker-registry']['bucket']}"
  ]
end
