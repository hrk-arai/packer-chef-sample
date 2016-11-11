#
# Cookbook Name:: apache
# Recipe:: configure
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

service 'httpd' do
  action [:enable, :start]
end

=begin
template '/etc/httpd/conf/httpd.conf' do
  source 'httpd.conf.erb'
  action :create
end
=end
