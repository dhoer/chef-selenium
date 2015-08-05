include_recipe 'xvfb' unless platform?('windows', 'mac_os_x')

capabilities = []

unless platform?('debian')
  include_recipe 'firefox'
  capabilities << {
    browserName: 'firefox',
    maxInstances: 5,
    version: firefox_version,
    seleniumProtocol: 'WebDriver'
  }
end

unless platform_family?('rhel') && node['platform_version'].split('.')[0] == '6'
  include_recipe 'chrome'
  capabilities << {
    browserName: 'chrome',
    maxInstances: 5,
    version: chrome_version,
    seleniumProtocol: 'WebDriver'
  }
end

if platform?('mac_os_x')
  capabilities << {
    browserName: 'safari',
    maxInstances: 2,
    version: safari_version,
    seleniumProtocol: 'WebDriver'
  }
end

if platform?('windows')
  # https://code.google.com/p/selenium/wiki/InternetExplorerDriver#Required_Configuration
  major_version = ie_version.split('.')[0].to_i

  # For IE 11 only, you will need to set a registry entry on the target computer so that the driver can maintain a
  # connection to the instance of Internet Explorer it creates.
  include_recipe 'ie::bfcache' if major_version >= 11

  include_recipe 'ie::esc' # disable annoying enhanced security configuration

  include_recipe 'ie::firstrun' if major_version == 9 || major_version == 8 # disable first run setup pop-up

  # On IE 7 or higher, you must set the Protected Mode settings for each zone to be the same value.
  # The value can be on or off, as long as it is the same or every zone.
  if major_version >= 7
    node.set['ie']['zone']['internet'] = {
      '1400' => 0, # enable active scripting
      '2500' => 0 # enable protected mode
    }

    node.set['ie']['zone']['local_internet'] = {
      '2500' => 0 # enable protected mode
    }

    node.set['ie']['zone']['trusted_sites'] = {
      '2500' => 0 # enable protected mode
    }

    node.set['ie']['zone']['restricted_sites'] = {
      '2500' => 0 # enable protected mode
    }

    include_recipe 'ie::zone'
  end

  include_recipe 'ie::zoom' # set zoom level to 100%

  capabilities << {
    browserName: 'internet explorer',
    maxInstances: 1,
    version: ie_version,
    seleniumProtocol: 'WebDriver'
  }
end

if platform?('windows', 'mac_os_x')
  username = 'vagrant'
  password = 'vagrant'
else
  username = nil
  password = nil
end

selenium_node 'selenium_node' do
  username username
  password password
  capabilities capabilities
  action :install
end

if platform?('windows')
  # Call windows_display after selenium_node because windows_display will override auto-login created by
  # selenium_node.
  node.set['windows_screenresolution']['username'] = username
  node.set['windows_screenresolution']['password'] = password
  node.set['windows_screenresolution']['width'] = 1440
  node.set['windows_screenresolution']['height'] = 900

  # meets windows password policy requirements for a new user
  node.set['windows_screenresolution']['rdp_password'] = 'S6M;b.v+{DTYAQW4'

  include_recipe 'windows_screenresolution::default'
end
