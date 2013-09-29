class graphite::whisper::install {

  $source_package_path = $graphite::params::source_package_path
  $whisper_source_file = $graphite::params::whisper_source_file
  $url_source_tar      = $graphite::params::url_source_tar
  $whisper_dirname     = $graphite::params::whisper_dirname
  $whisper_source_dir  = $graphite::params::whisper_source_dir
  $install_path        = $graphite::params::install_path

  exec { 'whisper_source_tar':
    cwd     => $source_package_path,
    command => "/usr/bin/wget $url_source_tar/$whisper_source_file",
    creates => "$source_package_path/$whisper_source_file",
  }

  exec { 'whisper_source_untar':
    cwd     => $source_package_path,
    command => "/bin/tar zxf $whisper_source_file",
    require => Exec['whisper_source_tar'],
    onlyif  => "/usr/bin/test ! -d $source_package_path/$whisper_source_dir",
  }

  exec { 'whisper_install_cmd':
    cwd     => "$source_package_path/$whisper_source_dir",
    command => '/usr/bin/python setup.py install',
    creates => '/usr/local/bin/whisper-fetch.py',
    require => Exec['whisper_source_untar'],
  }
}
