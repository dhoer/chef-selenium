actions :install
default_action :install

attribute :name, kind_of: String, name_attribute: true
attribute :webdriver, kind_of: String, default: node['selenium']['phantomjs']['webdriver']
attribute :webdriverSeleniumGridHub,
          kind_of: [String, FalseClass],
          default: node['selenium']['phantomjs']['webdriverSeleniumGridHub']

# TODO: Create a config.json file with these and ghostdriver attributes.
# attribute :cookiesFile, kind_of: String, default: nil
# attribute :diskCacheEnabled, kind_of: [TrueClass, FalseClass], default: false
# attribute :ignoreSslErrors, kind_of: [TrueClass, FalseClass], default: false
# attribute :autoLoadImages, kind_of: [TrueClass, FalseClass], default: true
# attribute :offlineStoragePath, kind_of: String, default: nil
# attribute :offlineStorageDefaultQuota, kind_of: String, default: nil
# attribute :localToRemoteUrlAccessEnabled, kind_of: [TrueClass, FalseClass], default: false
# attribute :maxDiskCacheSize, kind_of: Integer, default: 1000 # in KB
# attribute :outputEncoding, kind_of: String, default: 'utf8'
# attribute :remoteDebuggerPort, kind_of: Integer, default: nil
# attribute :remoteDebuggerAutorun, kind_of: [TrueClass, FalseClass], default: false
# attribute :proxy, kind_of: String, default: nil # e.g. 192.168.1.42:8080
# attribute :proxyType, kind_of: String, default: 'http', equal_to: %w(http socks5 none)
# attribute :proxyAuth, kind_of: String, default: nil # e.g. username:password
# attribute :scriptEncoding, kind_of: String, default: 'utf8'
# attribute :sslProtocol, kind_of: String, default: 'sslv3', equal_to: %w(sslv3 sslv2 tlsv1 any)
# attribute :sslCertificatesPath, kind_of: String, default: nil
# attribute :webSecurityEnabled, kind_of: [TrueClass, FalseClass], default: true # forbids cross-domain XHR

# windows only - set username/password to run service in gui or leave nil to run service in background
attribute :domain, kind_of: String, default: node['selenium']['phantomjs']['domain']
attribute :username, kind_of: String, default: node['selenium']['phantomjs']['username']
attribute :password, kind_of: String, default: node['selenium']['phantomjs']['password']
