#
# Cookbook Name:: wordpress
# Recipe:: configure
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# サービスの起動と自動起動設定
service "nginx" do
  action [:enable, :start]
end

service "php-fpm" do
  action [:enable, :start]
end

# configファイルの設定
template "/etc/nginx/nginx.conf" do
  source "nginx.conf.erb"
  owner "nginx"
  group "nginx"
  action :create
  notifies :restart, 'service[nginx]'
end

template "/etc/nginx/conf.d/default.conf" do
  source "default.conf.erb"
  owner "nginx"
  group "nginx"
  action :create
  notifies :restart, 'service[nginx]'
end

template "/etc/php-fpm.d/www.conf" do
  source "www.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
  notifies :restart, 'service[php-fpm]'
end
