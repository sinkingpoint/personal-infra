override['mariadb']['install']['version'] = '10.1'
override['mariadb']['server_root_password'] = 'changeme'
override['common']['runlist'] = 'common,db'
default['db']['listen_ip'] = (node['network']['interfaces']['eth0']['addresses'].select { |a, details| details[:family] == 'inet'}).keys[0]
default['db']['databases'] = [
    {
        name: 'wiki',
        password: '*061678EB0D19DA2B71FE6D30361DBB2C0A59EC94'
    }
]
