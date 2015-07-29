class lms::beaker {
  include docker
  package {'beaker':
    ensure   => present,
    provider => 'gem',
  }
  package {['rubygem-nokogiri','gcc-c++']:
    ensure  => present,
    before  => Package['beaker'],
    require => Class['epel']
  }
}
