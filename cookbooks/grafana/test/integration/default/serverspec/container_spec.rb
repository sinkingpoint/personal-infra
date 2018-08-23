require 'spec_helper.rb'

describe service('docker') do
  it { should be_enabled }
  it { should be_running }
end

describe command('docker ps -a') do
  its(:stdout) { should match /grafana\/grafana:5.2.3/ }
end
