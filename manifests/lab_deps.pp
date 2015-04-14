class lms::lab_deps{
  package { 'puppet-lint':
    ensure   => present,
    provider => gem,
  }
}
