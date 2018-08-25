require 'spec_helper.rb'

describe file('/opt/grafana/scripts/backup_db.sh') do
  it { should exist }
  it { should be_executable }
  it { should be_file }
  its(:content) { should match /#!\/bin\/bash/ }
end

describe file('/opt/grafana/scripts/restore_db.sh') do
  it { should exist }
  it { should be_executable }
  it { should be_file }
  its(:content) { should match /#!\/bin\/bash/ }
end