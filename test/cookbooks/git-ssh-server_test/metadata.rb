name             'git-ssh-server_test'
maintainer       'Onddo Labs, Sl.'
maintainer_email 'team@onddo.com'
license          'Apache 2.0'
description 'This cookbook is used with test-kitchen to test the parent, '\
            'git-ssh-server cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'git-ssh-server'

