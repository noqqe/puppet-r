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

To configure R for use with Java packages...

    include ::r::java_conf
