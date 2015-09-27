require 'rspec'
require 'selenium-webdriver'

MACOSX = RbConfig::CONFIG['host_os'].downcase =~ /darwin/

RSpec.configure { |c| c.formatter = 'documentation' }
