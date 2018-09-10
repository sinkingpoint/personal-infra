require 'spec_helper.rb'

describe user('jenkins') do
  it { should exist }
  it { should belong_to_group 'sudo' }
end

describe file('/home/jenkins') do 
  it { should exist }
  it { should be_directory }
end

describe file('/home/jenkins/.ssh') do 
  it { should exist }
  it { should be_directory }
end

describe file('/home/jenkins/.ssh/authorized_keys') do 
  it { should exist }
  it { should be_file }
  it { should be_mode 600 }
end