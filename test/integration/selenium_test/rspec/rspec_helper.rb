require 'rspec'
require 'selenium-webdriver'

MACOSX = RbConfig::CONFIG['host_os'].downcase =~ /darwin/
WINDOWS = RbConfig::CONFIG['host_os'] =~ /mingw|mswin/

RSpec.configure { |c| c.formatter = 'documentation' }
