name 'selenium'
maintainer 'Dennis Hoer'
maintainer_email 'dennis.hoer@gmail.com'
license 'MIT'
description 'Installs/Configures Selenium'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '2.8.1'

supports 'centos'
supports 'redhat'
supports 'mac_os_x'
supports 'ubuntu'
supports 'windows'

suggests 'windows', '~> 1.0'
suggests 'nssm', '~> 1.0'
suggests 'macosx_autologin', '~> 2.0'

# required by safaridriver
suggests 'safari', '~> 1.0'
suggests 'macosx_gui_login', '~> 1.0'
