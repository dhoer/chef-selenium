actions :install
default_action :install

attribute :name, kind_of: String, name_attribute: true
attribute :host, kind_of: String, default: node['selenium']['node']['host']
attribute :port, kind_of: Integer, default: node['selenium']['node']['port']
attribute :jvm_args, kind_of: String, default: node['selenium']['node']['jvm_args']
attribute :proxy, kind_of: String, default: node['selenium']['node']['proxy']
attribute :maxSession, kind_of: Integer, default: node['selenium']['node']['maxSession']
attribute :register, kind_of: [TrueClass, FalseClass], default: node['selenium']['node']['register']
attribute :registerCycle, kind_of: Integer, default: node['selenium']['node']['registerCycle']
attribute :hubPort, kind_of: Integer, default: node['selenium']['node']['hubPort']
attribute :hubHost, kind_of: String, default: node['selenium']['node']['hubHost']
attribute :capabilities, kind_of: [Array, Hash], default: node['selenium']['node']['capabilities']
attribute :additional_args, kind_of: [Array, Hash], default: node['selenium']['node']['additional_args']

# linux only - DISPLAY must match running instance of Xvfb, x11vnc or equivalent
attribute :display, kind_of: String, default: node['selenium']['node']['display']

# windows only
attribute :domain, kind_of: String, default: node['selenium']['node']['domain']

# mac/windows only - set username/password to run service in gui or leave nil to run service in background
attribute :username, kind_of: String, default: node['selenium']['node']['username']
attribute :password, kind_of: String, default: node['selenium']['node']['password']
