case node[:platform_family]
when 'debian'
  # firefox runs at compile time and firefox package is not up to date on Ubuntu
  execute 'sudo apt-get update' do
    action :nothing
  end.run_action(:run)
when 'rhel'
  # firefox runs at compile time and firefox package is not up to date on CentOS
  execute 'yum update -y' do
    action :nothing
  end.run_action(:run)
end
