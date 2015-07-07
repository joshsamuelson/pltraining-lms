class lms::scripts {
  # Populate the VM with our helper scripts.
  file {'/usr/local/bin':
    ensure  => directory,
    recurse => true,
    replace => false,
    mode    => '0755',
    source  => '/usr/src/puppetlabs-training-bootstrap/scripts/classroom',
  }
}
