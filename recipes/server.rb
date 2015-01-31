include_recipe 'selenium::default'

version = node['selenium']['server_version']
target = "#{selenium_home}/server/selenium-server-standalone-#{version}.jar"

remote_file target do
  source "#{node['selenium']['release_url']}/#{selenium_version(version)}/selenium-server-standalone-#{version}.jar"
  mode 0775
  not_if { ::File.exist?(target) }
end

link "#{selenium_home}/server/selenium-server-standalone.jar" do
  to target
end
