# == Class: rsyslog::params
#
# part of rsyslog module, don't include directly
#
# === Authors
#
# Alessio Cassibba (X-Drum) <swapon@gmail.com>
#
# === Copyright
#
# Copyright 2014 Alessio Cassibba (X-Drum), unless otherwise noted.
#
class rsyslog::params {
	$config_file = '/etc/rsyslog.conf'
	$config_dir = '/etc/rsyslog.d'
	$package_name = 'rsyslog'

	case $::osfamily {
		openbsd: {
			$default_owner = root
			$default_group = wheel
			$service_name = 'rsyslogd'
		}
		default: {
			$default_owner = root
			$default_group = root
			$service_name = 'rsyslog'
		}
	}
}
