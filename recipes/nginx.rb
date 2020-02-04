#
# Cookbook Name:: cachethq
# Recipe:: nginx
#
# All rights reserved - Do Not Redistribute
#

cachethq = node.default['cachethq']
nginx = cachethq['nginx']
fpm = cachethq['php-fpm']

# make sure remove apache2
# to avoid duplicate web server, port blocked because already used, etc
package %w(apache2)  do
  action :remove
end

bash "remove_default_nginx_nginx" do
  code "rm -f /etc/nginx/sites-enabled/default" 
end

log '**** Setting up nginx config for CachetHQ ****'
template nginx['confdir'] + 'CachetHQ.conf' do
  source 'cachethq.conf.erb'
  owner 'www-data'
  group 'www-data'
  mode 0644
  variables(
    server_name: node['cachethq']['nginx']['server_name'],
    install_dir: cachethq['install_dir'],
    access_log: cachethq['logs']['access'],
    error_log: cachethq['logs']['error'],
    fpm_socket: fpm['socket'],
    admin_whitelisted_ip: node['cachethq']['nginx']['admin_whitelisted_ip'],
    fastcgi_params: node['cachethq']['nginx']['fastcgi_params'],
    additional_config: node['cachethq']['nginx']['additional_config']
  )
  notifies :reload, 'service[nginx]'
end

service 'nginx' do
  supports status: true, restart: true, reload: true
  action :start
end

log "***** Recipe #{cookbook_name}:#{recipe_name} ends here. *****"
