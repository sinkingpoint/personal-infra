mariadb_repository 'Maria Apt Repo' do
    version '10.3'
end

mariadb_server_install 'MariaDB Server install' do
    version '10.3'
    notifies :start, 'service[mysql]'
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
