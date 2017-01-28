include_recipe 'java_se'

include_recipe 'xvfb' unless platform?('windows', 'mac_os_x')

capabilities = []

include_recipe 'mozilla_firefox'

capabilities << {
  browserName: 'firefox',
  maxInstances: 5,
  version: firefox_version,
  seleniumProtocol: 'WebDriver'
}

# chrome not supported on rhel 6
if !(platform_family?('rhel') && node['platform_version'].split('.')[0] == '6')
  include_recipe 'chrome'
  include_recipe 'chromedriver'

  capabilities << {
    browserName: 'chrome',
    maxInstances: 5,
    version: chrome_version,
    seleniumProtocol: 'WebDriver'
  }
end

node.override['selenium']['node']['capabilities'] = capabilities
node.override['selenium']['node']['username'] = node['selenium_test']['username']
node.override['selenium']['node']['password'] = node['selenium_test']['password']

include_recipe 'selenium::node'
