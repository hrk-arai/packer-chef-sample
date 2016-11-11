#!/bin/bash

mkdir /etc/chef
mkdir -p /etc/chef/ohai/hints
touch /etc/chef/ohai/hints/ec2.json

aws s3api get-object --bucket cl-validator --key cl-test-validator.pem /etc/chef/cl-test-validator.pem

cat <<EOF > /etc/chef/client.rb
log_level :info
log_location STDOUT
node_name '`hostname`'
chef_server_url 'https://manage.chef.io/organizations/cl-test'
validation_client_name 'cl-test-validator'
validation_key '/etc/chef/cl-test-validator.pem'
environment "acceptance"
EOF

chef-client -r 'role[db]' -L /etc/chef/first-chef-client-run.log
