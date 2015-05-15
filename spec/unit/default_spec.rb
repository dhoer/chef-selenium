require 'spec_helper'

describe 'selenium::default' do
  context 'windows' do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2').converge(described_recipe) }

    it 'does not install package' do
      expect(chef_run).to_not install_package('unzip')
    end

    it 'creates bin directory' do
      expect(chef_run).to create_directory('C:/selenium/bin')
    end

    it 'creates config directory' do
      expect(chef_run).to create_directory('C:/selenium/config')
    end

    it 'creates drivers directory' do
      expect(chef_run).to create_directory('C:/selenium/drivers')
    end

    it 'creates log directory' do
      expect(chef_run).to create_directory('C:/selenium/log')
    end

    it 'creates selenium server directory' do
      expect(chef_run).to create_directory('C:/selenium/server')
    end
  end

  context 'linux' do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.0').converge(described_recipe) }

    it 'installs package' do
      expect(chef_run).to install_package('unzip')
    end

    it 'does not create bin directory' do
      expect(chef_run).to_not create_directory('/usr/local/selenium/bin')
    end

    it 'creates config directory' do
      expect(chef_run).to create_directory('/usr/local/selenium/config')
    end

    it 'creates drivers directory' do
      expect(chef_run).to create_directory('/usr/local/selenium/drivers')
    end

    it 'does not create log directory' do
      expect(chef_run).to_not create_directory('/usr/local/selenium/log')
    end

    it 'creates selenium server directory' do
      expect(chef_run).to create_directory('/usr/local/selenium/server')
    end
  end

  context 'mac_os_x' do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'mac_os_x', version: '10.10').converge(described_recipe) }

    it 'does not install package' do
      expect(chef_run).to_not install_package('unzip')
    end

    it 'does not create bin directory' do
      expect(chef_run).to_not create_directory('/usr/local/selenium/bin')
    end

    it 'creates config directory' do
      expect(chef_run).to create_directory('/usr/local/selenium/config')
    end

    it 'creates drivers directory' do
      expect(chef_run).to create_directory('/usr/local/selenium/drivers')
    end

    it 'does not create log directory' do
      expect(chef_run).to_not create_directory('/usr/local/selenium/log')
    end

    it 'creates selenium server directory' do
      expect(chef_run).to create_directory('/usr/local/selenium/server')
    end
  end
end
