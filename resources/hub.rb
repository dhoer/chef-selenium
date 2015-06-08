actions :install
default_action :install

attribute :name, kind_of: String, name_attribute: true
attribute :host, kind_of: String, default: node['selenium']['hub']['host']
attribute :port, kind_of: Integer, default: node['selenium']['hub']['port']
attribute :jvm_args, kind_of: String, default: node['selenium']['hub']['jvm_args']
attribute :newSessionWaitTimeout, kind_of: Integer, default: node['selenium']['hub']['newSessionWaitTimeout']
attribute :servlets, kind_of: Array, default: node['selenium']['hub']['servlets']
attribute :prioritizer, kind_of: [Class, String, Symbol], default: node['selenium']['hub']['prioritizer']
attribute :capabilityMatcher, kind_of: String, default: node['selenium']['hub']['capabilityMatcher']
attribute :throwOnCapabilityNotPresent,
          kind_of: [TrueClass, FalseClass],
          default: node['selenium']['hub']['throwOnCapabilityNotPresent']
attribute :nodePolling, kind_of: Integer, default: node['selenium']['hub']['nodePolling']
attribute :cleanUpCycle, kind_of: Integer, default: node['selenium']['hub']['cleanUpCycle']
attribute :timeout, kind_of: Integer, default: node['selenium']['hub']['timeout']
attribute :browserTimeout, kind_of: Integer, default: node['selenium']['hub']['browserTimeout']
attribute :maxSession, kind_of: Integer, default: node['selenium']['hub']['maxSession']
attribute :jettyMaxThreads, kind_of: Integer, default: node['selenium']['hub']['jettyMaxThreads']
