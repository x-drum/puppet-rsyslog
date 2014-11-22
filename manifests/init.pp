# == Class: rsyslog
#
# A class for managing rsyslog server options
#
# Parameters:
# [*package_ensure*]
#    Ensure package installation [present, absent, purged, held, latest], default: present.
#
# [*default_config*]
#    Install a stanza with default configuration [true, false], default: false.
#
# Sample Usage:
# include 'rsyslog'
# class { 'rsyslog': 
#   package_ensure => absent,
#   default_config => true,
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
    $package_ensure = present,
    $default_config = false,
) inherits rsyslog::params {

  package { $rsyslog::params::package_name:
    ensure => $package_ensure,
  }

  service { $rsyslog::params::service_name:
    ensure     => 'running',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    subscribe  => File[$rsyslog::params::config_file],
    require    => [Package[$rsyslog::params::package_name], File[$rsyslog::params::config_file]],
  }

  if $::osfamily == 'openbsd' and ! defined(File["/etc/rc.d/${rsyslog::params::service_name}"]) {
    file { "/etc/rc.d/${rsyslog::params::service_name}":
      ensure  => present,
      owner   => $rsyslog::params::default_owner,
      group   => $rsyslog::params::default_group,
      mode    => '0744',
      source  => 'puppet:///modules/rsyslog/rsyslogd.rc',
      require => Package[$rsyslog::params::package_name],
    }
  }

  file { $rsyslog::params::config_file:
    ensure  => present,
    owner   => $rsyslog::params::default_owner,
    group   => $rsyslog::params::default_group,
    mode    => '0444',
    content => template("rsyslog/rsyslog.conf.erb"),
  }

  # note: all unmanaged config snippets will be discarded.
  file { $rsyslog::params::config_dir:
    ensure  => 'directory',
    owner   => $rsyslog::params::default_owner,
    group   => $rsyslog::params::default_group,
    mode    => '0755',
    recurse => true,
    purge   => true,
    force   => true,
  }

  if $default_config {
    rsyslog::snippet { '50-default':
      lines => [ '*.info;mail.none;authpriv.none;cron.none               /var/log/messages',
        'kern.*                      -/var/log/kern.log',
        'auth.*;authpriv.*           /var/log/auth.log',
        'daemon.*                    /var/log/daemon.log',
        'cron.*                      -/var/log/cron.log',
        'mail.*                      -/var/log/mail.log',
        'uucp,news.*                 /var/log/spooler',
        '*.emerg                     *',
        'local7.*                    /var/log/boot.log',
        '*.*                         /var/log/uncategorized.log',
      ]
    }
  }
}
