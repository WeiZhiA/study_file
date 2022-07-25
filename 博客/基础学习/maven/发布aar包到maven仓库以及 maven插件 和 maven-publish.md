发布aar包到maven仓库以及 maven插件 和 maven-publish 插件的区别

# 插件
发布 aar 包到 maven 仓库，主要是使用 Gradle 提供的插件：  
maven 插件（旧版），在 Gradle 6.2 之后，就完全被弃用了（增加了 @Deprecated 注解）  
maven-publish 插件  


# 2、 什么是仓库（repository）
1、本地仓库： 无论使用 Linux 还是 Window，计算机中会有一个目录用来存放从中央仓库或远程仓库下载的依赖文件；
2、中央仓库： 开源社区提供的仓库，是绝大多数开源库的存放位置。比如 Maven 社区的中央仓库 Maven Central；
3、私有仓库： 公司或组织的自定义仓库，可以理解为二方库的存放位置。