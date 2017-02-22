class rabbitmq {

  package {
    'rabbitmq-server':
      provider => 'yum',
      ensure   => installed
  }
  
  file {
    '/tmp/rabbit-user':
      source  => 'puppet:///modules/rabbitmq/rabbit-user',
      require => Package["rabbitmq-server"];
    '/tmp/rabbit-passwd':
      require => Package["rabbitmq-server"],
      source => 'puppet:///modules/rabbitmq/rabbit-passwd';
    '/tmp/config-rabbit':
      require => Package["rabbitmq-server"],
      source => 'puppet:///modules/rabbitmq/config-rabbit'; 
  }  

  exec {
    'config-rabbitmq':
      command => "/bin/bash /tmp/config-rabbit",
      require => File["/tmp/rabbit-user","/tmp/rabbit-passwd","/tmp/config-rabbit"],
  }
}
