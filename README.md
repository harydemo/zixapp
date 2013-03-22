zixapp
======

账务系统后台

1、目录与文件介绍

    1.1、 etc - 环境变量设置

        1.1.1、profile.mak 
            开发用环境变量

        1.1.2、profile.zixapp
            开发用环境变量设置

        1.1.3、用到一下环境变量

            ZETA_HOME    : zeta安装目录
            ZIXAPP_HOME  : 应用的主目录
            PLUGIN_PATH  : 插件查找目录
            DB_XXX       : 数据库相关环境
            ZAPP_DEBUG   : 调试 
         
    1.2、 conf - 配置目录

        zeta.conf    : zeta主配置文件
        zixapp.conf  : zixapp的集中配置文件
           
    1.3、 lib

    1.4、 libexec

        plugin.pl   : zeta辅助配置文件-主控插件加载
        main.pl     : zeta辅助配置文件-主控loop
        proc.pl     : zeta辅助配置文件-模块loop函数-原始配置处理模块
        service.pl  : zeta辅助配置文件-模块loop函数-服务接收模块

    1.5、 bin

    1.6、 sbin
        
        runall
        stopall
              
    1.7、 plugin
    1.8、 log
    1.9、 sql
    1.10、t


2、执行




