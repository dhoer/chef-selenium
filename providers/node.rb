def whyrun_supported?
  true
end

def config
  config_file = "#{selenium_home}/config/#{new_resource.name}.json"
  template config_file do
    source 'node_config.erb'
    cookbook 'selenium'
    variables(
      resource: new_resource
    )
    notifies :request_reboot, "reboot[Reboot to start #{new_resource.name}]", :delayed if platform_family?('windows')
    notifies :restart, "service[#{new_resource.name}]", :delayed unless platform_family?('windows', 'mac_os_x')
    notifies :run, "execute[reload #{mac_domain(new_resource.name)}]", :immediately if platform_family?('mac_os_x')
  end
  config_file
end

def args
  args = []
  args << new_resource.jvm_args unless new_resource.jvm_args.nil?
  args << %W(-jar "#{selenium_server_standalone}" -role node -nodeConfig "#{config}")

  if selenium_browser?(CHROME, new_resource.capabilities)
    chromedriver_path = "#{selenium_home}/drivers/chromedriver/chromedriver#{platform?('windows') ? '.exe' : ''}"
    args << %(-Dwebdriver.chrome.driver="#{chromedriver_path}")
  end

  if selenium_browser?(IE, new_resource.capabilities)
    iedriver_path = "#{selenium_home}/drivers/iedriver/IEDriverServer.exe"
    args << %(-Dwebdriver.ie.driver="#{iedriver_path}")
  end
  args.flatten!
end

def install_recipes
  recipe_eval do
    run_context.include_recipe 'selenium::server'
    run_context.include_recipe 'selenium::chromedriver' if selenium_browser?(CHROME, new_resource.capabilities)
    run_context.include_recipe 'selenium::iedriver' if selenium_browser?(IE, new_resource.capabilities)
  end
end

action :install do
  converge_by("Install Node Service: #{new_resource.name}") do
    install_recipes

    case node['platform']
    when 'windows'
      if new_resource.username && new_resource.password
        windows_foreground(new_resource.name, selenium_java_exec, args, new_resource.username)
        autologon(new_resource.username, new_resource.password, new_resource.domain)
      else
        windows_service(new_resource.name, selenium_java_exec, args)
      end
      windows_firewall(new_resource.name, new_resource.port)

      reboot "Reboot to start #{new_resource.name}" do
        delay_mins 1
        action :cancel # A hack for Chef 12.0.3 because it is missing action :nothing
      end
    when 'mac_os_x'
      plist = "/Library/LaunchAgents/#{mac_domain(new_resource.name)}.plist"
      mac_service(mac_domain(new_resource.name), selenium_java_exec, args, plist, new_resource.username)

      macosx_autologin new_resource.username do
        password new_resource.password
        restart_loginwindow false
      end

      reboot "Reboot to start #{mac_domain(new_resource.name)}" do
        delay_mins 1
        action :cancel # A hack for Chef 12.0.3 because it is missing action :nothing
      end
    else
      linux_service(new_resource.name, selenium_java_exec, args, new_resource.port, new_resource.display)
    end
  end
end
