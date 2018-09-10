node['jenkins']['users'] .each do |user|
  home_dir = ::File.join('/home', user['name'])
  user user['name'] do
    shell user['shell']
    home home_dir
    manage_home true
  end

  directory ::File.join(home_dir, '.ssh')

  file ::File.join(home_dir, '.ssh', 'authorized_keys') do
    content user['ssh_keys'].join('\n')
    mode 0600
    owner user['name']
    group user['name']
  end
end

group 'sudo' do
  members node['jenkins']['users'].map { |user| user['name'] }
  action :modify
  append true
end