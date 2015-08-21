default['selenium']['server_version'] = '2.47.0'
default['selenium']['iedriver_version'] = '2.47.0'
default['selenium']['chromedriver_version'] = '2.16'
default['selenium']['safaridriver_version'] = '2.45'

default['selenium']['override_url'] = nil # allows for custom selenium standalone jar download
default['selenium']['release_url'] = 'https://selenium-release.storage.googleapis.com'
default['selenium']['chromedriver_url'] = 'https://chromedriver.storage.googleapis.com'

default['selenium']['windows']['home'] = 'C:/selenium'
default['selenium']['windows']['java'] = 'C:\Windows\System32\java.exe'
default['selenium']['windows']['phantomjs'] = 'C:\ProgramData\chocolatey\bin\phantomjs.exe'

default['selenium']['linux']['home'] = '/usr/local/selenium'
default['selenium']['linux']['java'] = '/usr/bin/java'
default['selenium']['linux']['phantomjs'] = '/usr/local/bin/phantomjs'
