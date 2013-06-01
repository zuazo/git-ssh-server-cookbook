
def whyrun_supported?
  true
end

action :create do
  name = new_resource.name.sub(/[.]git$/, '')
  base_path = new_resource.base_path || node['git-ssh-server']['base_path']

  converge_by("Create #{new_resource}") do
    execute "git init --bare #{name}" do
      command "git init --bare '#{base_path}/#{name}.git'"
      user node['git-ssh-server']['user']
      group node['git-ssh-server']['group']
      not_if do ::File.exists?("#{base_path}/#{name}.git/.git") end
    end
  end

end

