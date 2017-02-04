if platform?('windows')
  # Call windows_screenresolution after selenium_node because windows_screenresolution
  # will override auto-login created by selenium_node.
  node.override['windows_screenresolution']['username'] = node['selenium_test']['username']
  node.override['windows_screenresolution']['password'] = node['selenium_test']['password']
  node.override['windows_screenresolution']['width'] = 1440
  node.override['windows_screenresolution']['height'] = 900

  # Meets windows password policy requirements for a new user
  node.override['windows_screenresolution']['rdp_password'] = 'S6M;b.v+{DTYAQW4'

  include_recipe 'windows_screenresolution'
end
