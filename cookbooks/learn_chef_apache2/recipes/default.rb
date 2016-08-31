#
# Cookbook Name:: learn_chef_apache2
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

root_dbpswd=""

apt_update 'Update cache daily' do
	frequency 86_400
	action :periodic
end


package 'apache2'
package 'mysql-server'
package 'unzip'
package 'libapache2-mod-wsgi'
package 'python-pip'
package 'python-mysqldb'


service 'apache2' do
	supports :status => true
	action [:enable, :start]
end

directory '/var/www/AAR' do
	owner 'www-data'
	group 'www-data'
	mode  '0775'
end

bash '"install python-flask"' do
	not_if 'python -c "import flask"'
	code 'pip install flask'
end

template '/etc/apache2/sites-enabled/AAR-apache.conf' do
	source 'AAR-apache.conf.erb'
	notifies :stop, resources(:service => "apache2"), :before
end

service 'apache2' do
	action :start
end