mysql服务使用说明:

(1) 将该项目拷贝到 /usr/share/ 目录下
```
cp /path/to/puppet-opestack-newton /usr/share/
```

(2) 运行isntall_mysql脚本对制定宿主安装mysql
```
用法: sh /usr/share/puppet-opestack-newton/puppet-openstack/common/install_mysql <pupet-agent节点> <mysql-service-ip> <mysql服务root密码>

e.g:
sh /usr/share/puppet-opestack-newton/puppet-openstack/common/install_mysql master.newton.com 10.160.0.125 root
```