class lms {
  include lms::lab_deps
  include lms::lab_repo
  include lms::course_selector
  include lms::install_pe
  include lms::defaults

  host { $fqdn:
    ensure       => present,
    ip           => '127.0.0.1',
    host_aliases => ['localhost','puppet','localhost.localdomain'],
  }

}
