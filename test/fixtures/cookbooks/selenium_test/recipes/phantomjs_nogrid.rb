return if platform?('mac_os_x')

include_recipe 'phantomjs'

selenium_phantomjs 'selenium_phantomjs_nogrid' do
  username 'Administrator' if platform?('windows')
  password 'password' if platform?('windows')
  webdriver 'localhost:8911'
  webdriverSeleniumGridHub false
  action :install
end
