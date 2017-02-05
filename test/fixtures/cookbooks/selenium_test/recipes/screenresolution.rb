if platform?('windows')
  # Call windows_screenresolution after selenium_node because windows_screenresolution
  # will override auto-login created by selenium_node.
  windows_screenresolution node['selenium_test']['username'] do
    password node['selenium_test']['password']
    width 1440
    height 900
    rdp_password 'S6M;b.v+{DTYAQW4' # Meets windows password policy requirements for a new user
  end
end
