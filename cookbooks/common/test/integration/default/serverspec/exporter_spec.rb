require 'spec_helper.rb'

describe service('node_exporter_main') do
  it { should be_running }
  it { should be_enabled }
end

describe port(9100) do
  it { should be_listening }
end