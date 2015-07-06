class lms {
  # LMS training-specific setup
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  file { '/usr/bin/envpuppet':
    source => 'puppet:///modules/bootstrap/envpuppet',
    mode   => '0755',
  }

  # Add a few extra packages for convenience
  package { [ 'patch', 'screen', 'telnet', 'tree', 'wget' ] :
    ensure  => present,
    require => Class['localrepo'],
  }

  # Cache forge modules locally in the vm:
  include bootstrap::profile::cache_modules

  # Cache gems locally in the vm:
  include bootstrap::profile::cache_gems

  # configure user environment
  include userprefs::defaults

  file { '/etc/bash.bash_logout':
    ensure => present,
    source => 'puppet:///modules/lms/bash.bash_logout',
  }
  file {'/etc/profile.d/profile.sh':
    ensure => present,
    mode   => 755,
    source => 'puppet:///modules/lms/profile.sh',
  }

  # create local repos
  include localrepo

  # Add helper scripts
  include lms::scripts

  # Yum related config
  include lms::repos

  # Ruby related settings
  include lms::ruby_settings

  # Add Dependencies needed for LMS labs
  include lms::lab_deps

  # Network setttings
  include lms::network
  
  # Clean up extranous build stuff
  include lms::cleanup
  
  include epel

  include bootstrap::profile::installer_staging

  # Install PE
  class { 'bootstrap::profile::get_pe': 
    version        => '3.8.1',
    pe_destination => '/usr/src/'
  }
  include lms::install_pe
}
