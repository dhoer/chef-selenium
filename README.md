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

### selenium_grid

### selenium_phantomjs

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
