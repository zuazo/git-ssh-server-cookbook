require_relative '../spec_helper'

describe 'git-ssh-server::default' do
  let(:base_path) { '/var/git_base_path' }
  let(:chef_runner) do
    ChefSpec::Runner.new do |node|
      node.set['git-ssh-server']['base_path'] = base_path
    end
  end
  let(:chef_run) do
    chef_runner.converge(described_recipe)
  end

  it 'should include git recipe' do
    expect(chef_run).to include_recipe('git')
  end

  it 'should install git package' do
    expect(chef_run).to install_package('git')
  end

  it 'should calculate base_path attribute when not set' do
    chef_runner.node.set['git-ssh-server']['base_path'] = nil
    chef_runner.node.set['git']['server']['base_path'] = base_path
    chef_runner.converge(described_recipe)
    expect(chef_runner.node['git-ssh-server']['base_path']).to eq(base_path)
  end

  it 'should not calculate base_path attribute when set' do
    chef_runner.node.set['git-ssh-server']['base_path'] = base_path # not needed
    chef_runner.node.set['git']['server']['base_path'] = 'base_path_ignored'
    chef_runner.converge(described_recipe)
    expect(chef_runner.node['git-ssh-server']['base_path']).to eq(base_path)
  end

  it 'should create git user' do
    expect(chef_run).to create_user('git').with(
      :comment => 'Git repository management user',
      :home => base_path,
      :shell => '/usr/bin/git-shell',
      :system => true
    )
  end

  it 'should create git group' do
    expect(chef_run).to create_group('git').with(
      :members => [ 'git' ],
      :system => true,
      :append => true
    )
  end

  it 'should create base path directory' do
    expect(chef_run).to create_directory(base_path).with(
      :owner => 'git',
      :group => 'git',
      :mode => '00750',
      :recursive => true
    )
  end

  it 'should create base path directory' do
    expect(chef_run).to create_directory("#{base_path}/git-shell-commands").with(
      :owner => 'git',
      :group => 'git',
      :mode => '00750',
      :recursive => true
    )
  end

  it 'should create a README.md file' do
    expect(chef_run).to create_template("#{base_path}/README.md").with(
      :owner => 'git',
      :group => 'git',
      :mode => '00640'
    )
  end

end
