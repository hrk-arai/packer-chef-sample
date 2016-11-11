#
# Cookbook Name:: wordpress
# Recipe:: setup
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# package インストール
cookbook_file "/etc/yum.repos.d/nginx-mainline.repo" do
  action :create
  source "nginx-mainline.repo"
end

package ["nginx", "httpd-tools", "php", "php-mbstring", "php-fpm", "php-mysql"] do
  action :install
end
