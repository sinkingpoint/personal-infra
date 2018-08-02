mariadb_repository 'Maria Apt Repo' do
    version '10.3'
end

mariadb_server_install 'MariaDB Server install' do
      version '10.3'
end
