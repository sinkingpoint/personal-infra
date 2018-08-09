cron 'deploy_changes' do
    command "cd /opt/provision-repo && git pull origin master && /opt/chef-client -z -r #{node['common']['runlist']}"
    minute '*/5'
end
