# Class: r::repository
# ===========================
#
# Installs the yum and apt-get source repo for R
#
# Examples
# --------
#
# @example
#    class { 'r::repository': }
#
# Authors
# -------
#
# Florian Baumann
# Neil Parley
#

class r::repository {

  case $::operatingsystem {
    /^(Debian|Ubuntu)$/: {
      include ::apt
      $os = downcase($::operatingsystem)
      apt::source { 'cran':
        location   => "http://cran.r-project.org/bin/linux/${os}",
        release    => "${::lsbdistcodename}/",
        repos      => '',
        key        => {
          'server' => 'keyserver.ubuntu.com',
          'id'     => 'E298A3A825C0D65DFD57CBB651716619E084DAB9'
        },
        notify  => Class['apt::update'],
      }
    }
    'CentOS': {
      include ::epel
    }
    default: { fail("Not supported on osfamily ${::operatingsystem}") }
  }

}
