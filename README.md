# Puppet R module

This module gives you the ability to install R, but also R packages.

## Usage

To install R you need to include the class...

    class { '::r': }

To install a specific version of R...

    class { '::r': version => '3.2.1' }

Then define any packages you want to be installed...

    ::r::package { 'ggplot2': }
    ::r::package { 'reshape': }

To ensure that dependencies are resolved for packages...

    ::r::package { 'reshape': dependencies => true, }
    
If a different repo is needed then it must be given as an array, also,
an array of different repos can be given.

    ::r::package { 'ggplot2': repo => ['http://cran.rstudio.com', ], }

    ::r::package { 'datashieldclient': repo => ['http://cran.obiba.org', 'http://cran.rstudio.com'], 
    dependencies => true, }
