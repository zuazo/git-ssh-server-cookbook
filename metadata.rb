name             "git-repo"
maintainer       "Onddo Labs, Sl."
maintainer_email "team@onddo.com"
license          "Apache 2.0"
description      "Installs/Configures git-repo"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

depends 'git'

%w{ amazon arch centos debian fedora redhat scientific oracle amazon ubuntu windows }.each do |os|
  supports os
end

supports "mac_os_x", ">= 10.6.0"

