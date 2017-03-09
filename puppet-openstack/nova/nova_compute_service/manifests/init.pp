class nova_compute_service {

    package { "openstack-nova-compute":
      ensure   => installed,
      provider => "yum",
      before   => File["config-nova-compute"],
    }

    file { "compute_host_ip":
      replace => true,
      source  => "puppet:///modules/nova_compute_service/compute_host_ip",
      path    => "/tmp/compute_host_ip", 
    }

    file { "glance_host_ip":
      replace => true,
      source  => "puppet:///modules/nova_compute_service/glance_host_ip",
      path    => "/tmp/glance_host_ip", 
    }

    file { "memcache_host_ip":
      replace => true,
      source  => "puppet:///modules/nova_compute_service/memcache_host_ip",
      path    => "/tmp/memcache_host_ip",
    }

    file { "novnc_host_ip":
      replace => true,
      source  => "puppet:///modules/nova_compute_service/novnc_host_ip",
      path    => "/tmp/novnc_host_ip", 
    }

    file { "rabbit_host_ip":
      replace => true,
      source  => "puppet:///modules/nova_compute_service/rabbit_host_ip",
      path    => "/tmp/rabbit_host_ip", 
    }

    file { "keystone_host_ip":
      replace => true,
      source  => "puppet:///modules/nova_compute_service/keystone_host_ip",
      path    => "/tmp/keystone_host_ip", 
    }

    file { "nova_user_passwd":
      replace => true,
      source  => "puppet:///modules/nova_compute_service/nova_user_passwd",
      path    => "/tmp/nova_user_passwd", 
    }

    file { "openstack_rabbit_passwd":
      replace => true,
      source  => "puppet:///modules/nova_compute_service/openstack_rabbit_passwd",
      path    => "/tmp/openstack_rabbit_passwd",
    }

    file { "config-nova-compute":
      replace => true,
      path    => "/tmp/config-nova-compute",
      source  => "puppet:///modules/nova_compute_service/config-nova-compute",
      require => File["compute_host_ip","glance_host_ip","memcache_host_ip","novnc_host_ip","rabbit_host_ip","keystone_host_ip","nova_user_passwd","openstack_rabbit_passwd"],
    }

    exec { "config-compute":
      command => "sh /tmp/config-nova-compute",
      path    => ["/usr/bin", "/usr/sbin"],
      require => File["config-nova-compute"],
    }

}
