require 'spec_helper'

describe 'selenium_test::htmlunit' do
  let(:shellout) { double(run_command: nil, error!: nil, stdout: ' ') }

  before { allow(Mixlib::ShellOut).to receive(:new).and_return(shellout) }

  context 'windows' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2', step_into: ['selenium_node']) do |node|
        node.set['java']['windows']['url'] = 'http://ignore/jdk-windows-64x.tar.gz'
        stub_command("netsh advfirewall firewall show rule name=\"selenium_htmlunit\" > nul")
      end.converge(described_recipe)
    end

    it 'installs selenium_htmlunit server' do
      expect(chef_run).to install_selenium_node('selenium_htmlunit')
    end

    it 'creates node config file' do
      expect(chef_run).to create_template('C:/selenium/config/selenium_htmlunit.json').with(
        source: 'node_config.erb',
        cookbook: 'selenium'
      )
    end

    it 'install selenium_htmlunit' do
      expect(chef_run).to install_nssm('selenium_htmlunit').with(
        program: 'C:\\Windows\\System32\\java.exe',
        args: '-jar """C:/selenium/server/selenium-server-standalone.jar"""'\
          ' -role node -nodeConfig """C:/selenium/config/selenium_htmlunit.json"""',
        params: {
          AppDirectory: 'C:/selenium',
          AppStdout: 'C:/selenium/log/selenium_htmlunit.log',
          AppStderr: 'C:/selenium/log/selenium_htmlunit.log',
          AppRotateFiles: 1
        }
      )
    end

    it 'creates firewall rule' do
      expect(chef_run).to run_execute('Firewall rule selenium_htmlunit for port 5556')
    end

    it 'reboots windows server' do
      expect(chef_run).to_not request_windows_reboot('Reboot to start selenium_htmlunit')
    end
  end

  context 'linux' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        file_cache_path: '/var/chef/cache', platform: 'centos', version: '7.0', step_into: ['selenium_node']) do
      end.converge(described_recipe)
    end

    it 'installs selenium_htmlunit server' do
      expect(chef_run).to install_selenium_node('selenium_htmlunit')
    end

    it 'creates selenium user' do
      expect(chef_run).to create_user('ensure user selenium exits for selenium_htmlunit').with(username: 'selenium')
    end

    it 'creates node config file' do
      expect(chef_run).to create_template('/usr/local/selenium/config/selenium_htmlunit.json')
    end

    it 'install selenium_htmlunit' do
      expect(chef_run).to create_template('/etc/init.d/selenium_htmlunit').with(
        source: 'rhel_initd.erb',
        cookbook: 'selenium',
        mode: '0755',
        variables: {
          name: 'selenium_htmlunit',
          user: 'selenium',
          exec: '/usr/bin/java',
          args: '-jar \"/usr/local/selenium/server/selenium-server-standalone.jar\" -role node '\
            '-nodeConfig \"/usr/local/selenium/config/selenium_htmlunit.json\"',
          port: 5556,
          display: ':0'
        }
      )
    end

    it 'start selenium_htmlunit' do
      expect(chef_run).to_not start_service('selenium_htmlunit')
    end
  end
end
