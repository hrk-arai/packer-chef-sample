#
# Cookbook Name:: wordpress
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

if Chef::Config[:solo] then
  include_recipe "wordpress::setup"
else
  include_recipe "wordpress::configure"
  include_recipe "wordpress::deploy"
end
