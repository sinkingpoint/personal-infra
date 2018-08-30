require 'spec_helper.rb'

describe file('/opt/prometheus/scripts/backup_data.sh') do
  it { should exist }
  it { should be_file }
  it { should be_executable.by_user('root') }
  its(:content) { should match /#!\/bin\/bash/ }
end

describe file('/opt/prometheus/scripts/restore_db.sh') do
  it { should exist }
  it { should be_file }
  it { should be_executable.by_user('root') }
  its(:content) { should match /#!\/bin\/bash/ }
end