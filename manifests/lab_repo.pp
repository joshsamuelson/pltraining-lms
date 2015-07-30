class lms::lab_repo{
  # Clone the courseware and copy example files to appropriate places 
  vcsrepo { '/usr/src/courseware-lms-content':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/puppetlabs/courseware-lms-content.git',
  }
  file { '/etc/puppetlabs/code/modules/lms/':
    ensure  => directory,
    source  => '/usr/src/courseware-lms-content/modules/lms/',
    recurse => true,
    require => [Vcsrepo['/usr/src/courseware-lms-content'],Class['lms::install_pe']]
  }
}
