#
# Cookbook Name:: cachethq
# Recipe:: apache2
#
# All rights reserved - Do Not Redistribute
#

cachethq = node.default['cachethq']
apache2 = cachethq['apache2']

# somehow apache2 is also installed
package %w(libapache2-mod-auth-cas apache2)  do
  action :install
end

execute "a2enmod auth_cas" do
  command "sudo a2enmod auth_cas"
end

default_conf = "#{apache2['confdir']}" + "000-default.conf"
bash "remove_default_nginx_nginx" do
  code "rm -f #{default_conf}" 
  only_if { ::File.exist?(default_conf) }
end

log '**** Setting up apache2 config for CachetHQ ****'
template apache2['confdir'] + '000-default.conf' do
  source '000-default.conf.erb'
  owner 'www-data'
  group 'www-data'
  mode 0644
  variables(
    server_name: apache2['server_name'],
    install_dir: cachethq['install_dir'],
    access_log: apache2['logs']['access'],
    error_log: apache2['logs']['error'],
    admin_whitelisted_ip: apache2['admin_whitelisted_ip'],
    fastcgi_params: apache2['fastcgi_params'],
    auth_type: apache2['auth_type'],
    cas_login_url: apache2['cas_login_url'],
    cas_validate_url: apache2['cas_validate_url'],
    cas_root_url: apache2['cas_root_url'],
    additional_config: node['cachethq']['nginx']['additional_config']
  )
  notifies :reload, 'service[apache2]'
end

service 'apache2' do
  supports status: true, restart: true, reload: true
  action :start
end

log "***** Recipe #{cookbook_name}:#{recipe_name} ends here. *****"
