def whyrun_supported?
  true
end

def config
  config_file = "#{selenium_home}/config/#{new_resource.servicename}.json"
  template config_file do
    source 'hub_config.erb'
    cookbook 'selenium'
    variables(
      resource: new_resource
    )
    notifies :restart, "service[#{new_resource.servicename}]", :delayed unless platform_family?('windows', 'mac_os_x')
    notifies :run, "execute[reload #{mac_domain(new_resource.servicename)}]",
             :immediately if platform_family?('mac_os_x')
  end
  config_file
end

def args
  args = []
  args << new_resource.jvm_args unless new_resource.jvm_args.nil?
  args << %W(-jar "#{selenium_jar_link}" -role hub -hubConfig "#{config}")
  args.flatten!
end

def install_recipes
  recipe_eval do
    run_context.include_recipe 'selenium::default'
  end
end

action :install do
  converge_by("Install Hub Service: #{new_resource.servicename}") do
    install_recipes

    case node['platform']
    when 'windows'
      windows_service(new_resource.servicename, selenium_java_exec, args)
      windows_firewall(new_resource.servicename, new_resource.port)
    when 'mac_os_x'
      plist = "/Library/LaunchDaemons/#{mac_domain(new_resource.servicename)}.plist"
      mac_service(mac_domain(new_resource.servicename), selenium_java_exec, args, plist, nil)
    else
      linux_service(new_resource.servicename, selenium_java_exec, args, new_resource.port, nil)
    end
  end
end
