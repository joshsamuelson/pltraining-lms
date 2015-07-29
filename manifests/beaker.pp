class lms::beaker {
  include docker
  package {'beaker':
    ensure   => present,
    provider => 'gem',
  }
  package {['rubygem-nokogiri']:
    ensure => present,
    before => Package['beaker']
  }
}
