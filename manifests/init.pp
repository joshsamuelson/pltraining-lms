class lms {
  include bootstrap::profile::base

  # Cache forge modules locally in the vm:
  include bootstrap::profile::cache_modules

  # Cache gems locally in the vm:
  include bootstrap::profile::cache_gems

  # configure user environment
  include userprefs::defaults

  include bootstrap::profile::lms_base

  # create local repos
  include localrepo

  # Add helper scripts
  include lms::scripts

  # Yum related config
  include bootstrap::profile::yum

  # Ruby related settings
  include bootstrap::profile::ruby

  # Add Dependencies needed for LMS labs
  include lms::lab_deps

  # Network setttings
  include bootstrap::profile::network
  include bootstrap::profile::classroom_ssh
  
  
  include epel

  include bootstrap::profile::installer_staging

  # Install PE
  include bootstrap::profile::get_pe

  include lms::install_pe
}
