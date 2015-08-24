selenium_node node['selenium']['node']['service_name'] do
  host node['selenium']['node']['host']
  port node['selenium']['node']['port']
  jvm_args node['selenium']['node']['jvm_args']
  proxy node['selenium']['node']['proxy']
  maxSession node['selenium']['node']['maxSession']
  register node['selenium']['node']['register']
  registerCycle node['selenium']['node']['registerCycle']
  hubPort node['selenium']['node']['hubPort']
  hubHost node['selenium']['node']['hubHost']
  capabilities node['selenium']['node']['capabilities']
  additional_args node['selenium']['node']['additional_args']
  display node['selenium']['node']['display']
  domain node['selenium']['node']['domain']
  username node['selenium']['node']['username']
  password node['selenium']['node']['password']
  action :install
end
