name 'selenium_test'
maintainer 'Dennis Hoer'
maintainer_email 'dennis.hoer@gmail.com'
license 'MIT'
description 'Tests Selenium'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

depends 'java_se', '~> 8.0'
depends 'firefox', '~> 2.0'
depends 'chrome', '~> 1.0'
# depends 'chromedriver', '~> 1.0'
# depends 'iedriver', '~> 1.0'
# depends 'safaridriver', '~> 1.0'
depends 'selenium'

depends 'xvfb'
depends 'windows_screenresolution'

depends 'windows', '~> 1.37.0' # 1.38 spams warning about windows_reboot being removed
depends 'nssm'

depends 'apt'
depends 'yum'
depends 'dmg'

depends 'macosx_autologin'
depends 'macosx_gui_login'
