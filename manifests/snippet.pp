# == Class: rsyslog::snippet
#
# A resource for managing rsyslog client stanzas
#
# Parameters:
#  [*lines*]
#    An array containing stanza's lines.
#
# Sample Usage:
#  rsyslog::snippet { '20-puppet':
#    lines => [ ':programname, isequal, "puppet-agent" /var/log/puppet/puppet.log', '& ~' ],
#  }
#
#  will produce the file:
#  # HEADER: Warning: This file is managed by puppet,
#  # HEADER: *do not* edit manually.
#  :programname, isequal, "puppet-agent" /var/log/puppet/puppet.log
#  & ~
#
# === Authors
#
# Alessio Cassibba (X-Drum) <swapon@gmail.com>
#
# === Copyright
#
# Copyright 2014 Alessio Cassibba (X-Drum), unless otherwise noted.
#
define rsyslog::snippet (
  $lines
){
  include rsyslog

  if ! is_array($lines) {
    fail("The argument lines must be an array.")
  }

  file { "$rsyslog::params::config_dir/${name}.conf":
    ensure => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    content => inline_template("# HEADER: Warning: This file is managed by puppet,\n# HEADER: *do not* edit manually.\n\n <%= lines.collect{|x| x.to_s+'\n'} %>"),
    notify => Service['rsyslog'],
  }
}

