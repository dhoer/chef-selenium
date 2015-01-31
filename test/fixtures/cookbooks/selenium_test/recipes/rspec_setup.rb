# Sets up busser rspec for awful valentine functional test
# https://github.com/dimacus/SeleniumBestPracticesBook

# selenium-webdriver gem requires ffi which requires gcc to compile
package 'gcc' do
  not_if { platform?('windows') }
end
