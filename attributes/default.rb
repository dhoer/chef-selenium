default['selenium']['url'] =
  'https://selenium-release.storage.googleapis.com/2.48/selenium-server-standalone-2.48.2.jar'

default['selenium']['windows']['home'] = "#{ENV['SYSTEMDRIVE']}/selenium"
default['selenium']['windows']['java'] = "#{ENV['SYSTEMDRIVE']}\\java\\bin\\java.exe"

# used by both macosx and linux platforms
default['selenium']['unix']['home'] = '/opt/selenium'
default['selenium']['unix']['java'] = '/usr/bin/java'
