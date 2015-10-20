class systemd::params {

  $service_exports = hiera('systemd::service_exports ', false)


}
