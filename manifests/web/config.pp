class graphite::web::config (

  $webserver      = 'apache2',
  $webserver_user = 'www-data'

) {

  $install_path                 = $graphite::params::install_path
  $graphite_dirname             = $graphite::params::graphite_dirname
  $graphite_wsgi_conf           = "$install_path/$graphite_dirname/conf/graphite.wsgi"
  $graphite_storage_dir         = "$install_path/$graphite_dirname/storage"
  $graphite_app_dir             = "$install_path/$graphite_dirname/webapp/graphite"
  $graphite_local_settings_file = "$graphite_app_dir/local_settings.py"
  $graphite_app_settings_file   = "$graphite_app_dir/app_settings.py.erb"

  file { 'graphite_wsgi_conf':
    ensure  => present,
    path    => $graphite_wsgi_conf,
    content => template("${module_name}/web/graphite.wsgi.erb"),
  }

  file { 'graphite_storage_dir':
    ensure  => 'directory',
    path    => $graphite_storage_dir,
    owner   => $webserver_user,
    recurse => false
  }

  file { 'graphite_log_dir':
    ensure  => 'directory',
    path    => "${graphite_storage_dir}/log/webapp",
    owner   => $webserver_user,
    recurse => false
  }

  file { 'graphite_local_settings_file':
    ensure  => present,
    path    => $graphite_local_settings_file,
    owner   => 'root',
    group   => 'root',
    content => template("${module_name}/web/local_settings.py.erb"),
  }

  file { 'graphite_app_settings_file':
    ensure  => present,
    path    => $graphite_app_settings_file,
    owner   => 'root',
    group   => 'root',
    content => template("${module_name}/web/app_settings.py.erb"),
  }

  exec { 'graphite_syncdb_cmd' :
    cwd     => $graphite_app_dir,
    command => '/usr/bin/python manage.py syncdb --noinput',
    creates => "$graphite_storage_dir/graphite.db",
    require => [
      File['graphite_storage_dir'],
      File['graphite_log_dir'],
      File['graphite_local_settings_file'],
      File['graphite_app_settings_file']
    ]
  }

  file { 'graphite_db_file':
    ensure  => 'present',
    path    => "$graphite_storage_dir/graphite.db",
    owner   => $webserver_user,
    require => Exec['graphite_syncdb_cmd'],
  }
}
