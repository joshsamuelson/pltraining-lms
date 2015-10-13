class lms::course_selector{
  file { '/usr/local/bin/course_selector':
    ensure => present,
    mode   => '755',
    source => '/usr/src/courseware-lms-content/scripts/course_selector.rb',
    require => Vcsrepo['/usr/src/courseware-lms-content'],
  }
}
