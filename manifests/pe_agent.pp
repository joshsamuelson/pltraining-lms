class lms::pe_agent (
  $pe_version                = $::lms::params::pe_version,
  $operatingsystemmajrelease = $::operatingsystemmajrelease,
  $architecture              = $::architecture
) inherits ::lms::params {
  # Install PE agent packages from the local repo
  yumrepo {'pe_agent_local':
    baseurl  => "file:///opt/puppet/packages/public/${pe_version}/el-${operatingsystemmajrelease}-${architecture}",
    enabled  => '1',
    gpgcheck => '0',
    descr    => 'Local PE agent repo',
    require  => Class['lms::get_agent'],
  }
  # Install PE agent packages from the local repo
  package { 'pe-agent':
    ensure  => present,
    require => Yumrepo['pe_agent_local'],
  }
}
