# Module: 'mleone-systemd'
# Author: Michael Leone 

Puppet::Type.newtype(:systemctl) do
  @doc = "Puppet interface to systemctl."

  ensurable

  newparam(:name, :namevar => :true) do
     desc "The name of the service to configure."
     newvalues(/^([a-z0-9-]+)$/i)
  end 

  newproperty(:command) do
    desc "Command to pass to systemctl. One of 'enable', 'disable', 'start', 'stop', 'restart', 'try-restart', 'reload', 'reload-or-restart', 'reload-or-try-restart'"
    newvalues('enable', 'disable', 'start', 'stop', 'restart', 'try-restart', 'reload', 'reload-or-restart', 'reload-or-try-restart')
  end

end
