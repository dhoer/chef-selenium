def whyrun_supported?
  true
end

# TODO: Get configuration file working and add ghostdriver parameters as well
def config(resource)
  config_file = "#{selenium_home}/config/#{resource.name}.json"
  template config_file do
    source 'phantomjs_config.erb'
    cookbook 'selenium'
    variables(
      resource: resource
    )
    notifies :request, "windows_reboot[Reboot to start #{resource.name}]" if platform_family?('windows')
    notifies :restart, "service[#{resource.name}]" unless platform_family?('windows')
  end
  config_file
end

action :install do
  converge_by("Install PhantomJS Service: #{new_resource.name}") do
    # args = [%(--config="#{config(new_resource)}")]
    args = []
    args << "--webdriver=#{new_resource.host}:#{new_resource.port}"
    args << "--webdriver-selenium-grid-hub=http://#{new_resource.hubHost}:#{new_resource.hubPort}"

    if platform?('windows')
      windows_foreground(new_resource.name, node['selenium']['windows']['phantomjs'], args, new_resource.username)
      autologon(new_resource.username, new_resource.password, new_resource.domain)
      windows_firewall(new_resource.name, new_resource.port)
    else
      linux_service(new_resource.name, node['selenium']['linux']['phantomjs'], args, new_resource.port, nil)
    end

    windows_reboot "Reboot to start #{new_resource.name}" do
      reason "Reboot to start #{new_resource.name}"
      timeout node['windows']['reboot_timeout']
      action :nothing
      only_if { platform_family?('windows') }
    end
  end
end
