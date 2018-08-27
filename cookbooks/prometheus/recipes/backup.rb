directory '/opt/prometheus/scripts' do
  recursive true
end

template '/opt/prometheus/scripts/backup_data.sh' do
  source 'backup_data.sh.erb'
  mode 0700
end

template '/opt/prometheus/scripts/restore_db.sh' do
  source 'restore_data.sh.erb'
  mode 0700
end

cron 'backup_db' do
  command '/opt/prometheus/scripts/backup_data.sh && date +%s > /opt/prometheus/last_backup.txt'
  hour '*'
  minute '30'
end
