#
# Cookbook Name:: mariadb
# Recipe:: setup
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# packageインストール
package ["mariadb", "mariadb-server"] do
  action :install
end
