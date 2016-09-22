include_recipe 'java_se'

include_recipe 'xvfb' unless platform?('windows', 'mac_os_x')

capabilities = []

unless platform?('debian')
  include_recipe 'mozilla_firefox'
  capabilities << {
    browserName: 'firefox',
    maxInstances: 5,
    version: firefox_version,
    seleniumProtocol: 'WebDriver'
  }
end

node.override['selenium']['node']['capabilities'] = capabilities
node.override['selenium']['node']['username'] = node['selenium_test']['username']
node.override['selenium']['node']['password'] = node['selenium_test']['password']

include_recipe 'selenium::node'

if platform?('windows')
  # Call windows_display after selenium_node because windows_display will
  # override auto-login created by selenium_node.
  node.override['windows_screenresolution']['username'] = node['selenium_test']['username']
  node.override['windows_screenresolution']['password'] = node['selenium_test']['password']
  node.override['windows_screenresolution']['width'] = 1440
  node.override['windows_screenresolution']['height'] = 900

  # Meets windows password policy requirements for a new user
  node.override['windows_screenresolution']['rdp_password'] = 'S6M;b.v+{DTYAQW4'

  include_recipe 'windows_screenresolution'
end
