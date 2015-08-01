require 'spec_helper'

describe 'selenium::server' do
  context 'windows' do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2').converge(described_recipe) }

    it 'downloads jar' do
      expect(chef_run).to create_remote_file('C:/selenium/server/selenium-server-standalone-2.47.0.jar')
    end

    it 'creates link to jar' do
      expect(chef_run).to create_link('C:/selenium/server/selenium-server-standalone.jar').with(
        to: 'C:/selenium/server/selenium-server-standalone-2.47.0.jar'
      )
    end
  end

  context 'linux' do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.0').converge(described_recipe) }

    it 'downloads jar' do
      expect(chef_run).to create_remote_file('/usr/local/selenium/server/selenium-server-standalone-2.47.0.jar')
    end

    it 'creates link to jar' do
      expect(chef_run).to create_link('/usr/local/selenium/server/selenium-server-standalone.jar').with(
        to: '/usr/local/selenium/server/selenium-server-standalone-2.47.0.jar'
      )
    end
  end

  context 'mac_os_x' do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'mac_os_x', version: '10.10').converge(described_recipe) }

    it 'downloads jar' do
      expect(chef_run).to create_remote_file('/usr/local/selenium/server/selenium-server-standalone-2.47.0.jar')
    end

    it 'creates link to jar' do
      expect(chef_run).to create_link('/usr/local/selenium/server/selenium-server-standalone.jar').with(
        to: '/usr/local/selenium/server/selenium-server-standalone-2.47.0.jar'
      )
    end
  end
end
