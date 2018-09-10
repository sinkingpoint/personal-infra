directory '/opt/grafana/scripts' do
  recursive true
end

template '/opt/grafana/scripts/backup_db.sh' do
  source 'backup.sh.erb'
  mode '0700'
  variables ({
    prometheus_textfile_dir: node['prometheus']['node_exporter']['dir'],
    backups_bucket: node['backups']['s3_bucket']
  })
end

template '/opt/grafana/scripts/restore_db.sh' do
  source 'restore.sh.erb'
  mode '0700'
end

cron 'backup_db' do
  command '/opt/grafana/scripts/backup.sh && date +%s > /opt/grafana/last_backup.txt'
  hour '*/2'
  minute '30'
end
