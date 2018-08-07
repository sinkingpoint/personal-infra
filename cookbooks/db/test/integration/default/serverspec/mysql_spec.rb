require 'spec_helper.rb'

describe service('mysql') do
    it { should be_enabled }
    it { should be_running }
end

describe command('mysql --version') do
    its(:stdout) { should match /10.3.8-MariaDB/ }
end

describe file('/etc/mysql/my.cnf') do
    it { should exist }
    it { should be_file }
    its(:content) { should match /bind-address=[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/ }
end
