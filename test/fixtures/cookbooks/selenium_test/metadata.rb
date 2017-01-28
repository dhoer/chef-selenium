name 'selenium_test'
maintainer 'Dennis Hoer'
maintainer_email 'dennis.hoer@gmail.com'
license 'MIT'
description 'Tests Selenium'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

depends 'selenium'

depends 'java_se', '~> 8.0'
depends 'mozilla_firefox'

depends 'xvfb'
depends 'windows_screenresolution'

depends 'dmg'
