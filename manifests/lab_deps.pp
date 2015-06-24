class lms::lab_deps{
  include lms::lab_repo
  include lms::course_selector
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
