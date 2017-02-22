#### mysql服务使用说明:

(1) 将该项目拷贝到 /usr/share/ 目录下
```
cp /path/to/puppet-opestack-newton /usr/share/
```

(2) 运行install_rabbitmq脚本对制定宿主安装rabbitmq
```
用法: sh /usr/share/puppet-opestack-newton/puppet-openstack/common/install_rabbitmq <pupet-agent节点> <rabbit-user> <rabbit-passwd>

e.g:
sh /usr/share/puppet-opestack-newton/puppet-openstack/common/install_rabbitmq master.newton.com rabbit rabbit
```