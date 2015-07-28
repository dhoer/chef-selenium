case node[:platform_family]
when 'debian'
  execute 'sudo apt-get update' do
    action :nothing
  end.run_action(:run) # firefox runs at compile time and firefox package is not up to date on Ubuntu 14.04-1
when 'rhel'
  include_recipe 'yum'
when 'mac_os_x'
  include_recipe 'dmg'
  include_recipe 'homebrew'
end
