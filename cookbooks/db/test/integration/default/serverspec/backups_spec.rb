require 'spec_helper.rb'

describe file('/opt/db/scripts') do
    it { should exist }
    it { should be_directory }
end

describe file('/opt/db/scripts/backup_db.sh') do
    it { should exist }
    it { should be_file }
    its(:content) { should match /#!\/bin\/bash/ }
end

describe file('/opt/db/scripts/restore_db.sh') do
    it { should exist }
    it { should be_file }
    its(:content) { should match /#!\/bin\/bash/ }
end

describe cron do
  its(:table) { should match  /\/opt\/db\/scripts\/backup_db.sh/ }
end