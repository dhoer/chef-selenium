include_recipe 'selenium_test::package'
include_recipe 'selenium_test::java'

selenium_hub 'selenium_hub' do
  action :install
end
