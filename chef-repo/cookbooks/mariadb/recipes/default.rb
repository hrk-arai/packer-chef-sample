#
# Cookbook Name:: mariadb
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

if Chef::Config[:solo] then
  include_recipe "mariadb::setup"
else
  include_recipe "mariadb::configure"
  include_recipe "mariadb::deploy"
end
