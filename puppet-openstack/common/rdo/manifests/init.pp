class rdo {
  package {
    'centos-release-openstack-newton':
      provider => 'yum',
      ensure   => installed,
      before   => Exec["upgrade"]
  }
  
  exec {
    'upgrade':
      command => 'yum upgrade -y',
      onlyif  => "test $(rpm -qa | grep centos-release-openstack-newton | wc -l) -gt 0",
      path    => ["/usr/bin","/usr/sbin"],
      cwd     => '/root',
  }
  
  package {
    ['python-openstackclient',
     'openstack-selinux']:
      provider => 'yum',
      ensure   => installed,
      require  => Exec["upgrade"],
  }
}
