def whyrun_supported?
  true
end

def config(resource)
  config_file = "#{selenium_home}/config/#{resource.name}.json"
  template config_file do
    source 'hub_config.erb'
    cookbook 'selenium'
    variables(
      resource: resource
    )
    notifies :restart, "service[#{resource.name}]" unless platform_family?('windows')
  end
  config_file
end

def include_recipes
  recipe_eval do
    run_context.include_recipe 'selenium::server'
  end
end

action :install do
  converge_by("Install Hub Service: #{new_resource.name}") do
    include_recipes

    args = []
    args << new_resource.jvm_args unless new_resource.jvm_args.nil?
    args << %(-jar "#{selenium_server_standalone}" -role hub -hubConfig "#{config(new_resource)}")

    if platform?('windows')
      windows_service(new_resource.name, selenium_java_exec, args)
      windows_firewall(new_resource.name, new_resource.port)
    else
      linux_service(new_resource.name, selenium_java_exec, args, new_resource.port, nil)
    end
  end
end
