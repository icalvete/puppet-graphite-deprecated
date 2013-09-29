class graphite::carbon::service inherits graphite::params {

  $install_path   = $graphite::params::install_path
  $carbon_dirname = $graphite::params::carbon_dirname

  file { 'carbon-init-script':
    ensure  => present,
    path    => '/etc/init.d/carbon-cache',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template("${module_name}/carbon/carbon-cache.init.erb"),
  }

  service { 'carbon-cache' :
    ensure  => running,
    enable  => true,
    require => File['carbon-init-script']
  }

}

