::Chef::Recipe.send(:include, HashedPassword::Helper)
node['db']['databases'].each do |database|
    mariadb_database database['name'] do
        action :create
    end

    password = hashed_password(database['password'])
    mariadb_user "#{database['name']} user" do
        name database['name']
        password password
        database_name database['name']
        action :create
    end

    mariadb_user "#{database['name']} permissions" do
        name database['name']
        database_name database['name']
        privileges [:select, :insert, :update, :delete]
        action :grant
    end

    mariadb_database "#{database['name']}-access" do
      sql "grant all on *.* to '#{database['name']}'@'%';"
      action :query
    end
end
