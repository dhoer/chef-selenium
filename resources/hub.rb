actions :install
default_action :install

attribute :name, kind_of: String, name_attribute: true
attribute :host, kind_of: String, default: 'null'
attribute :port, kind_of: Integer, default: 4444
attribute :jvm_args, kind_of: String, default: nil
attribute :newSessionWaitTimeout, kind_of: Integer, default: -1
attribute :servlets, kind_of: Array, default: []
attribute :prioritizer, kind_of: [Class, String, Symbol], default: 'null'
attribute :capabilityMatcher, kind_of: String, default: 'org.openqa.grid.internal.utils.DefaultCapabilityMatcher'
attribute :throwOnCapabilityNotPresent, kind_of: [TrueClass, FalseClass], default: true
attribute :nodePolling, kind_of: Integer, default: 5000
attribute :cleanUpCycle, kind_of: Integer, default: 5000
attribute :timeout, kind_of: Integer, default: 30_000
attribute :browserTimeout, kind_of: Integer, default: 0
attribute :maxSession, kind_of: Integer, default: 5
attribute :jettyMaxThreads, kind_of: Integer, default: -1
