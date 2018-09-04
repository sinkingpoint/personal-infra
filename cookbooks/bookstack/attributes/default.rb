override['nginx']['servers'] = [
  {
    name: 'wiki.sinkingpoint.com',
    port: 8080
  }
]

default['bookstack']['db']['password'] = 'meep'
