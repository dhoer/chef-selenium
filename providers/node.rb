def whyrun_supported?
  true
end

def config(resource)
  config_file = "#{selenium_home}/config/#{resource.name}.json"
  template config_file do
    source 'node_config.erb'
    cookbook 'selenium'
    variables(
      resource: resource
    )
    notifies :request, "windows_reboot[Reboot to start #{resource.name}]" if platform_family?('windows')
    notifies :restart, "service[#{resource.name}]" unless platform_family?('windows')
  end
  config_file
end

def install_recipes(resource)
  recipe_eval do
    run_context.include_recipe 'selenium::server'
    run_context.include_recipe 'selenium::chromedriver' if selenium_chromedriver?(resource.capabilities)
    run_context.include_recipe 'selenium::iedriver' if selenium_iedriver?(resource.capabilities)
    run_context.include_recipe 'windows::reboot_handler' if platform_family?('windows')
  end
end

action :install do
  converge_by("Install Node Service: #{new_resource.name}") do
    install_recipes(new_resource)

    args = []
    args << new_resource.jvm_args unless new_resource.jvm_args.nil?
    args << %(-jar "#{selenium_server_standalone}" -role node -nodeConfig "#{config(new_resource)}")

    if selenium_chromedriver?(new_resource.capabilities)
      chromedriver_path = "#{selenium_home}/drivers/chromedriver/chromedriver#{platform?('windows') ? '.exe' : ''}"
      args << %(-Dwebdriver.chrome.driver="#{chromedriver_path}")
    end

    if selenium_iedriver?(new_resource.capabilities)
      iedriver_path = "#{selenium_home}/drivers/iedriver/IEDriverServer.exe"
      args << %(-Dwebdriver.ie.driver="#{iedriver_path}")
    end

    case node[:platform]
    when 'windows'
      if new_resource.username && new_resource.password
        windows_foreground(new_resource.name, selenium_java_exec, args, new_resource.username)
        autologon(new_resource.username, new_resource.password, new_resource.domain)
      else
        windows_service(new_resource.name, selenium_java_exec, args)
      end
      windows_firewall(new_resource.name, new_resource.port)

      windows_reboot "Reboot to start #{new_resource.name}" do
        reason "Reboot to start #{new_resource.name}"
        timeout node['windows']['reboot_timeout']
        action :nothing
      end
    when 'mac_os_x'
      # TODO: Add mac_service that uses launchd
    else
      linux_service(new_resource.name, selenium_java_exec, args, new_resource.port, new_resource.display)
    end
  end
end
