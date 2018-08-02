require 'spec_helper.rb'

describe service('mysql') do
    it { should be_enabled }
    it { should be_running }
end

describe command('mysql --version') do
    its(:stdout) { should match /10.3.8-MariaDB/ }
end
