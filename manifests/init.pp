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

  file { '/root/lms.answers':
    soruce => 'puppet:///modules/lms/lms.answers',
  }



  # Add a few extra packages for convenience
  package { [ 'patch', 'screen', 'telnet', 'tree', 'wget' ] :
    ensure  => present,
    require => Class['localrepo'],
  }

  # Cache forge modules locally in the vm:
  class { 'bootstrap::cache_modules': cache_dir => '/usr/src/forge' }

  # Cache gems locally in the vm:
  class { 'bootstrap::cache_gems': }

  # configure user environment
  include userprefs::defaults

  # create local repos
  include localrepo

  # Add helper scripts
  include lms::scripts

  # Yum related config
  include lms::repos

  # Ruby related settings
  include lms::ruby_settings

  # Network setttings
  include lms::network
  
  # Clean up extranous build stuff
  include lms::cleanup
  
  # Get PE Agent
  #include lms::get_agent

  # Install PE agent
  #include lms::pe_agent
  
  include epel

  # Install PE
  class { 'bootstrap::get_pe': version => '3.7.2' }
  include lms::install_pe
}
