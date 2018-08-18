directory '/opt/db/scripts' do
    recursive true
end

template '/opt/db/scripts/backup_db.sh' do
    source 'backup_db.sh.erb'
    mode 0700
    variables ({
        root_password: node['mariadb']['server_root_password']
    })
end

cron 'backup_db' do
    command '/opt/db/scripts/backup_db.sh && date +%s > /opt/db/last_backup.txt'
    hour '0'
    minute '30'
end
