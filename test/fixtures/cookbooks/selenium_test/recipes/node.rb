include_recipe 'apt' if platform?('ubuntu')
include_recipe 'yum' if platform_family?('rhel')
include_recipe 'java'

include_recipe 'xvfb' unless platform?('windows')

capabilities = []
platform = platform?('windows') ? 'WINDOWS' : 'LINUX'

unless platform?('debian')
  include_recipe 'firefox'
  capabilities <<  {
    browserName: 'firefox',
    maxInstances: 5,
    version: firefox_version,
    platform: platform,
    seleniumProtocol: 'WebDriver'
  }
end

unless platform_family?('rhel') && node['platform_version'] == '6.5'
  include_recipe 'chrome'
  capabilities <<  {
    browserName: 'chrome',
    maxInstances: 5,
    version: chrome_version,
    platform: platform,
    seleniumProtocol: 'WebDriver'
  }
end

# TODO: get ie version in a way that is friendly with chefspec
# ie_version = Registry.get_value('HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer', 'svcVersion')
if platform?('windows')
  capabilities <<  {
    browserName: 'internet explorer',
    maxInstances: 1,
    # version: ie_version,
    platform: platform,
    seleniumProtocol: 'WebDriver'
  }
end

capabilities <<  {
  browserName: 'htmlunit',
  maxInstances: 1,
  platform: 'ANY',
  seleniumProtocol: 'WebDriver'
}

selenium_node 'selenium_node' do
  username 'Administrator' if platform?('windows')
  password 'password' if platform?('windows')
  capabilities capabilities
  action :install
end
