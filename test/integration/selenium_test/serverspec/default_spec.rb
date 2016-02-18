require 'serverspec_helper'

describe 'selenium::default' do
  version = '2.52.0'

  if os[:family] == 'windows'
    describe file('C:/selenium/config') do
      it { should be_directory }
    end

    describe file('C:/selenium/server') do
      it { should be_directory }
    end

    describe file('C:/selenium/bin') do
      it { should be_directory }
    end

    describe file('C:/selenium/log') do
      it { should be_directory }
    end

    describe file("C:/selenium/server/selenium-server-standalone-#{version}.jar") do
      it { should be_file }
    end

    describe file('C:/selenium/server/selenium-server-standalone.jar') do
      it { should be_file }
    end
  else
    describe file('/opt/selenium/config') do
      it { should be_directory }
      it { should be_owned_by 'root' }
    end

    describe file('/opt/selenium/server') do
      it { should be_directory }
      it { should be_owned_by 'root' }
    end

    describe file("/opt/selenium/server/selenium-server-standalone-#{version}.jar") do
      it { should be_file }
      it { should be_executable.by_user('root') }
    end

    describe file('/opt/selenium/server/selenium-server-standalone.jar') do
      it { should be_symlink }
    end
  end
end
