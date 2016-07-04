# selenium-webdriver includes ffi which requires the following dependencies
case node[:platform_family]
when 'debian'
  %w(gcc libffi-dev make).each do |pkg|
    package pkg do
      action :nothing
    end.run_action(:install)
  end
when 'rhel', 'fedora'
  %w(gcc libffi-devel make).each do |pkg|
    package pkg
  end
end
