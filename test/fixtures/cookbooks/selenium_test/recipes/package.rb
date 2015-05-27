case node[:platform_family]
when 'debian'
  # include_recipe 'apt'
when 'rhel'
  include_recipe 'yum'
when 'mac_os_x'
  include_recipe 'dmg'
  include_recipe 'homebrew'
end
