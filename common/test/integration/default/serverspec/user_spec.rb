require 'spec_helper.rb'

describe user('colin') do
    it { should exist }
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
