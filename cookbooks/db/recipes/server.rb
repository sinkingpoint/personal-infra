mariadb_repository 'Maria Apt Repo' do
    version '10.3'
end

mariadb_server_install 'MariaDB Server install' do
    version '10.3'
    notifies :start, 'service[mysql]'
    password node['mariadb']['server_root_password']
    action [:install, :create]
    not_if "service --status-all | grep -Fq 'mysql' && mysql -u root -p#{node['mariadb']['server_root_password']}"
end

service 'mysql' do
    action :nothing
end

template '/etc/mysql/my.cnf' do
    source 'my.cnf.erb'
    variables ({
        listen_ip: node['db']['listen_ip']
    })
    notifies :restart, 'service[mysql]'
end
