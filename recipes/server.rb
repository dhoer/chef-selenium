include_recipe 'selenium::default'

version = node['selenium']['server_version']
target = "#{selenium_home}/server/selenium-server-standalone-#{version}.jar"

if node['selenium']['override_url']
  url = node['selenium']['override_url']
else
  url = "#{node['selenium']['release_url']}/#{selenium_version(version)}/selenium-server-standalone-#{version}.jar"
end

remote_file target do
  source url
  mode 0775
  not_if { ::File.exist?(target) }
end

link "#{selenium_home}/server/selenium-server-standalone.jar" do
  to target
end
