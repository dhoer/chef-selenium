require 'serverspec_helper'

describe 'selenium::server' do
  describe file('/usr/local/selenium/server/selenium-server-standalone-2.47.0.jar') do
    it { should be_file }
    it { should be_executable.by_user('root') }
  end

  describe file('/usr/local/selenium/server/selenium-server-standalone.jar') do
    it { should be_symlink }
  end
end
