#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

if Chef::Config[:solo] then
  include_recipe "apache::setup"
else
  include_recipe "apache::configure"
  include_recipe "apache::deploy"
end
