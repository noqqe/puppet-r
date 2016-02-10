# Class: r::repository
# ===========================
#
# Installs the yum and apt-get source repo for R
#
#
# Examples
# --------
#
# @example
#    class { 'r::repository':
#    }
#
# Authors
# -------
#
# Neil Parley
#

class r::repository {

  case $::operatingsystem {
    'Ubuntu': {
      include ::apt
      $codename       = $::lsbdistcodename
      $os = downcase($::operatingsystem)
      apt::source { 'r-project':
              location    => "http://cran.r-project.org/bin/linux/${os}",
              # the '/' must be present, otherwise repo name is required
              release     => "${codename}/",
              repos       => '', # default repo is main (not present at cran)
              include => { 'src' => false },
              key => { 'server' => 'keyserver.ubuntu.com', 'id' =>  'E298A3A825C0D65DFD57CBB651716619E084DAB9'},
              notify      => Class['apt::update'],
            }
    }
    'CentOS': {
      contain ::epel
    }
    default: { fail("Not supported on osfamily ${::operatingsystem}") }
  }

}