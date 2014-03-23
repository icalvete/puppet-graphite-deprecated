class graphite::web (

  $ldap = false

) inherits graphite::params
{

  anchor { 'graphite::web::begin' :
    before => Class['graphite::web::install']
  }

  class { 'graphite::web::install' :
    require => Anchor['graphite::web::begin']
  }

  class { 'graphite::web::config' :
    require => Class['graphite::web::install']
  }

  anchor { 'graphite::web::end' :
    require => Class['graphite::web::config']
  }
}
