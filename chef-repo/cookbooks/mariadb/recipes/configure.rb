#
# Cookbook Name:: mariadb
# Recipe:: configure
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# サービス設定
service "mariadb" do
  action [:enable, :start]
end

# conf設定
template "/etc/my.cnf" do
  source "my.cnf.erb"
  action :create
  notifies :restart, 'service[mariadb]'
end
