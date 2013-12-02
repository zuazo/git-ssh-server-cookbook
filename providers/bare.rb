
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
      cookbook_file "#{base_path}/#{name}.git/hooks/post-update" do
        source "post-update"
        cookbook "git-ssh-server"
        action :create_if_missing
        mode 0755
        user node['git-ssh-server']['user']
        group node['git-ssh-server']['group']
        only_if { new_resource.add_update_server_hook }
      end
    end
  end

end

