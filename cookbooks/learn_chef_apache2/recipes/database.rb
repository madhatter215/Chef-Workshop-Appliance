#
# Cookbook Name:: learn_chef_apache2
# Recipe:: database
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

#mysql_client 'default' do
#	action :create
#end

mysql_service 'default' do
	initial_root_password node['learn_chef_apache2']['database']['root_password']
	#initial_root_password ""
	action [:create, :start]
end

mysql_chef_gem 'default' do
	action :install
end

mysql_database node['learn_chef_apache2']['database']['dbname'] do
	#"host":"localhost", "user":"aarapp", "passwd":"%s", "db":"AARdb"
	connection(
		:host 		=> ['learn_chef_apache2']['database']['host'],
		:username 	=> ['learn_chef_apache2']['database']['root_username'],
		:password 	=> ['learn_chef_apache2']['database']['root_password']
#		:host => '127.0.0.1',
#		:username => 'root',
#		:password => ''
	)
	action :create
end
