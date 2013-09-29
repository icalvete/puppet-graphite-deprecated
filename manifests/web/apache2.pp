class graphite::web::apache2 {

  $install_path        = $graphite::params::install_path
  $graphite_dirname    = $graphite::params::graphite_dirname
  $graphite_vhost_conf = '/etc/apache2/sites-available/graphite.vhost'

  file { 'graphite_vhost_conf':
    ensure  => present,
    path    => $graphite_vhost_conf,
    content => template("${module_name}/web/apache2/graphite.vhost.erb"),
  }
}
