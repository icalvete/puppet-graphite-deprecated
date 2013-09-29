define graphite::carbon::retentions (

  $pattern    = undef,
  $retentions = undef,

) {

  concat::fragment { $name :
    target  => 'carbon_storage_schemas_file',
    content => "[$name]\npattern = $pattern\nretentions = $retentions\n\n",
    order   => 50,
  }
}
