#### mysql服务使用说明:

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

> **NOTE:**

> 实践中发现, agent端会定时与master端同步,在此情况下,第一次部署的mysql应用可能会被后来的

> 再次同步修改地不可用,故而,我们关闭自动同步

#### 附录
[puppet禁用agent自动同步](http://www.linuxtone.org/thread-22751-1-1.html)

[mysql修改密码的N种方法](http://jingyan.baidu.com/article/0320e2c198ad5f1b87507bc8.html)