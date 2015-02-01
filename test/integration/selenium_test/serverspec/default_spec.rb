require 'serverspec_helper'

describe 'selenium::default' do
  if os[:family] == 'windows'
    describe file('C:/selenium/config') do
      it { should be_directory }
      it { should be_owned_by 'root' }
    end

    describe file('C:/selenium/drivers') do
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
  else
    describe package('unzip') do
      it { should be_installed }
    end

    describe file('/usr/local/selenium/config') do
      it { should be_directory }
      it { should be_owned_by 'root' }
    end

    describe file('/usr/local/selenium/drivers') do
      it { should be_directory }
      it { should be_owned_by 'root' }
    end

    describe file('/usr/local/selenium/server') do
      it { should be_directory }
      it { should be_owned_by 'root' }
    end
  end
end
