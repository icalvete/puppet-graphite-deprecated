class graphite::whisper inherits graphite::params {

  anchor { 'graphite::whisper::begin':
    before  => Class['graphite::whisper::install']
  }

  class { 'graphite::whisper::install' :
    require => Anchor['graphite::whisper::begin']
  }

  anchor { 'graphite::whisper::end' :
    require => Class['graphite::whisper::install']
  }
}
