# Class: r::install
# ===========================
#
# Installs r on the system
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `version`
# Version of R that is to be installed. Default is latest. Can also be
# installed or version number.
#
#
# Examples
# --------
#
# @example
#    class { 'r::install':
#      version = 'latest',
#    }
#
# Authors
# -------
#
# Neil Parley
#

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