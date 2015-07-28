require 'spec_helper'

describe 'selenium_test::node' do
  let(:shellout) { double(run_command: nil, error!: nil, stdout: ' ') }

  before do
    stub_command("netsh advfirewall firewall show rule name=\"RDP\" > nul").and_return(true)
    allow(Mixlib::ShellOut).to receive(:new).and_return(shellout)
  end

  context 'windows' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        file_cache_path: 'C:/chef/cache',
        platform: 'windows',
        version: '2008R2',
        step_into: ['selenium_node']) do |node|
        node.set['java']['windows']['url'] = 'http://ignore/jdk-windows-64x.tar.gz'
        allow_any_instance_of(Chef::Recipe).to receive(:firefox_version).and_return('33.0.0')
        allow_any_instance_of(Chef::Recipe).to receive(:chrome_version).and_return('39.0.0.0')
        allow_any_instance_of(Chef::Recipe).to receive(:ie_version).and_return('11.0.0.0')
        allow_any_instance_of(Chef::DSL::RegistryHelper).to receive(:registry_key_exists?).and_return(true)
        stub_command("netsh advfirewall firewall show rule name=\"selenium_node\" > nul")
      end.converge(described_recipe)
    end

    it 'installs selenium_node server' do
      expect(chef_run).to install_selenium_node('selenium_node')
    end

    it 'creates node config file' do
      expect(chef_run).to create_template('C:/selenium/config/selenium_node.json').with(
        source: 'node_config.erb',
        cookbook: 'selenium'
      )
    end

    it 'creates auto login registry_key' do
      expect(chef_run).to create_registry_key(
        'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon'
      )
    end

    it 'creates shortcut to selenium cmd file' do
      expect(chef_run).to create_windows_shortcut(
        'C:\Users\vagrant\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\selenium_node.lnk'
      )
    end

    it 'creates selenium foreground command' do
      expect(chef_run).to create_file('C:/selenium/bin/selenium_node.cmd').with(
        content: '"C:\Windows\System32\java.exe" -jar "C:/selenium/server/selenium-server-standalone.jar" '\
          '-role node -nodeConfig "C:/selenium/config/selenium_node.json" '\
          '-Dwebdriver.chrome.driver="C:/selenium/drivers/chromedriver/chromedriver.exe" '\
          '-Dwebdriver.ie.driver="C:/selenium/drivers/iedriver/IEDriverServer.exe" '\
          '-log "C:/selenium/log/selenium_node.log"'
      )
    end

    it 'creates firewall rule' do
      expect(chef_run).to run_execute('Firewall rule selenium_node for port 5555')
    end

    it 'reboots windows server' do
      expect(chef_run).to_not request_windows_reboot('Reboot to start selenium_node')
    end
  end

  context 'linux' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        file_cache_path: '/var/chef/cache', platform: 'centos', version: '7.0', step_into: ['selenium_node']) do
        allow_any_instance_of(Chef::Recipe).to receive(:firefox_version).and_return('33.0.0')
        allow_any_instance_of(Chef::Recipe).to receive(:chrome_version).and_return('39.0.0.0')
      end.converge(described_recipe)
    end

    it 'installs selenium_node server' do
      expect(chef_run).to install_selenium_node('selenium_node')
    end

    it 'creates selenium user' do
      expect(chef_run).to create_user('ensure user selenium exits for selenium_node').with(username: 'selenium')
    end

    it 'creates node config file' do
      expect(chef_run).to create_template('/usr/local/selenium/config/selenium_node.json')
    end

    it 'install selenium_node' do
      expect(chef_run).to create_template('/etc/init.d/selenium_node').with(
        source: 'rhel_initd.erb',
        cookbook: 'selenium',
        mode: '0755',
        variables: {
          name: 'selenium_node',
          user: 'selenium',
          exec: '/usr/bin/java',
          args: '-jar \"/usr/local/selenium/server/selenium-server-standalone.jar\" -role node '\
            '-nodeConfig \"/usr/local/selenium/config/selenium_node.json\" '\
            '-Dwebdriver.chrome.driver=\"/usr/local/selenium/drivers/chromedriver/chromedriver\"',
          port: 5555,
          display: ':0'
        }
      )
    end

    it 'start selenium_node' do
      expect(chef_run).to_not start_service('selenium_node')
    end
  end
end
