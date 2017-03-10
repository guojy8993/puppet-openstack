class neutron_controller_services {

    file { "mysql_root_passwd":
      replace => true,
      source  => "puppet:///modules/neutron_controller_services/mysql_root_passwd",
      path    => "/tmp/mysql_root_passwd",
    }
    
    file { "mysql_neutron_passwd":
      replace => true,
      source  => "puppet:///modules/neutron_controller_services/mysql_neutron_passwd",
      path    => "/tmp/mysql_neutron_passwd",
    }

    file { "neutron_controller_ip":
      replace => true,
      source  => "puppet:///modules/neutron_controller_services/neutron_controller_ip",
      path    => "/tmp/neutron_controller_ip",
    }
    
    file { "neutron_user_passwd":
      replace => true,
      source  => "puppet:///modules/neutron_controller_services/neutron_user_passwd",
      path    => "/tmp/neutron_user_passwd",
    }
    
    file { "nova_user_passwd":
      replace => true,
      source  => "puppet:///modules/neutron_controller_services/nova_user_passwd",
      path    => "/tmp/nova_user_passwd",
    }    

    file { "openstack_rabbit_passwd":
      replace => true,
      source  => "puppet:///modules/neutron_controller_services/openstack_rabbit_passwd",
      path    => "/tmp/openstack_rabbit_passwd",
    }    

    file { "rabbit_host_ip":
      replace => true,
      source  => "puppet:///modules/neutron_controller_services/rabbit_host_ip",
      path    => "/tmp/rabbit_host_ip",
    }    

    file { "keystone_host_ip":
      replace => true,
      source  => "puppet:///modules/neutron_controller_services/keystone_host_ip",
      path    => "/tmp/keystone_host_ip",
    }    

    file { "memcache_host_ip":
      replace => true,
      source  => "puppet:///modules/neutron_controller_services/memcache_host_ip",
      path    => "/tmp/memcache_host_ip",
    }    

    file { "provider_interface":
      replace => true,
      source  => "puppet:///modules/neutron_controller_services/provider_interface",
      path    => "/tmp/provider_interface",
    }
    
    file { "local_overlay_ip":
      replace => true,
      source  => "puppet:///modules/neutron_controller_services/local_overlay_ip",
      path    => "/tmp/local_overlay_ip",
    }
    
    file { "nova_metadata_host_ip":
      replace => true,
      source  => "puppet:///modules/neutron_controller_services/nova_metadata_host_ip",
      path    => "/tmp/nova_metadata_host_ip",
    }
    
    file { "metadata_secret":
      replace => true,
      source  => "puppet:///modules/neutron_controller_services/metadata_secret",
      path    => "/tmp/metadata_secret",
    }
    
    file { "config_neutron_controller":
      replace => true,
      source  => "puppet:///modules/neutron_controller_services/config_neutron_controller",
      path    => "/tmp/config_neutron_controller",
      require => File["mysql_root_passwd","mysql_neutron_passwd","neutron_controller_ip",
                      "neutron_user_passwd","nova_user_passwd","openstack_rabbit_passwd",
                      "rabbit_host_ip","keystone_host_ip","memcache_host_ip","provider_interface",
                      "local_overlay_ip","nova_metadata_host_ip","metadata_secret"],
    }

    exec { "config-neutron-controller":
      command => "sh /tmp/config_neutron_controller",
      path    => ["/usr/bin", "/usr/sbin"],
      require => File["config_neutron_controller"],
    }    
}
