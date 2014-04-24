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
	$pkg_ensure = 'present'

	case $::osfamily {
		default: {
			$config_file = '/etc/rsyslog.conf'
			$config_dir = '/etc/rsyslog.d'
			$package_name = 'rsyslog'
			$service_name = 'rsyslog'
		}
	}
}
