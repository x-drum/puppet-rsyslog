## This module manages rsyslog.

Currently supports: RHEL/CentOS, OpenBSD, Gentoo

## Class: rsyslog

A class for managing rsyslog server options.

### Parameters:
[*package_ensure*]  
  Ensure package installation [present, absent, purged, held, latest], default: present.

### Sample Usage:

```
include 'rsyslog'
```

 ```puppet
 class { 'rsyslog':
   package_ensure => absent,
 }
 ```
## Resource: rsyslog::snippet

A resource for managing rsyslog client stanzas

### Parameters:
  [*lines*]  
    An array containing stanza's lines.

### Sample Usage:

 ```puppet
 rsyslog::snippet { '20-puppet':
   lines => [ ':programname, isequal, "puppet-agent" /var/log/puppet/puppet.log', '& ~' ]
 }
 ```

### Copyright:
Copyright 2014 Alessio Cassibba (X-Drum), unless otherwise noted.