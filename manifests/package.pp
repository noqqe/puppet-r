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
#                 dependencies => true,
#               }
#
# Authors
# -------
#
# Neil Parley
#

define r::package($r_path = '/usr/bin/R', $repo = ['http://cran.rstudio.com',], $dependencies = false) {

  $repos = join($repo, "\' ,'")
  include ::r

  exec { "install_r_package_${name}":
    command => $dependencies ? {
      true    => "${r_path} -e \"install.packages('${name}', repos=c('${repos}'), dependencies = TRUE); library(${name})\"",
      default => "${r_path} -e \"install.packages('${name}', repos=c('${repos}'), dependencies = FALSE); library(${name})\""
    },
    unless  => "${r_path} -q -e \"library(${name})\"",
    timeout => 600,
    require => Class['::r']
  }

}
