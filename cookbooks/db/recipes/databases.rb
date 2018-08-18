::Chef::Recipe.send(:include, HashedPassword::Helper)
node['db']['databases'].each do |database|
    mariadb_database database['name'] do
        password node['mariadb']['server_root_password']
        action :create
    end

    password = hashed_password(database['password'])
    mariadb_user "#{database['name']} user" do
        name database['name']
        password password
        database_name database['name']
        ctrl_password node['mariadb']['server_root_password']
        action :create
    end

    mariadb_user "#{database['name']} permissions" do
        name database['name']
        password password
        database_name database['name']
        privileges [:select, :insert, :update, :delete]
        ctrl_password node['mariadb']['server_root_password']
        host '%'
        action :grant
    end
end
