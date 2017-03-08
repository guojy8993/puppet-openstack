class glance {
    file { "glance_host":
      replace => true,
      source  => "puppet:///modules/glance/glance_host",
      path    => "/tmp/glance_host",
    }

    file { "glance_host_ip":
      replace => true,
      source  => "puppet:///modules/glance/glance_host_ip",
      path    => "/tmp/glance_host_ip",
    }
    
    file { "glance_user_passwd":
      replace => true,
      source  => "puppet:///modules/glance/glance_user_passwd",
      path    => "/tmp/glance_user_passwd",
    }  

    file { "mysql_glance_passwd":
      replace => true,
      source  => "puppet:///modules/glance/mysql_glance_passwd",
      path    => "/tmp/mysql_glance_passwd",
    }
   
    file { "mysql_root_passwd":
      replace => true,
      source  => "puppet:///modules/glance/mysql_root_passwd",
      path    => "/tmp/mysql_root_passwd",
    }
    
    file { "config-glance":
      replace => true,
      source  => "puppet:///modules/glance/config-glance",
      path    => "/tmp/config-glance",
      require => File["glance_host","mysql_root_passwd","mysql_glance_passwd","glance_user_passwd","glance_host_ip"],
    }    

    exec { "exec-config-glance":
        command => "sh /tmp/config-glance",
        path    => ["/usr/bin", "/usr/sbin"],
        require => File["config-glance"],
    }
}
