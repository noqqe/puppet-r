class r ( $version = 'installed' ) {

  case $::osfamily {
    'Debian': {
      package {'r-base': ensure => $version }
    }
    'RedHat': {
      package {'R-core': ensure => $version }
    }
    default: { fail("Not supported on osfamily ${::osfamily}") }
  }

}
