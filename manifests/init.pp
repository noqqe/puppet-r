class r ( $version = 'installed' ) {

  class {'r::install': version => $version }
  contain 'r::install'
  
}
