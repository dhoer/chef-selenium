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
