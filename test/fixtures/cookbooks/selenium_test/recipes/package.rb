case node[:platform_family]
when 'debian', 'rhel'
  # selenium-webdriver includes ffi which requires the following dependencies
  %w(gcc libffi-dev make).each do |pkg|
    package pkg do
      action :nothing
    end.run_action(:install)
  end
end
