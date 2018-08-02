require 'spec_helper.rb'

describe package('vim') do
      it { should be_installed }
end

describe package('zsh') do
      it { should be_installed }
end

describe package('openssh-server') do
      it { should be_installed }
end

describe service('sshd') do
    it { should be_running }
    it { should be_enabled }
end
