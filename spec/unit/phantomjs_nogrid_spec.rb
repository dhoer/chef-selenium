require 'spec_helper'

describe 'selenium_test::phantomjs_nogrid' do
  let(:shellout) { double(run_command: nil, error!: nil, stdout: ' ') }

  before { allow(Mixlib::ShellOut).to receive(:new).and_return(shellout) }

  context 'windows' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2', step_into: ['selenium_phantomjs']) do
        stub_command("netsh advfirewall firewall show rule name=\"selenium_phantomjs_nogrid\" > nul")
      end.converge(described_recipe)
    end

    it 'installs selenium_phantomjs_nogrid server' do
      expect(chef_run).to install_selenium_phantomjs('selenium_phantomjs_nogrid')
    end

    # it 'creates phantomjs nogrid config file' do
    #   expect(chef_run).to create_template('C:/selenium/config/selenium_phantomjs.json').with(
    #       source: 'phantomjs_config.erb',
    #       cookbook: 'selenium'
    #     )
    # end

    it 'creates auto login registry_key' do
      expect(chef_run).to create_registry_key(
        'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon'
      )
    end

    it 'creates shortcut to selenium cmd file' do
      expect(chef_run).to create_windows_shortcut(
        'C:\Users\Administrator\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup'\
          '\selenium_phantomjs_nogrid.lnk'
      )
    end

    it 'creates selenium foreground command' do
      expect(chef_run).to create_file('C:/selenium/bin/selenium_phantomjs_nogrid.cmd').with(
        content: '"C:\tools\PhantomJS\phantomjs.exe" --webdriver=localhost:8911 -log '\
          '"C:/selenium/log/selenium_phantomjs_nogrid.log"'
      )
    end

    it 'creates firewall rule' do
      expect(chef_run).to run_execute('Firewall rule selenium_phantomjs_nogrid for port 8911')
    end

    it 'reboots windows server' do
      expect(chef_run).to_not request_windows_reboot('Reboot to start selenium_phantomjs_nogrid')
    end
  end

  context 'linux' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        file_cache_path: '/var/chef/cache', platform: 'centos', version: '7.0', step_into: ['selenium_phantomjs']
      ).converge(described_recipe)
    end

    it 'installs selenium_phantomjs_nogrid server' do
      expect(chef_run).to install_selenium_phantomjs('selenium_phantomjs_nogrid')
    end

    it 'creates selenium user' do
      expect(chef_run).to create_user('ensure user selenium exits for selenium_phantomjs_nogrid').with(
        username: 'selenium')
    end

    # it 'creates phantomjs nogrid config file' do
    #   expect(chef_run).to create_template('/usr/local/selenium/config/selenium_phantomjs_nogrid.json')
    # end

    it 'install selenium_phantomjs' do
      expect(chef_run).to create_template('/etc/init.d/selenium_phantomjs_nogrid').with(
        source: 'rhel_initd.erb',
        cookbook: 'selenium',
        mode: '0755',
        variables: {
          name: 'selenium_phantomjs_nogrid',
          user: 'selenium',
          exec: '/usr/local/bin/phantomjs',
          # args: '--config="/usr/local/selenium/config/selenium_phantomjs.json"',
          args: '--webdriver=localhost:8911',
          port: 8911,
          display: nil
        }
      )
    end

    it 'start selenium_phantomjs_nogrid' do
      expect(chef_run).to_not start_service('selenium_phantomjs_nogrid')
    end
  end
end
