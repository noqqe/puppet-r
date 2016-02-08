class r::install ( $version = 'latest' ) {

  include r::repository

  case $::operatingsystem {
    'Ubuntu': {
      Class['r::repository'] ->  Class["apt::update"] -> package {'r-base': ensure => $version, } -> package {'r-base-dev': ensure => $version}
    }
    'CentOS': {
      Class['r::repository'] -> package {'R': ensure => $version, }
    }
    default: { fail("Not supported on osfamily ${::operatingsystem}") }
  }

}