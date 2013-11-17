
require 'chef/mixin/shell_out'
include Chef::Mixin::ShellOut

def whyrun_supported?
  true
end

action :create do
  name = new_resource.name.sub(/[.]git$/, '')
  base_path = new_resource.base_path || node['git-ssh-server']['base_path']

  unless shell_out("git rev-parse --resolve-git-dir '#{base_path}/#{name}.git' > /dev/null 2>&1", {}).status.success?
    converge_by("Create #{new_resource}") do
      execute "git init --bare #{name}" do
        command "git init --bare '#{base_path}/#{name}.git'"
        user node['git-ssh-server']['user']
        group node['git-ssh-server']['group']
      end
    end
  end

end

