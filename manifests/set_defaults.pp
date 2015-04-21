# Add default memory settings after PE install

class lms::set_defaults {
  file { '/etc/puppetlabs/puppet/hieradata':
    ensure => directory,
    require => Class['lms::install_pe'],
  }
  file { '/etc/puppetlabs/puppet/hieradata/defaults.yaml':
    ensure => present,
    source => 'puppet:///modules/lms/defaults.yaml',
    require => File['/etc/puppetlabs/puppet/hieradata'],
  }
}

