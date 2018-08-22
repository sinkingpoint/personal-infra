require 'spec_helper.rb'

describe command('docker ps -a') do
  its(:stdout) { should match /registry:2/ }
end