require 'serverspec_helper'

describe 'selenium::iedriver' do
  if os[:family] == 'windows'
    describe file('C:/selenium/drivers/iedriver') do
      it { should be_symlink }
    end

    describe file('C:/selenium/drivers/iedriver/IEDriverServer.exe') do
      it { should be_file }
      it { should be_executable.by_user('root') }
    end
  end
end
