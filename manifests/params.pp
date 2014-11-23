# Class: syslog::params
#
# part of rsyslog module, don't include directly
#
# Alessio Cassibba (X-Drum) <swapon@gmail.com>
#
# Copyright 2014 Alessio Cassibba (X-Drum), unless otherwise noted.
#
class rsyslog::params {
	case $::osfamily {
		FreeBSD, OpenBSD: {
			$default_owner = root
			$default_group = wheel
			$service_name = 'rsyslogd'
			$package_name = 'rsyslog'
			$config_file = '/usr/local/etc/rsyslog.conf'
			$config_dir = '/usr/local/etc/rsyslog.d'
		}
		default: {
			$default_owner = root
			$default_group = root
			$service_name = 'rsyslog'
			$package_name = 'rsyslog'
			$config_file = '/etc/rsyslog.conf'
			$config_dir = '/etc/rsyslog.d'
		}
	}
}
