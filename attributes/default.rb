cachethq = default['cachethq']

cachethq['php']['version'] = '7.3'
cachethq['packages'] = [
  'php7.3',
  'php7.3-intl',
  'php7.3-mbstring',
  'php7.3-mysqlnd',
  'php7.3-pdo',
  'php7.3-xml',
  'php7.3-fpm',
  'php7.3-zip',
  'php7.3-sqlite3',
  'git',
  'openssl',
  'nginx',
  'npm',
  'unzip'
]
cachethq['repo'] = 'https://github.com/cachethq/Cachet.git'
cachethq['db']['driver'] = 'sqlite'
cachethq['db']['name'] = 'cachethq'
cachethq['app_key'] = ''

nginx = cachethq['nginx']
nginx['confdir'] = '/etc/nginx/sites-enabled/'
nginx['docroot'] = '/usr/share/nginx/html/'
nginx['server_name'] = ''
nginx['logs_dir'] = '/var/log/nginx/'
nginx['admin_whitelisted_ip'] = []
nginx['fastcgi_params'] = []
nginx['additional_config'] = []
cachethq['install_dir'] = '/opt/cachethq/'
cachethq['logs']['access'] = nginx['logs_dir'] + 'cachethq.access.log'
cachethq['logs']['error'] = nginx['logs_dir'] + 'cachethq.error.log'
cachethq['db']['file'] = "#{cachethq['install_dir']}/database/#{cachethq['db']['name']}.sqlite"

apache2 = cachethq['apache2']
apache2['confdir'] = '/etc/apache2/sites-available/'
apache2['server_name'] = 'localhost'
apache2['logs_dir'] = '/var/log/apache2/'
apache2['admin_whitelisted_ip'] = []
apache2['fastcgi_params'] = []
apache2['auth_type'] = "CAS"
apache2['cas_login_url'] = "127.0.0.1/login"
apache2['cas_validate_url'] = "127.0.0.1/validate"
apache2['cas_root_url'] = "127.0.0.1"
apache2['additional_config'] = []
apache2['logs']['access'] = apache2['logs_dir'] + 'cachethq.access.log'
apache2['logs']['error'] = apache2['logs_dir'] + 'cachethq.error.log'
apache2['default_conf'] = apache2['confdir'] + '000-default.conf'

fpm = cachethq['php-fpm']
fpm['config'] = '/etc/php/7.3/fpm/php-fpm.conf'
fpm['confdir'] = '/etc/php/7.3/fpm/'
fpm['logdir'] = '/var/log/php7.3-fpm.log'
fpm['socket'] = '/run/php/php7.3-fpm.sock'

npm = cachethq['npm']
npm['modules'] = %w(bower gulp)
