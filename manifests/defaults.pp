# Add default memory settings after PE install

class lms::defaults {
  file { '/etc/puppetlabs/code/hieradata':
    ensure => directory,
    require => Class['lms::install_pe'],
  }
  file { '/etc/puppetlabs/code/hieradata/defaults.yaml':
    ensure => present,
    source => 'puppet:///modules/bootstrap/lms/defaults.yaml',
    require => File['/etc/puppetlabs/code/hieradata'],
  }
}
