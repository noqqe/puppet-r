# R - Puppet

#### Table of Contents

1. [Description](#description)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This module gives you the ability to install R and also R packages. 

## Usage

To install R you need to include the class:

```puppet
class { '::r': }
```

To install a specific version of R:

```puppet
class { '::r': version => '3.2.1' }
```

Then define any packages you want to be installed...

```puppet
::r::package { 'ggplot2': }
::r::package { 'reshape': }
```

To ensure that dependencies are resolved for packages...

```puppet
::r::package { 'reshape': dependencies => true, }
```
    
If a different repo is needed then it must be given as an array, also,
an array of different repos can be given.

```puppet
::r::package { 'ggplot2': repo => ['http://cran.rstudio.com', ], }

::r::package { 'datashieldclient': repo => ['http://cran.obiba.org', 'http://cran.rstudio.com'], 
dependencies => true, }
```    

## Reference

### r::install

```puppet
class r::install ( $version = 'latest' )
```
This sub module installs and the R package to the system. `$version` defines the version of R to be 
installed. Default is latest. 
 
### r::repository

```puppet
class r::repository
```
Installs the R yum or apt-get repo onto the system. Called by `install`

### r::package

```puppet
define r::package($r_path = '/usr/bin/R', $repo = ['http://cran.rstudio.com',], $dependencies = false)
```
Installs an R package to the system. `$r_path` defines the path where R is installed, default `'/usr/bin/R'`. 
`$repo` defines the array of repos to search when installing packages. Default is the single array 
`['http://cran.rstudio.com',]`. `$dependencies` defines if the dependencies of the packages shouls also be
installed. Default is false.

## Limitations

Has only been tested on Ubuntu 14.04 and Centos 7. 

## Development

Open source, forks and pull requests welcomed. 




