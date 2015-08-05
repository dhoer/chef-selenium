package 'unzip' unless platform?('windows', 'mac_os_x')

dirs = %w(config drivers server)
dirs.push('bin', 'log') if platform?('windows')

dirs.each do |dir|
  directory "#{selenium_home}/#{dir}" do
    recursive true
    action :create
  end
end
