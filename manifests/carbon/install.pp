class graphite::carbon::install {

  $source_package_path = $graphite::params::source_package_path
  $carbon_source_file  = $graphite::params::carbon_source_file
  $url_source_tar      = $graphite::params::url_source_tar
  $carbon_dirname      = $graphite::params::carbon_dirname
  $carbon_source_dir   = $graphite::params::carbon_source_dir
  $install_path        = $graphite::params::install_path

  package { 'python-txamqp':
    ensure => present,
    before => Exec['carbon_install_cmd']
  }

  exec { 'carbon_source_tar':
    cwd     => $source_package_path,
    creates => "$source_package_path/$carbon_source_file",
    command => "/usr/bin/wget $url_source_tar/$carbon_source_file"
  }

  exec { 'carbon_source_untar':
    cwd     => $source_package_path,
    command => "/bin/tar zxf $carbon_source_file",
    require => Exec['carbon_source_tar'],
    onlyif  => "/usr/bin/test ! -d $source_package_path/$carbon_source_dir",
  }

  file { 'carbon_install_config':
    ensure  => 'present',
    path    => "$source_package_path/$carbon_source_dir/setup.cfg",
    content => template("${module_name}/carbon/setup.cfg.erb"),
    require => Exec['carbon_source_untar']
  }

  exec { 'carbon_install_cmd':
    cwd     => "$source_package_path/$carbon_source_dir",
    command => '/usr/bin/python setup.py install',
    creates => "$install_path/$carbon_dirname/bin/carbon-cache.py",
    require => File['carbon_install_config'],
  }
}
