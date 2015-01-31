require 'spec_helper'

describe 'selenium_test::chromedriver' do
  context 'windows' do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2').converge(described_recipe) }

    it 'create directory' do
      expect(chef_run).to create_directory('C:/selenium/drivers/chromedriver_win32-2.12')
    end

    it 'download and unzip driver' do
      expect(chef_run).to unzip_windows_zipfile_to('C:/selenium/drivers/chromedriver_win32-2.12').with(
        source: 'https://chromedriver.storage.googleapis.com/2.12/chromedriver_win32.zip'
      )
    end

    it 'link driver' do
      expect(chef_run).to create_link('C:/selenium/drivers/chromedriver').with(
        to: 'C:/selenium/drivers/chromedriver_win32-2.12'
      )
    end
  end

  context 'linux' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        file_cache_path: '/var/chef/cache', platform: 'centos', version: '7.0').converge(described_recipe)
    end

    it 'create directory' do
      expect(chef_run).to create_directory('/usr/local/selenium/drivers/chromedriver_linux64-2.12')
    end

    it 'downloads chromedriver' do
      expect(chef_run).to create_remote_file("#{Chef::Config['file_cache_path']}/chromedriver_linux64-2.12.zip").with(
        source: 'https://chromedriver.storage.googleapis.com/2.12/chromedriver_linux64.zip'
      )
    end

    it 'unpack chromedriver' do
      expect(chef_run).to_not run_execute('unpack chromedriver')
    end

    it 'link driver' do
      expect(chef_run).to create_link('/usr/local/selenium/drivers/chromedriver').with(
        to: '/usr/local/selenium/drivers/chromedriver_linux64-2.12'
      )
    end
  end
end
