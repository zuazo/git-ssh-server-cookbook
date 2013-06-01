
default['git-ssh-server']['base_path'] = nil # get from node['git']['server']['base_path']
default['git-ssh-server']['user'] = 'git'
default['git-ssh-server']['group'] = 'git'
default['git-ssh-server']['shell'] = '/usr/bin/git-shell'
default['git-ssh-server']['hostname'] = node['fqdn']

