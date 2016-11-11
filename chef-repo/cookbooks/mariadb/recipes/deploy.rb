#
# Cookbook Name:: mariadb
# Recipe:: deploy
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# sqlファイルを実行
execute "create-db" do
  command "mysql < /tmp/create-wordpress.sql"
  action :nothing
end

# DB作成用のsqlファイル生成
template "/tmp/create-wordpress.sql" do
  source "create-wordpress.sql.erb"
  action :create
  notifies :run, "execute[create-db]", :immediately
end
