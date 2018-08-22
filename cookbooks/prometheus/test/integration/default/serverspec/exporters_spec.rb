require 'spec_helper.rb'

describe command('docker ps -a') do
  its(:stdout) { should match /sinkingpoint\/utilities_exporter:master/ }
end
