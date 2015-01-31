require 'serverspec_helper'

describe 'selenium_test::hub' do
  describe service('selenium_hub') do
    it { should be_enabled }
    it { should be_running }
  end

  describe command('wget -qO- http://localhost:4444/grid/console') do
    its(:stdout) { should match(/Grid Console/) }
  end
end
