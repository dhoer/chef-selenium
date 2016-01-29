default['selenium']['url'] =
  'https://selenium-release.storage.googleapis.com/2.50/selenium-server-standalone-2.50.1.jar'

default['selenium']['windows']['home'] = "#{ENV['SYSTEMDRIVE']}/selenium"
default['selenium']['windows']['java'] = "#{ENV['SYSTEMDRIVE']}\\java\\bin\\java.exe"

# used by both macosx and linux platforms
default['selenium']['unix']['home'] = '/opt/selenium'
default['selenium']['unix']['java'] = '/usr/bin/java'
