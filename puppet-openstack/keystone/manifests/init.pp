class keystone {

    file { "root_passwd":
      path    => "/tmp/mysql_root_passwd",
      replace => true,
      source  => "puppet:///modules/keystone/mysql_root_passwd",
    }

    file { "keystone_passwd":
      path    => "/tmp/mysql_keystone_passwd",
      replace => true,
      source  => "puppet:///modules/keystone/mysql_keystone_passwd",
    }

    file { "mysql_host_ip":
      path    => "/tmp/mysql_host_ip",
      replace => true,
      source  => "puppet:///modules/keystone/mysql_host_ip",
    }
    
    file { "init-keystone-db":
      path    => "/tmp/init-keysone-db",
      replace => true,
      source  => "puppet:///modules/keystone/init-keysone-db",
      require => File["root_passwd", "keystone_passwd", "mysql_host_ip"],
    }

    exec { "build-keystone-db":
      require => File["init-keystone-db"],
      command => "sh /tmp/init-keysone-db >> /tmp/err.log 2>&1",
      path    => ["/usr/bin", "/usr/sbin"]
    }

    package { "openstack-keystone":
      ensure  => installed,
      require => Exec["build-keystone-db"],
      before  => File["config-keystone"],
    }
    
    file { "my-iniconfig-tool":
      replace => true,
      ensure  => present,
      path    => "/usr/bin/ini-config",
      source  => "puppet:///modules/keystone/ini-config",
      mode    => "0755",
    }

    file { "dashboard-admin-pass":
      path     => "/tmp/dashboard-admin-pass",
      source   => "puppet:///modules/keystone/dashboard-admin-pass",
      replace  => true,
      ensure   => present,
    }

    file { "config-keystone":
      replace  => true,
      require  => File["my-iniconfig-tool", "dashboard-admin-pass", "keystone_passwd", "mysql_host_ip"],
      ensure   => present,
      path     => "/tmp/config-keystone",
      source   => "puppet:///modules/keystone/config-keystone",
    }

    exec { "config-keystone":
      command  => "sh /tmp/config-keystone",
      path    => ["/usr/bin", "/usr/sbin"],
      require => File["config-keystone"], 
    }
    
    package { "httpd":
      ensure  => installed,
      require => Exec["config-keystone"],
    }

    package { "mod_wsgi":
      ensure  => installed,
      require => Package["httpd"],
    }

    file { "keystone_host":
      replace => true,
      source  => "puppet:///modules/keystone/host",
      path    => "/tmp/host",
    }
  
    file { "init-keystone-httpd":
      replace => true,
      source  => "puppet:///modules/keystone/init-keystone-httpd",
      path    => "/tmp/init-keystone-httpd",
      require => Package["httpd","mod_wsgi"],
    }

    exec { "config-keystone-httpd":
      command => "sh /tmp/init-keystone-httpd",
      path    => ["/usr/bin", "/usr/sbin"],
      require => File["keystone_host","init-keystone-httpd"],
    }

    file { "demo-passwd":
      replace => true,
      source  => "puppet:///modules/keystone/demo_passwd",
      path    => "/tmp/demo_passwd",
      require => Exec["config-keystone-httpd"],
    }
    
    file { "add-keystone-demo":
      replace => true,
      source  => "puppet:///modules/keystone/add_keystone_demo",
      path    => "/tmp/add_keystone_demo",
      require => Exec["config-keystone-httpd"],
    }

    exec { "add-demo":
      command => "sh /tmp/add_keystone_demo",
      path    => ["/usr/bin", "/usr/sbin"],
      require => File["demo-passwd","add-keystone-demo"],
    }
}
