node['common']['packages'].each do |package_name|
  package package_name
end

service 'sshd' do 
  action :start
end
