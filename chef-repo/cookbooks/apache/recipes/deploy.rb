#
# Cookbook Name:: apache
# Recipe:: deploy
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

file '/var/www/html/index.html' do
  content "#{node["hostname"]}"
  action :create
end
