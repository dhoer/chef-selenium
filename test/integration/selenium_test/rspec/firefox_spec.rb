require 'rspec_helper'

describe 'Firefox Grid' do
  before(:all) do
    @selenium = Selenium::WebDriver.for(:remote, desired_capabilities: :firefox)
  end

  after(:all) do
    @selenium.quit
  end

  it 'Should return the-internet.herokuapp.com page' do
    @selenium.get 'http://the-internet.herokuapp.com'
    expect(@selenium.title).to eq('The Internet')
  end
end
