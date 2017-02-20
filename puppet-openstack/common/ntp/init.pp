class ntp {
  package { 'ntp':
    ensure => installed,
  }

  file {'/etc/ntp.conf': 
    replace => true,
    require => Package["ntp"],
    source  => 'puppet:///modules/ntp/ntp.conf',
    notify  => Service["ntpd"],
  }

  service { 'ntpd':
    ensure => running,
    enabled => true,
  }
}
