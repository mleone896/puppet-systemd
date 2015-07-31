class systemd::params {

  $service_exports = hiera('systemd::service_exports ', false)

  # figure out the path where service targets go
  case $::osfamily {
    'Archlinux': {
      $unit_path = '/usr/lib/systemd/system'
    }
    'Debian': {
      $unit_path = '/lib/systemd/system'
    }
    'RedHat': {
      $unit_path = '/usr/lib/systemd/system'
    }
    default: {
      $unit_path = '/usr/lib/systemd/system'
    }
  }


}
