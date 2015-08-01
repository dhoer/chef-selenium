# http://elementalselenium.com/tips/69-safari
require 'rspec_helper'
require 'rspec'
require 'selenium-webdriver'

include RSpec::Matchers

RSpec.configure { |c| c.formatter = 'documentation' }

def setup
  @driver = Selenium::WebDriver.for :safari
end

def teardown
  @driver.quit
end

def run
  setup
  yield
  teardown
end

run do
  @driver.get 'http://www.whatismyscreenresolution.com/'
  element = @driver.find_element(:id, 'resolutionNumber')
  expect(element.text).to eq('1280 x 1024')
end
