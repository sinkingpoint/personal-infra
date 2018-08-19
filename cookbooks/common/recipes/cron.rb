cron 'deploy_changes' do
  command 'curl http://169.254.169.254/latest/user-data | bash'
  minute '*/5'
end
