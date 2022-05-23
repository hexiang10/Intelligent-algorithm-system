### 后端 HTTPS 改造

将申请的 `https` 证书放置到 `nginx` 对应目录
根据框架内 `nginx https` 示例 更改后端代理为 `https`
![输入图片说明](https://images.gitee.com/uploads/images/2022/0224/133009_fe894cb4_1766278.png "屏幕截图.png")

### 监控中心 与 任务调度中心 改造

`监控中心` 与 `任务调度中心` 属于系统管控服务
应在内网使用 不应该暴漏到外网 也无需配置 `https`

更改 `系统 -> 菜单管理 -> 监控中心 与 任务调度中心` 菜单配置
将其改为 `外链访问`

![输入图片说明](https://images.gitee.com/uploads/images/2022/0224/133815_bd7d83d3_1766278.png "屏幕截图.png")
![输入图片说明](https://images.gitee.com/uploads/images/2022/0224/133830_8e740661_1766278.png "屏幕截图.png")

`nginx` 配置 `独立的端口` 进行反向代理即可访问(代理编写方式参考后端反向代理)

### Minio http 改造

参考 `Minio` 官方文档 将 `https` 证书放置到 `Minio` 对应文件夹内
在 `Minio` 启动命令 手动指定可以访问的 IP地址 [常见异常及解决方案参考](https://lionli.blog.csdn.net/article/details/124260888)

![输入图片说明](https://images.gitee.com/uploads/images/2022/0225/094536_dfa9227b_1766278.png "屏幕截图.png")

修改系统 `Minio` 配置 更改为 `https`
![输入图片说明](https://images.gitee.com/uploads/images/2022/0225/094626_abd0adf1_1766278.png "屏幕截图.png")