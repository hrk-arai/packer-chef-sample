#
# Cookbook Name:: wordpress
# Recipe:: deploy
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
# wordpress のインストール

# see https://docs.chef.io/resources.html#remote-file
remote_file "/tmp/latest-ja.tar.gz" do
  source "https://ja.wordpress.org/latest-ja.tar.gz"
end

# see https://docs.chef.io/resources.html#bash
bash 'wordpress deploy package' do
  cwd "/tmp"
  flags "-e"
  code <<-EOH
  tar -zxvf latest-ja.tar.gz
    cp -r wordpress /var/www
    chown -R nginx:nginx /var/www/wordpress
  EOH
  not_if { ::File.exists?("/var/www/wordpress/index.php") }
end

db_server = search(:node, "role:db AND chef_environment:#{node.chef_environment}")
# db_server = search(:node, "chef_environment:#{node.chef_environment}")

unless db_server.empty? then
  db_server.each do |db|
    node.set["wordpress"]["db_ipaddress"] = db['cloud']['local_ipv4']
  end
end

template "/var/www/wordpress/wp-config.php" do
  source "wp-config.php.erb"
  owner "nginx"
  group "nginx"
  action :create
end
