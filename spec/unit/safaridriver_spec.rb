require 'spec_helper'

describe 'selenium_test::safaridriver' do
  context 'windows' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        file_cache_path: 'C:/chef/cache', platform: 'windows', version: '2008R2').converge(described_recipe)
    end

    it 'log warning' do
      expect(chef_run).to write_log('SafariDriver cannot be installed on this platform using this cookbook!').with(
        level: :warn
      )
    end
  end

  context 'linux' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        file_cache_path: '/var/chef/cache', platform: 'centos', version: '7.0').converge(described_recipe)
    end

    it 'log warning' do
      expect(chef_run).to write_log('SafariDriver cannot be installed on this platform using this cookbook!').with(
        level: :warn
      )
    end
  end

  context 'mac_os_x' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        file_cache_path: '/var/chef/cache', platform: 'mac_os_x', version: '10.10').converge(described_recipe)
    end

    it 'downloads driver' do
      expect(chef_run).to create_remote_file('/var/chef/cache/SafariDriver.safariextz').with(
        source: 'https://selenium-release.storage.googleapis.com/2.45/SafariDriver.safariextz'
      )
    end

    it 'logs into gui' do
      expect(chef_run).to run_macosx_gui_login('vagrant').with(
        password: 'vagrant'
      )
    end

    it 'install driver' do
      expect(chef_run).to install_safari_extension('SafariDriver Extension').with(
        safariextz: '/var/chef/cache/SafariDriver.safariextz'
      )
    end
  end
end
