if platform_family?('mac_os_x')
  remote_file "#{Chef::Config[:file_cache_path]}/SafariDriver.safariextz" do
    source "#{node['selenium']['release_url']}/#{node['selenium']['safaridriver_version']}/SafariDriver.safariextz"
    checksum node['selenium']['safaridriver_checksum']
  end

  macosx_gui_login node['selenium']['safaridriver_username'] do
    password node['selenium']['safaridriver_password']
  end

  safari_extension 'SafariDriver Extension' do
    safariextz "#{Chef::Config[:file_cache_path]}/SafariDriver.safariextz"
  end
else
  log('SafariDriver cannot be installed on this platform using this cookbook!') { level :warn }
end
