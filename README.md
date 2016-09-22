# Selenium Cookbook

[![Cookbook Version](http://img.shields.io/cookbook/v/selenium.svg?style=flat-square)][cookbook]
[![linux](http://img.shields.io/travis/dhoer/chef-selenium/master.svg?label=linux&style=flat-square)][linux]
[![osx](http://img.shields.io/travis/dhoer/chef-selenium/macosx.svg?label=macosx&style=flat-square)][osx]
[![win](https://img.shields.io/appveyor/ci/dhoer/chef-selenium/master.svg?label=windows&style=flat-square)][win]

[cookbook]: https://supermarket.chef.io/cookbooks/selenium
[linux]: https://travis-ci.org/dhoer/chef-selenium/branches
[osx]: https://travis-ci.org/dhoer/chef-selenium/branches
[win]: https://ci.appveyor.com/project/dhoer/chef-selenium

This cookbook installs and configures Selenium (http://www.seleniumhq.org/).

This cookbook comes with the following recipes:

- **[default](https://github.com/dhoer/chef-selenium#default)** - Downloads and installs Selenium Standalone jar.
- **[hub](https://github.com/dhoer/chef-selenium#hub)** - Installs and configures a Selenium Hub as a service.
- **[node](https://github.com/dhoer/chef-selenium#node)** - Installs and configures a Selenium Node as service
 on Linux and a GUI service on Mac OS X and Windows.
 
Resources [selenium_hub](https://github.com/dhoer/chef-selenium#selenium_hub) and 
[selenium_node](https://github.com/dhoer/chef-selenium#selenium_node) are also available.

## Usage

See [selenium_grid](https://github.com/dhoer/chef-selenium_grid#selenium-grid-cookbook) cookbook that wraps selenium, 
browsers, drivers, and screenresolution cookbooks into one comprehensive cookbook.

## Requirements

- Java (not installed by this cookbook)
- Chef 11.16+ 

### Platforms

- CentOS, RedHat
- Mac OS X
- Ubuntu
- Windows

### Cookbooks

- windows
- nssm - Required by Windows services only (e.g. Hub and HtmlUnit running in background)
- macosx_autologin - Required by Mac OS X GUI services 

## Recipes

## default

Downloads and installs Selenium Standalone jar.

### Attributes

- `node['selenium']['url']` - The download URL of Selenium Standalone jar. 
- `node['selenium']['windows']['home']` -  Home directory. Default `#{ENV['SYSTEMDRIVE']}/selenium`.
- `node['selenium']['windows']['java']` -  Path to Java executable. Default 
`#{ENV['SYSTEMDRIVE']}\\java\\bin\\java.exe`.
- `node['selenium']['unix']['home']` -  Home directory. Default `/opt/selenium`. 
- `node['selenium']['unix']['java']` -  Path to Java executable. Default `/usr/bin/java`.

## hub

Installs and configures a Selenium Hub as a service.

### Attributes

- `node['selenium']['hub']['servicename']` - The name of the service.  Default `selenium_hub`. 
- `node['selenium']['hub']['host']` -  Default `null`.
- `node['selenium']['hub']['port']` -  Default `4444`.
- `node['selenium']['hub']['jvm_args']` -  Default `nil`.
- `node['selenium']['hub']['newSessionWaitTimeout']` -  Default `-1`.
- `node['selenium']['hub']['servlets']` -  Default `[]`.
- `node['selenium']['hub']['prioritizer']` -  Default `null`.
- `node['selenium']['hub']['capabilityMatcher']` -  Default `org.openqa.grid.internal.utils.DefaultCapabilityMatcher`.
- `node['selenium']['hub']['throwOnCapabilityNotPresent']` -  Default `true`.
- `node['selenium']['hub']['nodePolling']` -  Default `5000`.
- `node['selenium']['hub']['cleanUpCycle']` -  Default `5000`.
- `node['selenium']['hub']['timeout']` -  Default `30_000`.
- `node['selenium']['hub']['browserTimeout']` -  Default `0`.
- `node['selenium']['hub']['maxSession']` -  Default `5`.
- `node['selenium']['hub']['jettyMaxThreads']` -  Default `-1`.

## node

Installs and configures a Selenium Node as service on Linux and a GUI service on Mac OS X and Windows.

- Firefox browser must be installed outside of this cookbook.
- Linux nodes without a physical monitor require a headless display
(e.g., [xvfb](https://supermarket.chef.io/cookbooks/xvfb), [x11vnc](https://supermarket.chef.io/cookbooks/x11vnc),
etc...) and must be installed and configured outside this cookbook.
- Mac OS X/Windows nodes must run as a GUI service and that requires a username
and password for automatic login. Note that Windows password is stored unencrypted under windows registry
`HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon` and Mac OS X  password is stored encrypted under 
`/etc/kcpassword` but it can be easily decrypted.

### Attributes

- `node['selenium']['node']['servicename']` - The name of the service. Default `selenium_node`.
- `node['selenium']['node']['host']` - Default `ip`.
- `node['selenium']['node']['port']` - Default `5555`.
- `node['selenium']['node']['jvm_args']` - Default `nil`.
- `node['selenium']['node']['proxy']` - Default `org.openqa.grid.selenium.proxy.DefaultRemoteProxy`.
- `node['selenium']['node']['maxSession']` - Default `5`.
- `node['selenium']['node']['register']` - Default `true`.
- `node['selenium']['node']['registerCycle']` - Default `5000`.
- `node['selenium']['node']['hubPort']` - Selenium-grid hub hostname. Default `4444`.
- `node['selenium']['node']['hubHost']` - Selenium-grid hub port. Default `ip`.
- `node['selenium']['node']['capabilities']` -  Based on 
[capabilities](https://code.google.com/p/selenium/wiki/DesiredCapabilities). Default `[]`.
- `node['selenium']['node']['additional_args']` - Default `[]`.
- `node['selenium']['node']['display']` - Default `:0`.
- Mac OS X/Windows only - Set both username and password to run as a GUI service:
    - `username` - Default `nil`.
    - `password` - Default `nil`. Note that Windows password is stored unencrypted under windows registry
`HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon` and Mac OS X  password is stored encrypted under 
`/etc/kcpassword` but it can be easily decrypted.
    - `domain` - Optional for Windows only.  Default `nil`.
    
### Example

#### Install Selenium Node with Firefox and HtmlUnit capabilities

```ruby
node.override['selenium']['node']['username'] = 'vagrant' if platform?('windows', 'mac_os_x')
node.override['selenium']['node']['password'] = 'vagrant' if platform?('windows', 'mac_os_x')

node.override['selenium']['node']['capabilities'] = [
  {
    browserName: 'firefox',
    maxInstances: 5,
    seleniumProtocol: 'WebDriver'
  },
  {
    browserName: 'htmlunit',
    maxInstances: 1,
    platform: 'ANY',
    seleniumProtocol: 'WebDriver'
  }
]
  
include_recipe 'selenium::node'
```

## Resources

## selenium_hub

Installs and configures a Selenium Hub as a service.

### Attributes

This is a partial list of attributes available.  See
[hub](https://github.com/dhoer/chef-selenium/blob/master/resources/hub.rb)
resource for the complete listing of attributes.

- `name` - Name attribute. The name of the service.
- `host` - Hostname. Default `null`.
- `port` - Port.  Default `4444`.

## selenium_node

Installs and configures a Selenium Node as a service.

### Attributes

This is a partial list of attributes available.  See
[node](https://github.com/dhoer/chef-selenium/blob/master/resources/node.rb)
resource for the complete listing of attributes.

- `name` - Name attribute. The name of the service.
- `host` - Hostname. Default `null`.
- `port` - Port.  Default `5555`.
- `hubHost` - Selenium-grid hub hostname. Default `ip`.
- `hubPort` - Selenium-grid hub port. Default `4444`.
- `capabilities` -  Based on 
[capabilities](https://code.google.com/p/selenium/wiki/DesiredCapabilities). Default `[]`.
- Mac OS X/Windows only - Set both username and password to run as a GUI service:
    - `username` - Default `nil`.
    - `password` - Default `nil`. Note that Windows password is stored unencrypted under windows registry
`HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon` and Mac OS X  password is stored encrypted under 
`/etc/kcpassword` but it can be easily decrypted.
    - `domain` - Optional for Windows only.  Default `nil`.

### Example

#### Install Selenium Node with Firefox and HtmlUnit capabilities

```ruby
selenium_node 'selenium_node' do
  username 'vagrant' if platform?('windows', 'mac_os_x')
  password 'vagrant' if platform?('windows', 'mac_os_x')
  capabilities [
    {
      browserName: 'firefox',
      maxInstances: 5,
      seleniumProtocol: 'WebDriver'
    },
    {
      browserName: 'htmlunit',
      maxInstances: 1,
      platform: 'ANY',
      seleniumProtocol: 'WebDriver'
    }
  ]
  action :install
end
```

## ChefSpec Matchers

The Selenium cookbook includes custom [ChefSpec](https://github.com/sethvargo/chefspec) matchers you can use to test 
your own cookbooks.

Example Matcher Usage

```ruby
expect(chef_run).to install_selenium_hub('resource_name').with(
  port: '4444'
)
```
      
Selenium Cookbook Matchers

- install_selenium_hub(resource_name)
- install_selenium_node(resource_name)

## Getting Help

- Ask specific questions on [Stack Overflow](http://stackoverflow.com/questions/tagged/selenium).
- Report bugs and discuss potential features in [Github issues](https://github.com/dhoer/chef-selenium/issues).

## Contributing

Please refer to [CONTRIBUTING](https://github.com/dhoer/chef-selenium/blob/master/CONTRIBUTING.md).

## License

MIT - see the accompanying [LICENSE](https://github.com/dhoer/chef-selenium/blob/master/LICENSE.md) file for details.
