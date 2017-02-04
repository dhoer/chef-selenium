include_recipe 'java_se'

include_recipe 'xvfb' unless platform?('windows', 'mac_os_x')

capabilities = []

include_recipe 'mozilla_firefox'
include_recipe 'geckodriver'

capabilities << {
  browserName: 'firefox',
  maxInstances: 5,
  version: firefox_version,
  seleniumProtocol: 'WebDriver'
}

node.override['selenium']['node']['capabilities'] = capabilities
node.override['selenium']['node']['username'] = node['selenium_test']['username']
node.override['selenium']['node']['password'] = node['selenium_test']['password']

include_recipe 'selenium::node'
