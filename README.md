zixapp
======

账务系统后台

1、目录与文件介绍

    1.1、 etc
    1.2、 conf
    1.3、 lib
    1.4、 libexec
    1.5、 bin
    1.6、 sbin
    1.7、 plugin
    1.8、 log
    1.9、 sql
    1.10、t

2、主要文件
    
    2.1、$ZIXAPP_HOME/conf/zeta.conf

        zeta主配置文件

    2.2、$ZIXAPP_HOME/conf/zixapp.conf

        zixapp的集中配置文件

    2.3、$ZIXAPP_HOME/libexec/main.pl

        zeta辅助配置文件-主控loop

    2.4、$ZIXAPP_HOME/libexec/plugin.pl

        zeta辅助配置文件-主控插件加载

    2.4、$ZIXAPP_HOME/libexec/proc.pl

        zeta辅助配置文件-模块loop函数-原始配置处理模块

    2.5、$ZIXAPP_HOME/libexec/service.pl

        zeta辅助配置文件-模块loop函数-服务接收模块

