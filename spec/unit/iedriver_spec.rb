require 'spec_helper'

describe 'selenium_test::iedriver' do
  context 'windows' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        file_cache_path: 'C:/chef/cache', platform: 'windows', version: '2008R2').converge(described_recipe)
    end

    it 'creates directory' do
      expect(chef_run).to create_directory('C:/selenium/drivers/iedriver-2.46.0')
    end

    it 'downloads driver' do
      expect(chef_run).to create_remote_file('C:/chef/cache/IEDriverServer_x64_2.46.0.zip').with(
        source: 'https://selenium-release.storage.googleapis.com/2.45/IEDriverServer_x64_2.46.0.zip')
    end

    it 'unzips driver' do
      expect(chef_run).to run_batch('unzip ie driver')
        .with(code: "powershell.exe -nologo -noprofile -command \"& { Add-Type -A "\
        "'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory("\
        "'C:/chef/cache/IEDriverServer_x64_2.46.0.zip', "\
        "'C:/selenium/drivers/iedriver-2.46.0'); }\"")
    end

    it 'links driver' do
      expect(chef_run).to create_link('C:/selenium/drivers/iedriver').with(
        to: 'C:/selenium/drivers/iedriver-2.46.0'
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
