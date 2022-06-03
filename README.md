# 智能算法系统
> Server (server cluster) software system of intelligent algorithm interface (such as license plate recognition, expression recognition, cryptography algorithm, etc.) —— 智能算法系统(比如车牌识别、表情识别、密码学算法等)的服务器(服务器集群)软件系统

# 项目背景

国务院发布的《新一代人工智能发展规划》文件指明我国已经将人工智能上升为国家战略，本项目正是基于此文件的提出而进行开发。为此，根据鄙人所学习的课程知识，立志设计并实现一套对外提供智能算法接口(比如车牌识别、表情识别、密码学算法等)的服务器(服务器集群)软件系统。

# 项目要求

1.算法来自本地而不能再来自互联网上其它的服务器或服务器应用软件系统

2.系统必须包括登录用户信息验证模块

3.对外能提供连接Web或客户机或手机或物联网设备等客户端的接口


# 开发目的

本项目是鄙人大三期末课设课题作业。首先，意旨在考核中取得优异的成绩；其次，项目目前属于开发初产品，任有很多不足之处和待完善的地方，后续有时间会考虑继续完善，并且做的更系统一些（主要是还自己有很多知识有待去学哈哈哈）；最后，其实项目基础框架已经搭好了，也方便后期升级，集群拓展等，如果大家有兴趣，欢迎来fork或star，帮我一起完善，并给予我您宝贵的意见。

# 开发技术

项目是采用前后端分离的一个开发模式，在开发技术上会更加符合现如今的一个互联网趋势。

技术架构在 **Get Start** 中已经和大家进行了介绍，【智能算法系统】的基础架构是基于 **RuoYi-Vue-Plus** 框架所集成的软件系统，且该系统针对 `分布式集群` 场景有全方位升级以及更好的拓展支持，这里就不再赘述。

# 项目文档

![在这里插入图片描述](https://img-blog.csdnimg.cn/665196c04d0247e1a78ca81ddeb94868.png)

文档地址: https://he-xiang-best.github.io/AI-System/

项目资源：[https://download.csdn.net/download/HXBest/85442781](https://download.csdn.net/download/HXBest/85442781?_blank)

# 项目演示

> 项目介绍视频观看地址：[https://www.bilibili.com/video/BV17341137uL](https://www.bilibili.com/video/BV17341137uL?_blank)



# 登录功能

![在这里插入图片描述](https://img-blog.csdnimg.cn/f5d60d2f2778484e9da4f29ef12fe70e.png)




# 对象识别

![在这里插入图片描述](https://img-blog.csdnimg.cn/be5d4dac9c57471ab3e8cc4266c7da6d.gif)

# 人脸探测

![在这里插入图片描述](https://img-blog.csdnimg.cn/f7d6b04d9d964ae8b6569381017697f9.gif)

# 证件号识别

![在这里插入图片描述](https://img-blog.csdnimg.cn/a0410e5c2eb041be86d9398295a5f85f.gif)

# 手写数字识别

目前我项目的模型识别率不高，原因是传入的图片分辨率和训练的有些误差，在项目文档中也给了大家更好的模型代码参考，后期可以完善。

![在这里插入图片描述](https://img-blog.csdnimg.cn/061ca9ce9c9e416eadef987942102b52.gif)


# 轮廓识别

![在这里插入图片描述](https://img-blog.csdnimg.cn/0024d096386f4a4abdbce34907a2c927.gif)

# 车牌识别

以下展示的是正常情况：(目前前后端项目中整合有bug，但控制台直接main方法运行是完全没问题的)

![在这里插入图片描述](https://img-blog.csdnimg.cn/70db718c77cb4a9cb934236e2d9eb55f.gif)

# 密码工具

![](https://gitcode.net/HXBest/img-store/-/raw/master/ai-system/密码工具.gif)

# 边缘分割

![请添加图片描述](https://img-blog.csdnimg.cn/93d15c0eaa664315a03ce908743c1e73.gif)

# 边缘提取

![](https://gitcode.net/HXBest/img-store/-/raw/master/ai-system/边缘提取.gif)

# 双边滤波

![](https://gitcode.net/HXBest/img-store/-/raw/master/ai-system/双边滤波.gif)

# 高斯模糊

![](https://gitcode.net/HXBest/img-store/-/raw/master/ai-system/高斯模糊.gif)

