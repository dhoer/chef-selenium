require 'rspec_helper'
require 'rbconfig'

if RbConfig::CONFIG['host_os'] =~ /darwin|mac os/
  describe 'Safari Grid' do
    before(:all) do
      @selenium = Selenium::WebDriver.for(:remote, desired_capabilities: :safari)
    end

    after(:all) do
      @selenium.quit
    end

    it 'Should return display resolution of 1280x1024' do
      @selenium.get 'http://www.whatismyscreenresolution.com/'
      element = @selenium.find_element(:id, 'resolutionNumber')
      expect(element.text).to eq('1024 x 768')
    end
  end
end
