return if platform?('mac_os_x')

include_recipe 'phantomjs'

selenium_phantomjs 'selenium_phantomjs' do
  action :install
end
