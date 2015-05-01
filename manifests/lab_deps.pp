class lms::lab_deps{
  package { 'puppet-lint':
    ensure   => present,
    provider => gem,
  }

  # Clone the courseware and copy example files to appropriate places 
  vcsrepo { '/usr/src/courseware-lms-content':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/puppetlabs/courseware-lms-content.git'
  }
  exec { 'copy modules':
    command => 'cp -r /usr/src/courseware-lms-content/modules/* /etc/puppetlabs/puppet/modules/',
    path    => '/bin/:/usr/bin',
    require => Vcsrepo['/usr/src/courseware-lms-content'],
  }
  exec { 'copy hieradata':
    command => 'cp -r /usr/src/courseware-lms-content/hiera/hieradata/ /etc/puppetlabs/puppet/',
    path    => '/bin/:/usr/bin',
    require => Vcsrepo['/usr/src/courseware-lms-content'],
  }
  exec { 'copy hiera.yaml':
    command => 'yes | cp /usr/src/courseware-lms-content/hiera/hiera.yaml /etc/puppetlabs/puppet/hiera.yaml',
    path    => '/bin/:/usr/bin',
    require => Vcsrepo['/usr/src/courseware-lms-content'],
  }


}
