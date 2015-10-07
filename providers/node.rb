def whyrun_supported?
  true
end

def config
  config_file = "#{selenium_home}/config/#{new_resource.servicename}.json"
  template config_file do
    source 'node_config.erb'
    cookbook 'selenium'
    variables(
      resource: new_resource
    )
    notifies :request, "windows_reboot[Reboot to start #{new_resource.servicename}]",
             :delayed if platform_family?('windows')
    notifies :restart, "service[#{new_resource.servicename}]", :delayed unless platform_family?('windows', 'mac_os_x')
    notifies :run, "execute[reload #{selenium_mac_domain(new_resource.servicename)}]",
             :immediately if platform_family?('mac_os_x')
  end
  config_file
end

def args
  args = []
  args << new_resource.jvm_args unless new_resource.jvm_args.nil?
  args << %W(-jar "#{selenium_jar_link}" -role node -nodeConfig "#{config}")

  new_resource.additional_args.each do |arg|
    args << arg
  end

  args.flatten!
end

def selenium_include_recipes
  recipe_eval do
    run_context.include_recipe 'selenium::default'
    run_context.include_recipe 'windows::reboot_handler' if platform_family?('windows')
  end
end

action :install do
  converge_by("Install Node Service: #{new_resource.servicename}") do
    selenium_include_recipes

    case node['platform']
    when 'windows'
      selenium_windows_gui_service(new_resource.servicename, selenium_java_exec, args, new_resource.username)
      selenium_autologon(new_resource.username, new_resource.password, new_resource.domain)

      selenium_windows_firewall(new_resource.servicename, new_resource.port)

      windows_reboot "Reboot to start #{new_resource.servicename}" do
        reason "Reboot to start #{new_resource.servicename}"
        timeout node['windows']['reboot_timeout']
        action :nothing
      end
    when 'mac_os_x'
      if new_resource.username && new_resource.password
        plist = "/Library/LaunchAgents/#{selenium_mac_domain(new_resource.servicename)}.plist"
      else
        plist = "/Library/LaunchDaemons/#{selenium_mac_domain(new_resource.servicename)}.plist"
      end

      selenium_mac_service(
        selenium_mac_domain(new_resource.servicename), selenium_java_exec, args, plist, new_resource.username)
      selenium_autologon(new_resource.username, new_resource.password)

      execute "Reboot to start #{selenium_mac_domain(new_resource.servicename)}" do
        command 'sudo shutdown -r +1'
        action :nothing
      end
    else
      selenium_linux_service(
        new_resource.servicename, selenium_java_exec, args, new_resource.port, new_resource.display)
    end
  end
end
