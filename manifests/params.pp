class graphite::params {

  $org_domain           = hiera('org_domain')

  $install_path         = '/srv'
  $source_package_path  = '/usr/src'

  $url_source_tar       = 'https://launchpad.net/graphite/0.9/0.9.10/+download'

  $graphite_source_file = 'graphite-web-0.9.10.tar.gz'
  $carbon_source_file   = 'carbon-0.9.10.tar.gz'
  $whisper_source_file  = 'whisper-0.9.10.tar.gz'

  $graphite_source_dir  = 'graphite-web-0.9.10'
  $carbon_source_dir    = 'carbon-0.9.10'
  $whisper_source_dir   = 'whisper-0.9.10'

  $graphite_dirname     = 'graphite'
  $carbon_dirname       = 'graphite'
  $whisper_dirname      = 'graphite'
}
