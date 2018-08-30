directory '/opt/prometheus/rules' do
  recursive true
  user 'nobody'
  group 'nogroup'
end

template '/opt/prometheus/rules/alerts.rules' do
  source 'alerts.rules.erb'
  user 'nobody'
  group 'nogroup'
end
