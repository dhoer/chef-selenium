require 'serverspec_helper'

describe 'selenium::default' do
  if os[:family] == 'windows'
    describe file('C:/selenium/config') do
      it { should be_directory }
      it { should be_owned_by 'root' }
    end

    describe file('C:/selenium/server') do
      it { should be_directory }
      it { should be_owned_by 'root' }
    end

    describe file('C:/selenium/bin') do
      it { should be_directory }
      it { should be_owned_by 'root' }
    end

    describe file('C:/selenium/log') do
      it { should be_directory }
      it { should be_owned_by 'root' }
    end

    describe file('C:/selenium/selenium/server/selenium-server-standalone-2.47.0.jar') do
      it { should be_file }
      it { should be_executable.by_user('root') }
    end

    describe file('C:/selenium/selenium/server/selenium-server-standalone.jar') do
      it { should be_symlink }
    end
  else
    describe package('unzip') do
      it { should be_installed }
    end

    describe file('/opt/selenium/config') do
      it { should be_directory }
      it { should be_owned_by 'root' }
    end

    describe file('/opt/selenium/server') do
      it { should be_directory }
      it { should be_owned_by 'root' }
    end

    describe file('/opt/selenium/server/selenium-server-standalone-2.47.0.jar') do
      it { should be_file }
      it { should be_executable.by_user('root') }
    end

    describe file('/opt/selenium/server/selenium-server-standalone.jar') do
      it { should be_symlink }
    end
  end
end
