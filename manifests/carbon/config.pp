class graphite::carbon::config (

  $amqp_enabled   = false,
  $amqp_host      = undef,
  $amqp_port      = undef,
  $amqp_vhost     = undef,
  $amqp_user      = undef,
  $amqp_password  = undef,
  $amqp_exchange  = undef,

) {

  $install_path                = $graphite::params::install_path
  $carbon_dirname              = $graphite::params::carbon_dirname
  $carbon_config_file          = "$install_path/$carbon_dirname/conf/carbon.conf"
  $carbon_storage_schemas_file = "$install_path/$carbon_dirname/conf/storage-schemas.conf"

  file { 'carbon_config_file':
    ensure  => present,
    path    => $carbon_config_file,
    content => template("${module_name}/carbon/carbon.conf.erb"),
    notify  => Class['graphite::carbon::service'],
  }

  concat { 'carbon_storage_schemas_file' :
    path   => $carbon_storage_schemas_file,
    notify => Class['graphite::carbon::service'],
  }

  concat::fragment { 'carbon_storage_schemas_default':
    target  => 'carbon_storage_schemas_file',
    content => template("${module_name}/carbon/storage-schemas.conf.erb"),
    order   => 90,
  }
}
