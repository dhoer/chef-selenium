case node[:platform_family]
when 'debian'
  # firefox runs at compile time and firefox package is not up to date on Ubuntu 14.04-1
  execute 'sudo apt-get update' do
    action :nothing
  end.run_action(:run)

  # selenium-webdriver includes ffi which requires the following dependencies
  package 'gcc' do
    action :nothing
  end.run_action(:install)
  package 'libffi-dev' do
    action :nothing
  end.run_action(:install)
when 'rhel'
  execute 'sudo yum update' do
    action :nothing
  end.run_action(:run)

  # selenium-webdriver includes ffi which requires the following dependencies
  package 'gcc'
  package 'libffi-devel'

  # docker centos throws: no such file or directory - /sbin/service
  package 'initscripts'
end
