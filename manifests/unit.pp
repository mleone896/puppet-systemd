define systemd::unit (
  $template_file             = 'service.target.erb',
  $environment_file          = false,
  $environment_file_location = "/etc/sysconfig/${title}",
  $user                      = false,
  $pidfile                   = false,
  $pidfile_location          = "/var/run/${title}.pid",
  $start_command             = false,
  $description               = 'generice service description',
  $service_exports           = $systemd::params::service_exports
) {


  $unit_path        = '/usr/lib/systemd/system'



  # tell systemd to reload
  exec { 'systemd-daemon-reload':
    path        => '/bin:/usr/bin:/sbin:/usr/sbin',
    command     => 'systemctl daemon-reload',
    refreshonly => true,
    before      => Service[$title],
  }
  # create the service file from a template
  file {"${unit_path}/${title}.service":
    content => template("systemd/${template_file}"),
    before  => Service[$title],
    notify  => Exec['systemd-daemon-reload']
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
