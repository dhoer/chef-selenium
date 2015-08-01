require 'spec_helper'

describe 'selenium_test::chromedriver' do
  context 'windows' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        file_cache_path: 'C:/chef/cache', platform: 'windows', version: '2008R2').converge(described_recipe)
    end

    it 'creates directory' do
      expect(chef_run).to create_directory('C:/selenium/drivers/chromedriver_win32-2.16')
    end

    it 'downloads driver' do
      expect(chef_run).to create_remote_file('download chromedriver').with(
        path: "#{Chef::Config[:file_cache_path]}/chromedriver_win32-2.16.zip",
        source: 'https://chromedriver.storage.googleapis.com/2.16/chromedriver_win32.zip'
      )
    end

    it 'unzips via powershell' do
      expect(chef_run).to_not run_batch('unzip chromedriver').with(
        code: "powershell.exe -nologo -noprofile -command \"& { Add-Type -A "\
          "'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory("\
          "'C:/chef/cache/chromedriver_win32.zip', "\
          "'C:/selenium/drivers/chromedriver_win32-2.16'); }\"")
    end

    it 'unzips via window_zipfile' do
      expect(chef_run).to_not unzip_windows_zipfile_to('C:/selenium/drivers/chromedriver_win32-2.16').with(
        source: 'C:/chef/cache/chromedriver_win32.zip'
      )
    end

    it 'links driver' do
      expect(chef_run).to create_link('C:/selenium/drivers/chromedriver').with(
        to: 'C:/selenium/drivers/chromedriver_win32-2.16'
      )
    end
  end

  context 'linux' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        file_cache_path: '/var/chef/cache', platform: 'centos', version: '7.0').converge(described_recipe)
    end

    it 'creates directory' do
      expect(chef_run).to create_directory('/usr/local/selenium/drivers/chromedriver_linux64-2.16')
    end

    it 'downloads driver' do
      expect(chef_run).to create_remote_file('download chromedriver').with(
        path: "#{Chef::Config[:file_cache_path]}/chromedriver_linux64-2.16.zip",
        source: 'https://chromedriver.storage.googleapis.com/2.16/chromedriver_linux64.zip'
      )
    end

    it 'unzips driver' do
      expect(chef_run).to_not run_execute('unzip chromedriver')
    end

    it 'links driver' do
      expect(chef_run).to create_link('/usr/local/selenium/drivers/chromedriver').with(
        to: '/usr/local/selenium/drivers/chromedriver_linux64-2.16'
      )
    end
  end

  context 'mac_os_x' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        file_cache_path: '/var/chef/cache', platform: 'mac_os_x', version: '10.10').converge(described_recipe)
    end

    it 'creates directory' do
      expect(chef_run).to create_directory('/usr/local/selenium/drivers/chromedriver_mac32-2.16')
    end

    it 'downloads driver' do
      expect(chef_run).to create_remote_file('download chromedriver').with(
        path: "#{Chef::Config[:file_cache_path]}/chromedriver_mac32-2.16.zip",
        source: 'https://chromedriver.storage.googleapis.com/2.16/chromedriver_mac32.zip'
      )
    end

    it 'unzips driver' do
      expect(chef_run).to_not run_execute('unpack chromedriver')
    end

    it 'links driver' do
      expect(chef_run).to create_link('/usr/local/selenium/drivers/chromedriver').with(
        to: '/usr/local/selenium/drivers/chromedriver_mac32-2.16'
      )
    end
  end
end
