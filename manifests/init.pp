# Class: r
# ===========================
#
# Installs r and povides ability to install r packages on Ubuntu or Centos
#
# Parameters
# ----------
#
# * `version`
# Version of R that is to be installed. Default is latest. Can also be
# installed or version number.
#
# Examples
# --------
#
# @example
#    class { 'r':
#      version = 'latest',
#    }
#
# Authors
# -------
#
# Neil Parley
#

class r ( $version = 'latest' ) {

  class {'r::install': version => $version }
  contain 'r::install'
  
}
