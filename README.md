# Selenium Cookbook

[![Cookbook Version](http://img.shields.io/cookbook/v/selenium.svg?style=flat-square)][cookbook]
[![Build Status](http://img.shields.io/travis/dhoer/chef-selenium.svg?style=flat-square)][travis]

[cookbook]: https://supermarket.chef.io/cookbooks/selenium
[travis]: https://travis-ci.org/dhoer/chef-selenium

This cookbook installs and configures Selenium (http://www.seleniumhq.org/).

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

TODO: Document resources

### selenium_hub

Installs selenium hub.

### selenium_node

Installs selenium node.

### selenium_phantomjs

Installs as a node or a standalone server via [GhostDriver](https://github.com/detro/ghostdriver).

#### Requirements

[PhantomJS](http://phantomjs.org/) must be installed outside of this cookbook.

#### Examples

##### Install as a grid node

```ruby
selenium_phantomjs 'selenium_phantomjs' do
  username 'Administrator' if platform?('windows')
  password 'password' if platform?('windows')
  action :install
end
```

##### Install as a standalone server

```ruby
selenium_phantomjs 'selenium_phantomjs_nogrid' do
  username 'Administrator' if platform?('windows')
  password 'password' if platform?('windows')
  hubHost false
  action :install
end
```

#### Attributes




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
