class mysql {

  package {
    'mariadb':
       provider => 'yum',
       ensure   => installed,
  }

  package {
    'mariadb-server':
       provider => 'yum',
       ensure   => installed,
    
  }
  
  package {
    'python2-PyMySQL': 
       provider => 'yum',
       ensure   => installed,
  }

  file {
    'mysql-conf':
      source  => 'puppet:///modules/mysql/openstack-mysql.cnf',
      require => Package["mariadb-server"],
      path    => '/etc/my.cnf.d/openstack.cnf';
    'mysql-secret':
      source  => 'puppet:///modules/mysql/mysql-passwd',
      path    => '/tmp/secret';
    'mysql-ip':
      source  => 'puppet:///modules/mysql/mysql-ip',
      path    => '/tmp/ip';
    }
  
  file {
    'config-mysql-shell':
      ensure  => present,
      source  => 'puppet:///modules/mysql/config-mysql',
      require => File["mysql-conf","mysql-secret","mysql-ip"],
      path    => '/tmp/config-mysql',
  }

  exec {
    'config-mysql':
      command => '/bin/bash /tmp/config-mysql && rm -rf /tmp/config-mysql',
      require => File["config-mysql-shell"],
      before  => Notify["notify-mysql-installed"],
  }

  notify {
    'notify-mysql-installed':
      message => 'MySQL successfully installed !',
  }

}
