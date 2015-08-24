selenium_hub node['selenium']['hub']['service_name'] do
  host node['selenium']['hub']['host']
  port node['selenium']['hub']['port']
  jvm_args node['selenium']['hub']['jvm_args']
  newSessionWaitTimeout node['selenium']['hub']['newSessionWaitTimeout']
  servlets node['selenium']['hub']['servlets']
  prioritizer node['selenium']['hub']['prioritizer']
  capabilityMatcher node['selenium']['hub']['capabilityMatcher']
  throwOnCapabilityNotPresent node['selenium']['hub']['throwOnCapabilityNotPresent']
  nodePolling node['selenium']['hub']['nodePolling']
  cleanUpCycle node['selenium']['hub']['cleanUpCycle']
  timeout node['selenium']['hub']['timeout']
  browserTimeout node['selenium']['hub']['browserTimeout']
  maxSession node['selenium']['hub']['maxSession']
  jettyMaxThreads node['selenium']['hub']['jettyMaxThreads']
  action :install
end
