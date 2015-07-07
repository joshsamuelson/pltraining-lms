class lms::install_pe {
  
  $prod_module_path = '/etc/puppetlabs/puppet/environments/production/modules'

  file { '/etc/yum.repos.d/puppet_enterprise.repo':
    ensure => present,
    # This should probably be parameterized and templatized
    source => "puppet:///modules/lms/puppet_enterprise-3.8.1-el6.repo"
  }

  package { ['git','pe-puppetserver','pe-puppet']:
    ensure  => present,
    require => [Class['bootstrap::profile::get_pe'],Class['localrepo'],File['/etc/yum.repos.d/puppet_enterprise.repo']],
  }

  augeas { "environment timeout":
    context => "/files/etc/puppetlabs/puppet/puppet.conf/agent",
    changes => [
      "set environment_timeout 0",
    ],
    require => [Package['pe-puppetserver'],Package['pe-puppet']],
  }
  augeas { "disable deprecation warnings":
    context => "/files/etc/puppetlabs/puppet/puppet.conf/main",
    changes => [
      "set disable_warnings deprecations",
    ],
    require => [Package['pe-puppetserver'],Package['pe-puppet']],
  }

  # to use pe_gem to install the following gems, we first need pe_gem installed
  # using execs now till there is a more graceful solution
  
  exec { 'install trollop':
    command => '/opt/puppet/bin/gem install trollop -v 2.0',
    unless  => '/opt/puppet/bin/gem list trollop -i',
    require => [Package['pe-puppetserver'],Package['pe-puppet']],
  }
  
  exec { 'install serverspec':
    command => '/opt/puppet/bin/gem install serverspec -v 1.16.0',
    unless  => '/opt/puppet/bin/gem list serverspec -i',
    require => Exec['install rspec-its'],
  }
  exec { 'install rspec-its':
    command => '/opt/puppet/bin/gem install rspec-its -v 1.0.1',
    unless  => '/opt/puppet/bin/gem list rspec-its -i',
    require => Exec['install rspec-core'],
  }
  exec { 'install rspec-core':
    command => '/opt/puppet/bin/gem install rspec-core -v 2.99.0',
    unless  => '/opt/puppet/bin/gem list rspec -i',
    require => Exec['install rspec'],
  }
  exec { 'install rspec':
    command => '/opt/puppet/bin/gem install rspec -v 2.99.0',
    unless  => '/opt/puppet/bin/gem list rspec -i',
    require => [Package['pe-puppetserver'],Package['pe-puppet']],
  }

  file {'/etc/init.d/pe-puppet-master':
    ensure => present,
    mode   => 755,
    source => 'puppet:///modules/lms/pe-puppet-master',
  }

  service {'pe-puppet-master':
    ensure  => running,
    enable => true,
    require => [Package['pe-puppetserver'],Package['pe-puppet'],File['/etc/init.d/pe-puppet-master']]
  }

}
