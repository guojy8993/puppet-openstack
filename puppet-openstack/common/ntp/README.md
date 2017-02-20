#### 安装NTP服务

> **建议:**

> 主控节点以机房专门ntp server为准校时,为本集群提供ntp服务

> ntp server以及ntp client服务器的ntp.conf配置略有不同,参考模板配置文件

```
官方说明: We recommend that you configure the controller node to reference more accurate (lower stratum) servers and other nodes to reference the controller node.
```

#### 本模块的使用说明
1. 拷贝本项目到puppet server的/usr/share/下,
```
cp /path/to/puppet-opestack-newton /usr/share/
```

2.使用脚本向指定节点推送ntp
```
语法: sh /usr/share/puppet-opestack-newton/puppet-openstack/common/ntp/install_ntp \
         <puppet-agent> <ntp-role(server|client)> <upstream-htp-server>
```

e.g:
```
sh /usr/share/puppet-opestack-newton/puppet-openstack/common/ntp/install_ntp \
   master.newton.com server 10.154.88.88 
```
又e.g:
```
sh /usr/share/puppet-opestack-newton/puppet-openstack/common/ntp/install_ntp \
   comp122.newton.com client master.newton.com 
```
> **注意:**

> master.newton.com 是 *.newton.com 集群的 ntp server

> master.newton.com 上游ntp server 为 10.154.88.88

#### 附录

[集群NTP设置](https://docs.openstack.org/newton/install-guide-rdo/environment-ntp.html)