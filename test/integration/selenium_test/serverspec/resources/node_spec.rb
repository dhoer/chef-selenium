require 'serverspec_helper'

describe 'selenium_test::node' do
  describe service('selenium_node') do
    it { should be_enabled }
    it { should be_running }
  end

  describe command('wget -qO- http://localhost:5555/wd/hub/status') do
    its(:stdout) { should match(/"state":"success",/) }
  end
end
