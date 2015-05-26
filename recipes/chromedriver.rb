include_recipe 'selenium::default'

bit = node['kernel']['machine'] == 'x86_64' && !platform?('windows') ? '64' : '32'
os = platform?('windows') ? 'win' : 'linux'
version = node['selenium']['chromedriver_version']

name = "chromedriver_#{os}#{bit}-#{version}"
driver_path = "#{selenium_home}/drivers/#{name}"
cache_path = "#{Chef::Config[:file_cache_path]}/#{name}.zip"

src = "#{node['selenium']['chromedriver_url']}/#{version}/chromedriver_#{os}#{bit}.zip"
link = "#{selenium_home}/drivers/chromedriver"

directory driver_path do
  action :create
end

# Fixes #10: windows_zipfile rubyzip failure to allocate memory (requires PowerShell 3 or greater & .NET Framework 4)
begin
  batch 'unzip chromedriver' do
    code "powershell.exe -nologo -noprofile -command \"& { Add-Type -A 'System.IO.Compression.FileSystem';"\
      " [IO.Compression.ZipFile]::ExtractToDirectory('#{cache_path}', '#{driver_path}'); }\""
    action :nothing
  end
rescue # cheesy attempt at backward compatibility
  windows_zipfile driver_path do
    source cache_path
    action :unzip
  end
end

execute 'unzip chromedriver' do
  command "unzip -o #{cache_path} -d #{driver_path}"
  action :nothing
end

remote_file 'download chromedriver' do
  path cache_path
  source src
  use_etag true
  use_conditional_get true
  notifies :run, 'batch[unzip chromedriver]', :immediately if platform?('windows')
  notifies :run, 'execute[unzip chromedriver]', :immediately unless platform?('windows')
end

link link do
  to driver_path
end
