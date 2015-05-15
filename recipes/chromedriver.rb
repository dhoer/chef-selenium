include_recipe 'selenium::default'

bit = '32'
case node['platform']
when 'windows'
  os = 'win'
when 'mac_os_x'
  os = 'mac'
else
  os = 'linux'
  bit = '64' if node['kernel']['machine'] == 'x86_64'
end

dir = "#{selenium_home}/drivers/chromedriver_#{os}#{bit}-#{node['selenium']['chromedriver_version']}"

directory dir do
  action :create
end

src = "#{node['selenium']['chromedriver_url']}/#{node['selenium']['chromedriver_version']}/chromedriver_#{os}#{bit}.zip"
link = "#{selenium_home}/drivers/chromedriver"

if platform_family?('windows')
  cache = "#{Chef::Config[:file_cache_path]}/chromedriver_#{os}#{bit}.zip"

  remote_file cache do
    source src
    not_if { ::File.exist?("#{link}/chromedriver.exe") }
  end

  # Fixes #10: windows_zipfile rubyzip failure to allocate memory (requires PowerShell 3 or greater & .NET Framework 4)
  begin
    batch 'unzip chrome driver' do
      code "powershell.exe -nologo -noprofile -command \"& { Add-Type -A 'System.IO.Compression.FileSystem';"\
        " [IO.Compression.ZipFile]::ExtractToDirectory('#{cache}', '#{dir}'); }\""
      not_if { ::File.exist?("#{link}/chromedriver.exe") }
    end
  rescue # cheesy attempt at backward compatibility
    windows_zipfile dir do
      source cache
      action :unzip
      not_if { ::File.exist?("#{link}/chromedriver.exe") }
    end
  end
else # linux/mac
  cache = "#{Chef::Config[:file_cache_path]}/chromedriver_#{os}#{bit}-#{node['selenium']['chromedriver_version']}.zip"

  execute 'unpack chromedriver' do
    command "unzip -o #{cache} -d #{dir}"
    action :nothing
  end

  remote_file cache do
    source src
    action :create
    notifies :run, 'execute[unpack chromedriver]', :immediately
  end
end

link link do
  to dir
end
