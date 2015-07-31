class systemd (
  $unit_path       = $systemd::params::unit_path,
  $service_exports = $systemd::params::service_exports
) inherits systemd::params  {

}
