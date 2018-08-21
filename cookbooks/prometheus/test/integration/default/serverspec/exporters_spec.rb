describe file('/opt/prometheus-exporters') do
  it { should exist }
  it { should be_directory }
end