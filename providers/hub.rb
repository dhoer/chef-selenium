def whyrun_supported?
  true
end

def host(resource)
  resource.host.nil? ? 'null' : resource.host
end

def port(resource)
  resource.port.nil? ? 4444 : resource.port
end

def config(resource)
  config_file = "#{selenium_home}/config/#{resource.name}.json"
  template config_file do
    source 'hub_config.erb'
    cookbook 'selenium'
    variables(
      host: host(resource),
      port: port(resource),
      resource: resource
    )
    notifies :restart, "service[#{resource.name}]" unless platform_family?('windows')
  end
  config_file
end

def windows_service(resource, args)
  log_file = "#{selenium_home}/log/#{resource.name}.log"
  nssm resource.name do
    program node['selenium']['windows']['java']
    args args.join(' ').gsub('"', '"""')
    params(
      AppDirectory: selenium_home,
      AppStdout: log_file,
      AppStderr: log_file,
      AppRotateFiles: 1
    )
    action :install
  end
  windows_firewall(resource.name, port(resource))
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
      windows_service(new_resource, args)
    else
      linux_service(new_resource.name, node['selenium']['linux']['java'], args, port(new_resource), nil)
    end
  end
end
