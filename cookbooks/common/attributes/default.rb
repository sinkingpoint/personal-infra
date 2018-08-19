default['common']['packages'] = [
  'vim',
  'sudo',
  'zsh',
  'openssh-server',
  'curl',
  'wget',
  'git'
]

default['common']['users'] = [
  {
    name: 'colin',
    shell: '/usr/bin/zsh',
    ssh_keys: [
      'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCzny7ZShOnUZMDgFKeyTFB3+uUX2sLS+PWBW5WhgolI3Z4Cdn7xFPYR6WlaAtHj06ddvWFCUnwDEro21mSNSKXrrfYKGqkHRP1ooA5QpIHLgz9+FHbAxe28adKSymQYi7+Drs+NOQws2icIHei1NX2pcUSI0aBNAuZSzdHURQvWpqr63qpZr2ecASK+C+rrz/+7TRSw2mmu8VVEptSpoQEZ/cf/iBUPHDWaW3osD3hIWNsbgdTVT6AaquoCYKRunU1sw9faNphwYIx46IvM2h5JtaOn/Kn7ocnXbiaaG/vqp1AxAtMbAWYMwXZvcsvC+vtX2E2wv9/AvIaB6mo+PuT colin@anatinus'
    ]
  }
]

default['exporters']['listen_ip'] = (node['network']['interfaces']['eth0']['addresses'].select { |a, details| details[:family] == 'inet'}).keys[0]