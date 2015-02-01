include_recipe 'phantomjs'

selenium_phantomjs 'selenium_phantomjs_nogrid' do
  username 'Administrator' if platform?('windows')
  password 'password' if platform?('windows')
  host 'localhost'
  port 8911
  hubHost false
  action :install
end
