name 'selenium'
maintainer 'Dennis Hoer'
maintainer_email 'dennis.hoer@gmail.com'
license 'MIT'
description 'Installs/Configures Selenium'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '3.2.1'

supports 'centos'
supports 'redhat'
supports 'mac_os_x'
supports 'ubuntu'
supports 'windows'

depends 'windows', '~> 1.0'
depends 'nssm', '~> 1.2'
depends 'macosx_autologin', '~> 3.0'

source_url 'https://github.com/dhoer/chef-selenium' if respond_to?(:source_url)
issues_url 'https://github.com/dhoer/chef-selenium/issues' if respond_to?(:issues_url)
