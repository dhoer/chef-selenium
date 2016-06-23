include_recipe 'java_se'

include_recipe 'xvfb' unless platform?('windows', 'mac_os_x')

capabilities = []

capabilities << {
  browserName: 'htmlunit',
  maxInstances: 1,
  seleniumProtocol: 'WebDriver'
}

unless platform?('debian')
  include_recipe 'mozilla_firefox'
  capabilities << {
    browserName: 'firefox',
    maxInstances: 5,
    version: firefox_version,
    seleniumProtocol: 'WebDriver'
  }
end

node.set['selenium']['node']['capabilities'] = capabilities
node.set['selenium']['node']['username'] = node['selenium_test']['username']
node.set['selenium']['node']['password'] = node['selenium_test']['password']

include_recipe 'selenium::node'

if platform?('windows')
  # Call windows_display after selenium_node because windows_display will
  # override auto-login created by selenium_node.
  node.set['windows_screenresolution']['username'] = node['selenium_test']['username']
  node.set['windows_screenresolution']['password'] = node['selenium_test']['password']
  node.set['windows_screenresolution']['width'] = 1440
  node.set['windows_screenresolution']['height'] = 900

  # Meets windows password policy requirements for a new user
  node.set['windows_screenresolution']['rdp_password'] = 'S6M;b.v+{DTYAQW4'

  include_recipe 'windows_screenresolution'
end
