if platform?('windows')
  include_recipe 'selenium::default'

  version = node['selenium']['iedriver_version']
  iedriver_dir = "#{selenium_home}/drivers/iedriver-#{version}"

  directory iedriver_dir do
    action :create
  end

  bit = node['kernel']['machine'] == 'x86_64' ? 'x64' : 'Win32'
  zip = "#{Chef::Config[:file_cache_path]}/IEDriverServer_#{bit}_#{version}.zip"

  # Fixes #10: windows_zipfile rubyzip failure to allocate memory (requires PowerShell 3 or greater & .NET Framework 4)
  batch 'unzip iedriver' do
    code "powershell.exe -nologo -noprofile -command \"& { Add-Type -A 'System.IO.Compression.FileSystem';"\
      " [IO.Compression.ZipFile]::ExtractToDirectory('#{zip}', '#{iedriver_dir}'); }\""
    action :nothing
    only_if { powershell_version >= 3 }
  end

  windows_zipfile iedriver_dir do
    source zip
    action :nothing
    not_if { powershell_version >= 3 }
  end

  remote_file zip do
    source "#{node['selenium']['release_url']}/#{selenium_version(version)}/IEDriverServer_#{bit}_#{version}.zip"
    not_if { ::File.exist?("#{iedriver_dir}/IEDriverServer.exe") }
    notifies :run, 'batch[unzip iedriver]', :immediately if platform?('windows')
    notifies :unzip, "windows_zipfile[#{iedriver_dir}]", :immediately if platform?('windows')
  end

  link "#{selenium_home}/drivers/iedriver" do
    to iedriver_dir
  end
else
  log 'IEDriverServer cannot be installed on this platform using this cookbook!' do
    level :warn
  end
end
