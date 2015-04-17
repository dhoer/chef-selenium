include_recipe 'selenium_test::package'
include_recipe 'selenium_test::java'

selenium_node 'selenium_htmlunit' do
  port 5556
  capabilities [
    browserName: 'htmlunit',
    maxInstances: 1,
    platform: 'ANY',
    seleniumProtocol: 'WebDriver'
  ]
  action :install
end
