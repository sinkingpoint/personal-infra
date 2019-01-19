group 'prometheus' do
  gid 1080
  system true
  action :create
end

user 'prometheus' do
  uid 1080
  gid 1080
  shell '/sbin/nologin'
  system true
  manage_home false
  action :create
end

['docker'].each do | group_name |
  group group_name do
    members ['prometheus']
    append true
  end
end
