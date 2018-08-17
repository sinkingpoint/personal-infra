require 'spec_helper.rb'

describe user('colin') do
  it { should exist }
  it { should belong_to_group 'sudo' }
end

describe file('/home/colin') do 
  it { should exist }
  it { should be_directory }
end

describe file('/home/colin/.ssh') do 
  it { should exist }
  it { should be_directory }
end

describe file('/home/colin/.ssh/authorized_keys') do 
  it { should exist }
  it { should be_file }
  it { should be_mode 600 }
end

describe file ('/etc/sudoers') do
  it { should exist }
  it { should be_file }
  its(:content) { should match /%sudo   ALL=\(ALL:ALL\) NOPASSWD:ALL/ }
end
