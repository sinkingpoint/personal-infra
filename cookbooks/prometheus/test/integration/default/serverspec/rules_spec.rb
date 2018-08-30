describe file('/opt/prometheus/rules/alerts.rules') do
  it { should exist }
  it { should be_file }
end