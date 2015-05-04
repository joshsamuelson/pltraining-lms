class lms::lab_deps{
  # Clone the courseware and copy example files to appropriate places 
  vcsrepo { '/usr/src/courseware-lms-content':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/puppetlabs/courseware-lms-content.git',
    require  => Class['install_pe'],
  }
  file { '/etc/puppetlabs/puppet/modules/':
    ensure  => directory,
    source  => '/usr/src/courseware-lms-content/modules/',
    recurse => true,
    require => Vcsrepo['/usr/src/courseware-lms-content'],
  }
  file { '/etc/puppetlabs/puppet/hieradata/':
    source  => '/usr/src/courseware-lms-content/hiera/hieradata/',
    recurse => true,
    require => Vcsrepo['/usr/src/courseware-lms-content'],
  }
  file { '/etc/puppetlabs/puppet/hiera.yaml':
    source => '/usr/src/courseware-lms-content/hiera/hiera.yaml',
    require => Vcsrepo['/usr/src/courseware-lms-content'],
  }
}
