# TODO: refactor when mac supported version of java cookbook is released
case node[:platform_family]
when 'windows'
  node.set['java']['install_flavor'] = 'windows'
  include_recipe 'java'
when 'mac_os_x'
  # node.set['java']['install_flavor'] = 'homebrew'
  include_recipe 'homebrew::cask'
  homebrew_cask 'java'
else
  include_recipe 'java'
end

# include_recipe 'java'
