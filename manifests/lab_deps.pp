class lms::lab_deps{
  include lms::beaker
  file { '/etc/puppetlabs/code/modules/':
    ensure  => directory,
    source  => '/usr/src/courseware-lms-content/modules/',
    recurse => true,
    require => Vcsrepo['/usr/src/courseware-lms-content']
  }
}
