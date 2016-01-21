define r::package($r_path = '/usr/bin/R', $repo = ['http://cran.rstudio.com',], $dependencies = false) {

  $repos = join($repo, "\' ,'")
  include ::r

  exec { "install_r_package_${name}":
    command => $dependencies ? {
      true    => "${r_path} -e \"install.packages('${name}', repos=c('${repos}'), dependencies = TRUE); library(${name})\"",
      default => "${r_path} -e \"install.packages('${name}', repos=c('${repos}'), dependencies = FALSE); library(${name})\""
    },
    unless  => "${r_path} -q -e \"library(${name})\"",
    require => Class['::r']
  }

}
