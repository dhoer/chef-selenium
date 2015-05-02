include_recipe 'selenium::default'

bit = node['kernel']['machine'] == 'x86_64' && !platform?('windows') ? '64' : '32'
os = platform?('windows') ? 'win' : 'linux'
dir = "#{selenium_home}/drivers/chromedriver_#{os}#{bit}-#{node['selenium']['chromedriver_version']}"

directory dir do
  action :create
end

src = "#{node['selenium']['chromedriver_url']}/#{node['selenium']['chromedriver_version']}/chromedriver_#{os}#{bit}.zip"
link = "#{selenium_home}/drivers/chromedriver"

if platform_family?('windows')
  zip = "#{Chef::Config[:file_cache_path]}/chromedriver_#{os}#{bit}.zip"

  remote_file zip do
    source src
    not_if { ::File.exist?("#{link}/chromedriver.exe") }
  end

  # Fixes #10: windows_zipfile rubyzip failure to allocate memory (requires PowerShell 3 or greater & .NET Framework 4)
  begin
    batch 'unzip chrome driver' do
      code "powershell.exe -nologo -noprofile -command \"& { Add-Type -A 'System.IO.Compression.FileSystem';"\
        " [IO.Compression.ZipFile]::ExtractToDirectory('#{zip}', '#{dir}'); }\""
      not_if { ::File.exist?("#{link}/chromedriver.exe") }
    end
  rescue # cheesy attempt at backward compatibility
    windows_zipfile dir do
      source zip
      action :unzip
      not_if { ::File.exist?("#{link}/chromedriver.exe") }
    end
  end
else # linux
  cache = "#{Chef::Config[:file_cache_path]}/chromedriver_linux#{bit}-#{node['selenium']['chromedriver_version']}.zip"

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
