name             'git-repo'
maintainer       'Onddo Labs, Sl.'
maintainer_email 'team@onddo.com'
license          'Apache 2.0'
description      'Configures a basic git repository container to be accesed through ssh'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'

depends 'git'

%w{ amazon arch centos debian fedora redhat scientific oracle amazon ubuntu windows }.each do |os|
  supports os
end

supports 'mac_os_x', '>= 10.6.0'

recipe 'git-repo::default', 'Configures a git repository container'

provides 'git_repo_bare[name]'
provides 'git_repo_ssh_key[keyname]'

attribute 'git-repo/base_path',
  :display_name => 'Base path',
  :description => 'Git server base path',
  :calculated => true,
  :type => 'string',
  :required => 'optional'

attribute 'git-repo/user',
  :display_name => 'System user',
  :description => 'System user used to manage the repositories',
  :type => 'string',
  :required => 'optional',
  :default => 'git'

attribute 'git-repo/group',
  :display_name => 'System group',
  :description => 'System group used to manage the repositories',
  :type => 'string',
  :required => 'optional',
  :default => 'git'

attribute 'git-repo/shell',
  :display_name => 'Git user shell',
  :description => 'Git user shell',
  :type => 'string',
  :required => 'optional',
  :default => '/usr/bin/git-shell'

attribute 'git-repo/hostname',
  :display_name => 'Machine hostname',
  :description => 'Machine hostname, used only in the README template',
  :calculated => true,
  :type => 'string',
  :required => 'recommended'

