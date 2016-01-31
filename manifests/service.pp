define systemd::service(
  $template_file               = 'service.target.erb',
  $environment_file            = false,
  $environment_file_location   = "/etc/sysconfig/${title}",
  $user                        = false,
  $pidfile                     = false,
  $pidfile_location            = "/var/run/${title}.pid",
  $service_after               = undef,
  $service_type                = 'simple',
  $exec_start_pre              = undef,
  $exec_start_post             = undef,
  $exec_after                  = undef,
  $exec_reload                 = undef,
  $exec_stop                   = undef,
  $exec_stop_post              = undef,
  $timeout_start_sec           = undef,
  $restart_sec                 = undef,
  $timeout_stop_sec            = undef,
  $timout_sec                  = undef,
  $restart                     = undef,
  $description                 = 'generice service description',
  $success_exit_status         = undef,
  $restart_prevent_exit_status = undef,
  $service_exports             = undef,
  $permissions_start_only      = undef,
  $nonblocking                 = undef,
  $sockets                     = undef,
  $start_limit_action          = undef,
  $start_limit_interval        = undef,
  $start_limit_burst           = undef,
  $failure_action              = undef,
  $wanted_by                   = 'multi-user.target'
) {

  # default place for user-created systemd service files
  $service_path        = '/etc/systemd/system'



  # tell systemd to reload
  exec { "systemd-daemon-reload-${title}":
    path        => '/bin:/usr/bin:/sbin:/usr/sbin',
    command     => 'systemctl daemon-reload',
    refreshonly => true,
    before      => Service[$title],
  }
  # create the service file from a template
  file { "${service_path}/${title}.service":
    content => template("systemd/${template_file}"),
    before  => Service[$title],
    notify  => Exec["systemd-daemon-reload-${title}"]
  }

  # check to see if we have env vars
  if $environment_file {
    # drop the environment file
    file { "/etc/sysconfig/${title}":
      content => template('systemd/sysconfig.erb'),
      before  => Service[$title],
    }
  }

  # start the systemd service
  service { $title:
    ensure  => 'running',
  }

}
