require 'spec_helper'

describe 'selenium_test::iedriver' do
  context 'windows' do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2').converge(described_recipe) }

    it 'create directory' do
      expect(chef_run).to create_directory('C:/selenium/drivers/iedriver-2.44.0')
    end

    it 'download and unzip driver' do
      expect(chef_run).to unzip_windows_zipfile_to('C:/selenium/drivers/iedriver-2.44.0')
    end

    it 'link driver' do
      expect(chef_run).to create_link('C:/selenium/drivers/iedriver').with(
        to: 'C:/selenium/drivers/iedriver-2.44.0'
      )
    end
  end

  context 'non-windows' do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7.0').converge(described_recipe) }

    it 'warns if non-windows platform' do
      expect(chef_run).to write_log('IEDriverServer cannot be installed on this platform using this cookbook.').with(
        level: :warn
      )
    end
  end
end
