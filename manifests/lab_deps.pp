class lms::lab_deps{
  file { '/etc/puppetlabs/puppet/modules/':
    ensure  => directory,
    source  => '/usr/src/courseware-lms-content/modules/',
    recurse => true,
    require => Vcsrepo['/usr/src/courseware-lms-content']
  }
}
