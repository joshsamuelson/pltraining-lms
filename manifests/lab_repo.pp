class lms::lab_repo{
  # Clone the courseware and copy example files to appropriate places 
  vcsrepo { '/usr/src/courseware-lms-content':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/puppetlabs/courseware-lms-content.git',
  }
}
