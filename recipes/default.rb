#
# Cookbook:: node_sample
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

#imports of recipes
include_recipe 'apt'
include_recipe 'nodejs'


#packages apt-get
apt_update 'update_sources' do
  action :update
end

package 'nginx'

# package 'npm'
nodejs_npm 'pm2'

#services
service 'nginx' do
  action :enable
end

service 'nginx' do
  action :start
end

#npm installs


#creating a resource template
template '/etc/nginx/sites-available/proxy.conf' do
  source 'proxy.conf.erb'
  variables proxy_port: node['nginx']['proxy_port']
  notifies :restart, 'service[nginx]'
end

# resource link
#link = destination
#to = origin
link '/etc/nginx/sites-enabled/proxy.conf' do
  to '/etc/nginx/sites-available/proxy.conf'
  notifies :restart, 'service[nginx]'
end


# resource link to delete
link '/etc/nginx/sites-enabled/default' do
  action :delete
  notifies :restart, 'service[nginx]'
end
