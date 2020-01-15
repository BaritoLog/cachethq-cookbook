cachethq = default['cachethq']

cachethq['php']['version'] = '7.2'
cachethq['packages'] = [
  'php7.2',
  'php7.2-intl',
  'php7.2-mbstring',
  'php7.2-mysqlnd',
  'php7.2-pdo',
  'php7.2-xml',
  'php7.2-fpm',
  'php7.2-zip',
  'php7.2-sqlite3',
  'git',
  'openssl',
  'nginx',
  'npm',
  'unzip',
]
cachethq['repo'] = 'https://github.com/cachethq/Cachet.git'
cachethq['db']['driver'] = 'sqlite'
cachethq['db']['name'] = 'cachethq'

nginx = cachethq['nginx']
nginx['confdir'] = '/etc/nginx/sites-enabled/'
nginx['docroot'] = '/usr/share/nginx/html/'
nginx['server_name'] = ''
nginx['logs_dir'] = '/var/log/nginx/'
nginx['admin_whitelisted_ip'] = []
cachethq['install_dir'] = '/opt/cachethq/'
cachethq['logs']['access'] = nginx['logs_dir'] + 'cachethq.access.log'
cachethq['logs']['error'] = nginx['logs_dir'] + 'cachethq.error.log'
cachethq['db']['file'] = "#{cachethq['install_dir']}/database/#{cachethq['db']['name']}.sqlite"

fpm = cachethq['php-fpm']
fpm['config'] = '/etc/php/7.2/fpm/php-fpm.conf'
fpm['confdir'] = '/etc/php/7.2/fpm/'
fpm['logdir'] = '/var/log/php7.2-fpm.log'
fpm['socket'] = '/run/php/php7.2-fpm.sock'

npm = cachethq['npm']
npm['modules'] = %w(bower gulp)
