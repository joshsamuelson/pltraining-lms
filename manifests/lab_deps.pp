class lms::lab_deps{
  file { '/etc/puppetlabs/puppet/modules/':
    ensure  => directory,
    source  => '/usr/src/courseware-lms-content/modules/',
    recurse => true,
  }
  file { '/etc/puppetlabs/puppet/hieradata/':
    source  => '/usr/src/courseware-lms-content/hiera/hieradata/',
    recurse => true,
  }
  file { '/etc/puppetlabs/puppet/hiera.yaml':
    source => '/usr/src/courseware-lms-content/hiera/hiera.yaml',
  }
}
