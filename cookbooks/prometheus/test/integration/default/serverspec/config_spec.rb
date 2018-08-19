require 'spec_helper.rb'

describe file('/opt/prometheus/prometheus.yml') do
  it { should exist }
  it { should be_file}
  its(:content) { should match /global:/ }
end