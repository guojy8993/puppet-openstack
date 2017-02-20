使用说明:
1.拷贝该项目到puppet服务器 /usr/share/ 下
```
cp /path/to/puppet-opestack-newton /usr/share/
```

2.使用 install_rdo 脚本对目标puppet agent部署rdo
```
sh /usr/share/puppet-opestack-newton/puppet-openstack/common/rdo/install_rdo master.newton.com
```