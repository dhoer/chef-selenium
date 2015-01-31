if platform_family?('windows')
  include_recipe 'selenium::default'

  version = node['selenium']['iedriver_version']
  iedriver_dir = "#{selenium_home}/drivers/iedriver-#{version}"

  directory iedriver_dir do
    action :create
  end

  bit = node['kernel']['machine'] == 'x86_64' ? 'x64' : 'Win32'

  windows_zipfile iedriver_dir do
    source "#{node['selenium']['release_url']}/"\
      "#{selenium_version(version)}/IEDriverServer_#{bit}_#{version}.zip"
    action :unzip
    not_if { ::File.exist?("#{iedriver_dir}/IEDriverServer.exe") }
  end

  link "#{selenium_home}/drivers/iedriver" do
    to iedriver_dir
  end
else
  log 'IEDriverServer cannot be installed on this platform using this cookbook.' do
    level :warn
  end
end
