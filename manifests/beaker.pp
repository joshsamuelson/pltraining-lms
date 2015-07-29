class lms::beaker {
  include docker
  package {'beaker':
    ensure   => present,
    provider => 'gem',
  }
  package {['zlib-devel','libxml2-devel','gcc-c++','libstdc++-devel']:
    ensure => present,
    before => Package['beaker']
  }
}
