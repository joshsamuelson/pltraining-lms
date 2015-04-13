class lms::pe_agent {
  # Install PE agent packages from the local repo
  yumrepo {'pe_agent_local':
    baseurl  => 'file:///opt/puppet/packages/public/3.7.2/el-6-i386',
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
