# Type: r::package
# ===========================
#
# Installs an R package into the R system
#
# Parameters
# ----------
#
# * `r_path`
# Path where R is installed. Default is '/usr/bin/R'
# * `repo`
# Array of the repos to search for the package in. Default ['http://cran.rstudio.com',]
# * `dependencies`
# If the package dependencies should be also. Default is false.
#
# Examples
# --------
#
# @example
#    r::package { 'reshape':
#      dependencies => true,
#    }
#
# Authors
# -------
#
# Florian Baumann
# Neil Parley
#

define r::package (
  Variant[String, Undef] $version = undef,
  String $repo = 'http://cran.rstudio.com',
  Boolean $dependencies = false,
) {

  include ::r

  if $version {
    # we need to make sure that devtools pkg is present to install custom
    # versioned packages of R
    if !defined (Exec['install_devtools_pkg']){
      exec { "install_devtools_pkg":
        command =>  "R -e \"install.packages('devtools', repos='${repo}', dependencies=TRUE)\"",
        path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
        timeout => 600,
        unless  => "R -q -e '\"devtools\" %in% installed.packages()' | grep 'TRUE'",
      }
    }

    exec { "install_r_custom_version_package_${name}":
      command => "R -e \"require('devtools') ; install_version('${name}', version='${version}', repos='${repo}')\"",
      path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      timeout => 600,
      unless  => "R -q -e '\"${name}\" %in% installed.packages()' | grep 'TRUE'",
      require => Exec['install_devtools_pkg'],
    }

  }
  else{
    exec { "install_r_package_${name}":
      command => "R -e \"install.packages('${name}', repos='${repo}', dependencies = ${_deps})\"",
      path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
      timeout => 600,
      unless  => "R -q -e '\"${name}\" %in% installed.packages()' | grep 'TRUE'",
      require => Package['r-base'],
    }
  }

}
