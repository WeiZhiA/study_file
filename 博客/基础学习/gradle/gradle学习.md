组件化发布

# 仓库
1、本地仓库

2、中央仓库

3、私有仓库

## 基础知识
Gradle是一个基于Apache Ant和Apache Maven概念的项目自动化构建工具。基于Groovy的特定领域语言来声明项目设置，而不是传统的XML。当前其支持的语言限于Java、Groovy和Scala，计划未来将支持更多的语言。

buildscript：声明gardle脚本自身所需要使用的资源，包括依赖项、maven仓库地址、第三方插件等。因为是引用，所以gradle在执行脚本时，会优先执行buildscript代码块中的内容。

allprojects块的repositories用于多项目构建，为所有项目提供共同所需依赖包。



谷歌：使用 Maven Publish 插件
https://developer.android.google.cn/studio/build/maven-publish-plugin


## Gradle 生命周期
总共分为3个阶段

(1)初始化阶段
(2)配置阶段
(3)执行阶段

在初始化阶段：执行settings.gradle,指定那些项目参与到构建中，创建project实例，

配置阶段：构造了一个模型来表示任务，并参与到构建中来。增量式构建特性决定来模型中的 task 是否需要运行。整个 build 的 project 以及内部的 Task 关系就确定了。配置阶段的实质为解析每个被加入构建项目的 build.gradle 脚本，比如通过 apply 方法引入插件，为插件扩展属性进行的配置等等。

执行阶段：所有的 task 都应该以正确的顺序被执行。执行顺序时由它们的依赖决定的。如果任务被认为没有被修改过，将被跳过


* Projet 提供的一些生命周期回调方法：

Gradle构建生命周期
https://juejin.cn/post/6844903741762568206

扩张属性

https://juejin.cn/post/6844903741762568206

afterEvaluate(closure)，afterEvaluate(action)
beforeEvaluate(closure)，beforeEvaluate(action)

//在 Project 进行配置前调用
void beforeEvaluate(Closure closure)
//在 Project 配置结束后调用
void afterEvaluate(Closure closure)
beforeEvaluate 必须在父模块的 build.gradle 对子模块进行配置才能生效，因为在当前模块的 build.gradle 中配置，它自己本身都没配置好，所以不会监听到。


* Gradle 提供的一些生命周期回调方法：

afterProject(closure)，afterProject(action)
beforeProject(closure)，beforeProject(action)


https://www.heqiangfly.com/2016/03/18/development-tool-gradle-lifecycle/

Gradle基本内容

https://oubindo.github.io/2019/08/30/%E4%B8%80%E7%AF%87%E6%96%87%E7%AB%A0%E7%9C%8B%E6%87%82gradle/


https://www.jianshu.com/p/090f2156debf
dependsOn表示在自己之前先执行这个方法


# 补充知识
## aar和jar
* jar  
*.jar：是 Java 的一种文档格式。只包含了class文件与清单文件 ，不包含资源文件，如图片等所有res中的文件。
JAR 文件不仅用于压缩和发布，而且还用于部署和封装库、组件和插件程序，并可被像编译器和 JVM 这样的工具直接使用

* aar
*.aar，AAR（Android Archive）包是一个Android库项目的二进制归档文件.
包含AndroidManifest.xml，classes.jar，res，R.txt等

使用aar文件
app的gradle文件
```gradle
    repositories {
        flatDir {
            dirs 'libs', '../common-library/libs'
        }
    }

...

implementation fileTree(include: ['*.jar'], dir: 'libs')
```


https://mp.weixin.qq.com/s/WtAe3KtZRqpeksDHoyDrrw

