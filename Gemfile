source 'https://rubygems.org'

gem 'foodcritic', '~> 6.0'
gem 'rubocop', '~> 0.39'
gem 'chefspec', '~> 4.6'
gem 'berkshelf', '~> 3.1.5' # 3.2 has performance issue with vmware_fusion
gem 'chef', '~> 11.16'
gem 'faraday', '= 0.9.1' # prevent ridley middleware gzip `initialize': not in gzip format (Zlib::GzipFile::Error)

group :integration do
  gem 'winrm-fs', '~> 0.4'
  gem 'test-kitchen', '~> 1.4'
  gem 'kitchen-vagrant', '~> 0.18'
  gem 'winrm-transport', '~> 1.0'
end
