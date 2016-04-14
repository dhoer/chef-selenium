case node[:platform_family]
when 'debian'
  # selenium-webdriver includes ffi which requires the following dependencies
  package 'gcc' do
    action :nothing
  end.run_action(:install)
  package 'libffi-dev' do
    action :nothing
  end.run_action(:install)
when 'rhel'
  # selenium-webdriver includes ffi which requires the following dependencies
  package 'gcc'
  package 'libffi-devel'
end
