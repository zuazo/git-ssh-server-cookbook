name             'git-ssh-server'
maintainer       'Onddo Labs, Sl.'
maintainer_email 'team@onddo.com'
license          'Apache 2.0'
description      'Set up a basic git repository container to be accesed via ssh'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.2'

depends 'git', '>= 2.2.0'

%w{ amazon arch centos debian fedora redhat scientific oracle amazon ubuntu windows }.each do |os|
  supports os
end

supports 'mac_os_x', '>= 10.6.0'

recipe 'git-ssh-server::default', 'Configures a git repository container'

provides 'git_ssh_server_bare'
provides 'git_ssh_server_ssh_key'
# Commented until 11.0.10 server release (CHEF-3976)
# provides 'git_ssh_server_bare[name]'
# provides 'git_ssh_server_ssh_key[keyname]'

attribute 'git-ssh-server/base_path',
  :display_name => 'Base path',
  :description => 'Git server base path',
  :calculated => true,
  :type => 'string',
  :required => 'optional'

attribute 'git-ssh-server/user',
  :display_name => 'System user',
  :description => 'System user used to manage the repositories',
  :type => 'string',
  :required => 'optional',
  :default => '"git"'

attribute 'git-ssh-server/group',
  :display_name => 'System group',
  :description => 'System group used to manage the repositories',
  :type => 'string',
  :required => 'optional',
  :default => '"git"'

attribute 'git-ssh-server/shell',
  :display_name => 'Git user shell',
  :description => 'Git user shell',
  :type => 'string',
  :required => 'optional',
  :default => '"/usr/bin/git-shell"'

attribute 'git-ssh-server/hostname',
  :display_name => 'Machine hostname',
  :description => 'Machine hostname, used only in the README template',
  :calculated => true,
  :type => 'string',
  :required => 'recommended'

