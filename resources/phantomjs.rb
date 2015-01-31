actions :install
default_action :install

attribute :name, kind_of: String, name_attribute: true
attribute :host, kind_of: String, default: node['ipaddress']
attribute :port, kind_of: Integer, default: 8910
attribute :hubPort, kind_of: Integer, default: 4444
attribute :hubHost, kind_of: String, default: node['ipaddress']

# attribute :webdriver, kind_of: String, default: '127.0.0.1:8910'
# attribute :webdriverSeleniumGridHub, kind_of: String, default: 'http://127.0.0.1:4444'
attribute :cookiesFile, kind_of: String, default: nil
attribute :diskCacheEnabled, kind_of: [TrueClass, FalseClass], default: false
attribute :ignoreSslErrors, kind_of: [TrueClass, FalseClass], default: false
attribute :autoLoadImages, kind_of: [TrueClass, FalseClass], default: true
attribute :offlineStoragePath, kind_of: String, default: nil
attribute :offlineStorageDefaultQuota, kind_of: String, default: nil
attribute :localToRemoteUrlAccessEnabled, kind_of: [TrueClass, FalseClass], default: false
attribute :maxDiskCacheSize, kind_of: Integer, default: 1000 # in KB
attribute :outputEncoding, kind_of: String, default: 'utf8'
attribute :remoteDebuggerPort, kind_of: Integer, default: nil
attribute :remoteDebuggerAutorun, kind_of: [TrueClass, FalseClass], default: false
attribute :proxy, kind_of: String, default: nil # e.g. 192.168.1.42:8080
attribute :proxyType, kind_of: String, default: 'http', equal_to: %w(http socks5 none)
attribute :proxyAuth, kind_of: String, default: nil # e.g. username:password
attribute :scriptEncoding, kind_of: String, default: 'utf8'
attribute :sslProtocol, kind_of: String, default: 'sslv3', equal_to: %w(sslv3 sslv2 tlsv1 any)
attribute :sslCertificatesPath, kind_of: String, default: nil
attribute :webSecurityEnabled, kind_of: [TrueClass, FalseClass], default: true # forbids cross-domain XHR

# windows only
attribute :domain, kind_of: String, default: nil
attribute :username, kind_of: String, default: nil
attribute :password, kind_of: String, default: nil
