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
    notifies :request, "windows_reboot[Reboot to start #{new_resource.name}]", :delayed if platform_family?('windows')
    notifies :restart, "service[#{new_resource.name}]", :delayed unless platform_family?('windows', 'mac_os_x')
    notifies :run, "execute[reload #{mac_domain(new_resource.name)}]", :immediately if platform_family?('mac_os_x')
  end
  config_file
end

# rubocop:disable Metrics/AbcSize
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

  new_resource.additional_args.each do |arg|
    args << arg
  end

  args.flatten!
end
# rubocop:enable Metrics/AbcSize

# rubocop:disable Metrics/AbcSize
def selenium_include_recipes
  recipe_eval do
    run_context.include_recipe 'selenium::server'
    run_context.include_recipe 'selenium::chromedriver' if selenium_browser?(CHROME, new_resource.capabilities)
    run_context.include_recipe 'selenium::iedriver' if selenium_browser?(IE, new_resource.capabilities)
    if selenium_browser?(SAFARI, new_resource.capabilities)
      node.set['selenium']['safaridriver_username'] = new_resource.username
      node.set['selenium']['safaridriver_password'] = new_resource.password
      run_context.include_recipe 'selenium::safaridriver'
    end
    run_context.include_recipe 'windows::reboot_handler' if platform_family?('windows')
  end
end
# rubocop:enable Metrics/AbcSize

action :install do
  converge_by("Install Node Service: #{new_resource.name}") do
    selenium_include_recipes

    case node['platform']
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
      if new_resource.username && new_resource.password
        plist = "/Library/LaunchAgents/#{mac_domain(new_resource.name)}.plist"
      else
        plist = "/Library/LaunchDaemons/#{mac_domain(new_resource.name)}.plist"
      end

      mac_service(mac_domain(new_resource.name), selenium_java_exec, args, plist, new_resource.username)
      autologon(new_resource.username, new_resource.password)

      execute "Reboot to start #{mac_domain(new_resource.name)}" do
        command 'sudo shutdown -r +1'
        action :nothing
      end
    else
      linux_service(new_resource.name, selenium_java_exec, args, new_resource.port, new_resource.display)
    end
  end
end
