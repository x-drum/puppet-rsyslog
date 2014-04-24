# == Class: rsyslog
#
# A class for managing rsyslog server options
#
# Parameters:
# [*package_ensure*]
#    Ensure package installation [present, absent, purged, held, latest], default: present.  
#
# Sample Usage:
# include 'rsyslog'
# class { 'rsyslog': 
#   package_ensure => absent,
# }
#
# === Authors
#
# Alessio Cassibba (X-Drum) <swapon@gmail.com>
#
# === Copyright
#
# Copyright 2014 Alessio Cassibba (X-Drum), unless otherwise noted.
#
class rsyslog (
    $package_ensure = $rsyslog::params:package_ensure,
) inherits rsyslog::params {

  package { $rsyslog::params::package_name:
    ensure => $package_ensure,
  }

  service { $rsyslog::params::service_name:
    ensure  => 'running',
    enable  => true,
    hasstatus => true,
    hasrestart => true,
    subscribe => [Package[$rsyslog::params::package_name], File[$rsyslog::params::config_file]],
    require   => File[$rsyslog::params::config_file],
  }

  file { $rsyslog::params::config_file:
    ensure => present,
    owner => 'root',
    group => 'root',
    mode => '0444',
    content => template("rsyslog/rsyslog.conf.erb"),
  }

  # note: all unmanaged config snippets will be discarded.
  file { $rsyslog::params::config_dir:
    ensure  => 'directory',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    recurse => true,
    purge   => true,
    force   => true,
  }
}

