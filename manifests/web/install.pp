class graphite::web::install {

  $source_package_path  = $graphite::params::source_package_path
  $graphite_source_file = $graphite::params::graphite_source_file
  $url_source_tar       = $graphite::params::url_source_tar
  $graphite_dirname     = $graphite::params::graphite_dirname
  $graphite_source_dir  = $graphite::params::graphite_source_dir
  $install_path         = $graphite::params::install_path

  package { $graphite::params::web_package:
    ensure  => present
  }

  exec { 'graphite_source_tar':
    cwd     => $source_package_path,
    creates => "$source_package_path/$graphite_source_file",
    command => "/usr/bin/wget $url_source_tar/$graphite_source_file",
  }

  exec { 'graphite_source_untar':
    cwd     => $source_package_path,
    command => "/bin/tar zxf $graphite_source_file",
    require => Exec['graphite_source_tar'],
    onlyif  => "/usr/bin/test ! -d $source_package_path/$graphite_source_dir",
  }

  file { 'graphite_install_config':
    ensure  => 'present',
    path    => "$source_package_path/$graphite_source_dir/setup.cfg",
    content => template("${module_name}/web/setup.cfg.erb"),
    require => Exec['graphite_source_untar'],
  }

  exec { 'graphite_install_cmd':
    cwd     => "$source_package_path/$graphite_source_dir",
    command => '/usr/bin/python setup.py install',
    creates => "$install_path/$graphite_dirname/bin/run-graphite-devel-server.py",
    require => File['graphite_install_config'],
  }
}
