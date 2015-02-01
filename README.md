# Selenium Cookbook

[![Cookbook Version](http://img.shields.io/cookbook/v/selenium.svg?style=flat-square)][supermarket]
[![Build Status](http://img.shields.io/travis/dhoer/chef-selenium.svg?style=flat-square)][travis]
[![GitHub Issues](http://img.shields.io/github/issues/dhoer/chef-selenium.svg?style=flat-square)][github]

[supermarket]: https://supermarket.chef.io/cookbooks/selenium
[travis]: https://travis-ci.org/dhoer/chef-selenium
[github]: https://github.com/dhoer/chef-selenium

This cookbook installs and configures Selenium and WebDriver components (http://www.seleniumhq.org/).

This cookbook comes with the following resources:

- [selenium_hub](https://github.com/dhoer/chef-selenium#selenium_hub) - Installs and configures selenium-grid hubs.
- [selenium_node](https://github.com/dhoer/chef-selenium#selenium_node) - Installs and configures selenium-grid nodes
with support for [ChromeDriver](http://chromedriver.storage.googleapis.com/index.html),
[InternetExplorerDriver](https://code.google.com/p/selenium/wiki/InternetExplorerDriver), and
[FirefoxDriver](https://code.google.com/p/selenium/wiki/FirefoxDriver).
- [selenium_phantomjs](https://github.com/dhoer/chef-selenium#selenium_phantomjs) - Installs and configures
[PhantomJS](http://phantomjs.org/) as a selenium-grid node or as a standalone server via
[GhostDriver](https://github.com/detro/ghostdriver).

#### Roadmap

Add support for the following in the future (any volunteers?):

- [HtmlUnit](https://code.google.com/p/selenium/wiki/HtmlUnitDriver)
- Mac OS X platform and [SafariDriver](https://code.google.com/p/selenium/wiki/SafariDriver)
- [Appium](http://appium.io)

## Requirements

Chef 11 or greater

### Platforms

- CentOS, RedHat
- Ubuntu
- Windows

### Cookbooks

These cookbooks are referenced with suggests, so be sure to depend on cookbooks that apply:

- windows
- nssm - Windows hubs only

## Usage

See [selenium_test](https://github.com/dhoer/chef-selenium/tree/master/test/fixtures/cookbooks/selenium_test)
cookbook recipes for working cross platform examples.

## selenium_hub

Installs and configures selenium-grid hubs.

## selenium_node

Installs and configures selenium-grid nodes with support for
[ChromeDriver](http://chromedriver.storage.googleapis.com/index.html),
[InternetExplorerDriver](https://code.google.com/p/selenium/wiki/InternetExplorerDriver), and
[FirefoxDriver](https://code.google.com/p/selenium/wiki/FirefoxDriver).

## selenium_phantomjs

Installs and configures [PhantomJS](http://phantomjs.org/) as a selenium-grid node or as a standalone server via
[GhostDriver](https://github.com/detro/ghostdriver).

#### Requirements

- [PhantomJS](http://phantomjs.org/) must be installed outside of this cookbook.

#### Examples

##### Install PhantomJS as a selenium-grid node

```ruby
selenium_phantomjs 'selenium_phantomjs' do
  username 'Administrator' if platform?('windows')
  password 'password' if platform?('windows')
  action :install
end
```

##### Install PhantomJS as a standalone server by setting hubHost to false

```ruby
selenium_phantomjs 'selenium_phantomjs_nogrid' do
  username 'Administrator' if platform?('windows')
  password 'password' if platform?('windows')
  hubHost false
  action :install
end
```

#### Attributes

- `name` - Name of service or auto-login script.
- `host` - Webdriver hostname. Defaults to `node['ipaddress']`. Use in conjunction with `host` to generate `webdriver`
parameter.
- `port` - Webdriver port.  Defaults to `8910`. Use in conjunction with `host` to generate `webdriver` parameter.
- `hubHost` - Selenium-grid hub hostname. Defaults to `node['ipaddress']`. Set to false to install as a standalone
service. Use in conjunction with `hubPort` to replace `webdriverSeleniumGridHub` parameter.
- `hubPort` - Selenium-grid hub port. Defaults to `4444`.  Use in conjunction with `hubHost` to generate
`webdriverSeleniumGridHub` parameter.
- `username` - Windows account username. Required for Windows only.
- `password` - Windows account password. Required for Windows only.
- `domain` - Windows account domain. Optional for Windows only.  Defaults to `nil`

See [phantomjs](https://github.com/dhoer/chef-selenium/blob/master/resources/phantomjs.rb) resource a complete list
of attributes.

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
- install_selenium_phantomjs(resource_name)

## Getting Help

- Ask specific questions on [Stack Overflow](http://stackoverflow.com/questions/tagged/chef-selenium).
- Report bugs and discuss potential features in [Github issues](https://github.com/dhoer/chef-selenium/issues).

## Contributing

Please refer to [CONTRIBUTING](https://github.com/dhoer/chef-selenium/blob/master/CONTRIBUTING.md).

## License

MIT - see the accompanying [LICENSE](https://github.com/dhoer/chef-selenium/blob/master/LICENSE.md) file for details.
