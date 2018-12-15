docker_image 'cadvisor' do
  repo 'google/cadvisor'
  tag 'latest'
end

docker_container 'cadvisor' do
  repo 'google/cadvisor'
  tag 'latest'
  port [
    ':8080:8080'
  ]
  volumes [
    "/:/rootfs:ro",
    "/var/run:/var/run:ro",
    "/sys:/sys:ro",
    "/var/lib/docker:/var/lib/docker:ro",
    "/dev/disk:/dev/disk:ro"
  ]
end