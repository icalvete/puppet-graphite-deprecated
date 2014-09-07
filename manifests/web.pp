class graphite::web (

  $ldap         = false,
  $org_domain   = $graphite::params::org_domain,
  $server_name  = undef,
  $server_alias = ['graphite'],

) inherits graphite::params
{

  if $server_alias {
    if ! is_array($server_alias) {
      fail('server_alias parameter must be un array')
    }
  }

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
