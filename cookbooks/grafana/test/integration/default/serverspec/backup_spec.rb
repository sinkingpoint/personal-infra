describe file('/opt/grafana/scripts/backup.sh') do
  it { should exist }
  it { should be_executable }
  it { should be_file }
  its(:content) { should match /#!\/bin\/bash/ }
end