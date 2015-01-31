include_recipe 'phantomjs'

selenium_phantomjs 'selenium_phantomjs' do
  username 'Administrator' if platform?('windows')
  password 'password' if platform?('windows')
  action :install
end
