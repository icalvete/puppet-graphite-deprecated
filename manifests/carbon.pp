class graphite::carbon (

  $amqp_enabled  = false,
  $amqp_host     = undef,
  $amqp_port     = undef,
  $amqp_vhost    = undef,
  $amqp_user     = undef,
  $amqp_password = undef,
  $amqp_exchange = undef,

) inherits graphite::params {

  anchor { 'graphite::carbon::begin':
    before  => Class['graphite::carbon::install']
  }

  class { 'graphite::carbon::install' :
    require => Anchor['graphite::carbon::begin'],
  }

  class { 'graphite::carbon::config' :
    amqp_enabled  => $amqp_enabled,
    amqp_host     => $amqp_host,
    amqp_port     => $amqp_port,
    amqp_vhost    => $amqp_vhost,
    amqp_user     => $amqp_user,
    amqp_password => $amqp_password,
    amqp_exchange => $amqp_exchange,
    require       => Class['graphite::carbon::install'],
  }

  class { 'graphite::carbon::service' :
    require => Class['graphite::carbon::config'],
  }

  anchor { 'graphite::carbon::end' :
    require => Class['graphite::carbon::service'],
  }
}
