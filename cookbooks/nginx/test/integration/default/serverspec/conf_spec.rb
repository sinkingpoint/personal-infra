require 'spec_helper.rb'

describe file('/etc/nginx/sites-available/cats.lan.conf') do 
  it { should exist }
  it { should be_file }
  its(:content) { should match /server_name cats.lan/}
end

describe file('/etc/nginx/sites-available/dogs.lan.conf') do 
  it { should exist }
  it { should be_file }
  its(:content) { should match /server_name dogs.lan/}
end