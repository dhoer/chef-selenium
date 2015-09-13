username = platform?('windows', 'mac_os_x') ? 'vagrant' : nil
password = platform?('windows', 'mac_os_x') ? 'vagrant' : nil

include_recipe 'java_se'

include_recipe 'xvfb' unless platform?('windows', 'mac_os_x')

capabilities = []

capabilities << {
  browserName: 'htmlunit',
  maxInstances: 1,
  seleniumProtocol: 'WebDriver'
}

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
  include_recipe 'chromedriver'
  capabilities << {
    browserName: 'chrome',
    maxInstances: 5,
    version: chrome_version,
    seleniumProtocol: 'WebDriver'
  }
end

if platform?('mac_os_x')
  node.set['safaridriver']['username'] = username
  node.set['safaridriver']['password'] = password
  include_recipe 'safaridriver'
  capabilities << {
    browserName: 'safari',
    maxInstances: 2,
    version: safari_version,
    seleniumProtocol: 'WebDriver'
  }
end

if platform?('windows')
  include_recipe 'iedriver'
  capabilities << {
    browserName: 'internet explorer',
    maxInstances: 1,
    version: ie_version,
    seleniumProtocol: 'WebDriver'
  }
end

node.set['selenium']['node']['capabilities'] = capabilities
node.set['selenium']['node']['username'] = username
node.set['selenium']['node']['password'] = password

include_recipe 'selenium::node'

if platform?('windows')
  # Call windows_display after selenium_node because windows_display will
  # override auto-login created by selenium_node.
  node.set['windows_screenresolution']['username'] = username
  node.set['windows_screenresolution']['password'] = password
  node.set['windows_screenresolution']['width'] = 1440
  node.set['windows_screenresolution']['height'] = 900

  # Meets windows password policy requirements for a new user
  node.set['windows_screenresolution']['rdp_password'] = 'S6M;b.v+{DTYAQW4'

  include_recipe 'windows_screenresolution'
end
