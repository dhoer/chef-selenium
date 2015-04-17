include_recipe 'selenium_test::package'
include_recipe 'selenium_test::java'
include_recipe 'xvfb' unless platform?('windows')

capabilities = []
platform = platform?('windows') ? 'WINDOWS' : 'LINUX'

unless platform?('debian')
  include_recipe 'firefox'
  capabilities << {
    browserName: 'firefox',
    maxInstances: 5,
    version: firefox_version,
    platform: platform,
    seleniumProtocol: 'WebDriver'
  }
end

unless platform_family?('rhel') && node['platform_version'].split('.')[0] == '6'
  include_recipe 'chrome'
  capabilities << {
    browserName: 'chrome',
    maxInstances: 5,
    version: chrome_version,
    platform: platform,
    seleniumProtocol: 'WebDriver'
  }
end

if platform?('windows')
  # TODO: get IE driver required configuration to work
  # # https://code.google.com/p/selenium/wiki/InternetExplorerDriver#Required_Configuration
  # node.set['ie']['enhanced_security_configuration'] = false
  # include_recipe 'ie::enhanced_security_configuration'
  #
  # major_version = ie_version.split('.')[0].to_i
  #
  # # On IE 7 or higher, you must set the Protected Mode settings for each zone to be the same value.
  # # The value can be on or off, as long as it is the same or every zone.
  # if major_version >= 7
  #   node.set['ie']['zone']['internet'] = { '2500' => 0, '1400' => 0 } # enable both protected mode and javascript
  #   include_recipe 'ie::security_zones'
  # end
  #
  # # For IE 11 only, you will need to set a registry entry on the target computer so that the driver can maintain a
  # # connection to the instance of Internet Explorer it creates.
  # if major_version >= 11
  #   node.set['ie']['feature_bfcache'] = true
  #   include_recipe 'ie::feature_bfcache'
  # end

  capabilities << {
    browserName: 'internet explorer',
    maxInstances: 1,
    version: ie_version,
    platform: platform,
    seleniumProtocol: 'WebDriver'
  }
end

selenium_node 'selenium_node' do
  username 'Administrator' if platform?('windows')
  password 'password' if platform?('windows')
  capabilities capabilities
  jvm_args '-Xms1024m'
  action :install
end

if platform?('windows')
  # Call windows_display after selenium_node because windows_display will override auto-login created by
  # selenium_node.
  windows_display 'Administrator' do
    password 'password'
    width 1440
    height 900
  end
end
