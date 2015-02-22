class r::java_conf {

  case $::osfamily {
    'Debian': {
      $core_package = 'r-base'
    }
    'RedHat': {
      $core_package = 'R-core'
    }
    default: { fail("Not supported on osfamily ${::osfamily}") }
  }

  exec { 'javareconf':
    command     => 'R CMD javareconf',
    refreshonly => true,
    subscribe   => Package[$core_package],
  }

}
