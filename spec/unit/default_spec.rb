require 'spec_helper'

describe 'selenium::default' do
  context 'windows' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do |node|
        ENV['SYSTEMDRIVE'] = 'C:'
        node.set['selenium']['url'] =
          'https://selenium-release.storage.googleapis.com/2.45/selenium-server-standalone-2.45.0.jar'
      end.converge(described_recipe)
    end

    it 'does not install zip package' do
      expect(chef_run).to_not install_package('unzip')
    end

    it 'creates bin directory' do
      expect(chef_run).to create_directory('C:/selenium/bin')
    end

    it 'creates config directory' do
      expect(chef_run).to create_directory('C:/selenium/config')
    end

    it 'creates log directory' do
      expect(chef_run).to create_directory('C:/selenium/log')
    end

    it 'creates selenium server directory' do
      expect(chef_run).to create_directory('C:/selenium/server')
    end

    it 'downloads jar' do
      expect(chef_run).to create_remote_file('C:/selenium/server/selenium-server-standalone-2.45.0.jar')
    end

    it 'creates link to jar' do
      expect(chef_run).to create_link('C:/selenium/server/selenium-server-standalone.jar').with(
        to: 'C:/selenium/server/selenium-server-standalone-2.45.0.jar'
      )
    end
  end

  context 'linux' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '7.0') do |node|
        node.set['selenium']['url'] =
          'https://selenium-release.storage.googleapis.com/2.45/selenium-server-standalone-2.45.0.jar'
      end.converge(described_recipe)
    end

    it 'installs package' do
      expect(chef_run).to install_package('unzip')
    end

    it 'does not create bin directory' do
      expect(chef_run).to_not create_directory('/opt/selenium/bin')
    end

    it 'creates config directory' do
      expect(chef_run).to create_directory('/opt/selenium/config')
    end

    it 'does not create log directory' do
      expect(chef_run).to_not create_directory('/opt/selenium/log')
    end

    it 'creates selenium server directory' do
      expect(chef_run).to create_directory('/opt/selenium/server')
    end

    it 'downloads jar' do
      expect(chef_run).to create_remote_file('/opt/selenium/server/selenium-server-standalone-2.45.0.jar').with(
        source: 'https://selenium-release.storage.googleapis.com/2.45/selenium-server-standalone-2.45.0.jar'
      )
    end

    it 'creates link to jar' do
      expect(chef_run).to create_link('/opt/selenium/server/selenium-server-standalone.jar').with(
        to: '/opt/selenium/server/selenium-server-standalone-2.45.0.jar'
      )
    end
  end

  context 'mac_os_x' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'mac_os_x', version: '10.10') do |node|
        node.set['selenium']['url'] =
          'https://selenium-release.storage.googleapis.com/2.45/selenium-server-standalone-2.45.0.jar'
      end.converge(described_recipe)
    end

    it 'does not install package' do
      expect(chef_run).to_not install_package('unzip')
    end

    it 'does not create bin directory' do
      expect(chef_run).to_not create_directory('/opt/selenium/bin')
    end

    it 'creates config directory' do
      expect(chef_run).to create_directory('/opt/selenium/config')
    end

    it 'does not create log directory' do
      expect(chef_run).to_not create_directory('/opt/selenium/log')
    end

    it 'creates selenium server directory' do
      expect(chef_run).to create_directory('/opt/selenium/server')
    end

    it 'downloads jar' do
      expect(chef_run).to create_remote_file('/opt/selenium/server/selenium-server-standalone-2.45.0.jar')
    end

    it 'creates link to jar' do
      expect(chef_run).to create_link('/opt/selenium/server/selenium-server-standalone.jar').with(
        to: '/opt/selenium/server/selenium-server-standalone-2.45.0.jar'
      )
    end
  end
end
