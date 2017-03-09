class nova_controller_services {

    file { "mysql_nova_passwd":
      path    => "/tmp/mysql_nova_passwd",
      source  => "puppet:///modules/nova_controller_services/mysql_nova_passwd",
      replace => true,
    }

    file { "mysql_root_passwd":
      path    => "/tmp/mysql_root_passwd",
      source  => "puppet:///modules/nova_controller_services/mysql_root_passwd",
      replace => true,
    }

    file { "nova_controller":
      path    => "/tmp/nova_controller",
      source  => "puppet:///modules/nova_controller_services/nova_controller",
      replace => true,
    }

    file { "nova_controller_ip":
      path    => "/tmp/nova_controller_ip",
      source  => "puppet:///modules/nova_controller_services/nova_controller_ip",
      replace => true,
    }

    file { "nova_user_passwd":
      path    => "/tmp/nova_user_passwd",
      source  => "puppet:///modules/nova_controller_services/nova_user_passwd",
      replace => true,
    }

    file { "openstack_rabbit_passwd":
      path    => "/tmp/openstack_rabbit_passwd",
      source  => "puppet:///modules/nova_controller_services/openstack_rabbit_passwd",
      replace => true,
    }

    file { "deploy-nova-controller-services":
      path    => "/tmp/deploy-nova-controller-services",
      source  => "puppet:///modules/nova_controller_services/deploy-nova-controller-services",
      replace => true,
      require => File["openstack_rabbit_passwd","nova_user_passwd","nova_controller_ip","nova_controller","mysql_root_passwd","mysql_nova_passwd"],
    }

    exec { "deploy-nova-controller":
      command => "sh /tmp/deploy-nova-controller-services",
      path    => ["/usr/bin", "/usr/sbin"],
      require => File["deploy-nova-controller-services"], 
    }
}
