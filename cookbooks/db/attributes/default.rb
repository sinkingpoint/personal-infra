override['mariadb']['install']['version'] = '10.1'
override['mariadb']['server_root_password'] = 'changeme'
default['db']['databases'] = [
    {
        name: 'wiki',
        password: '*061678EB0D19DA2B71FE6D30361DBB2C0A59EC94'
    }
]
