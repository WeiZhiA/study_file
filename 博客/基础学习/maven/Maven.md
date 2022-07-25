Maven

# 重要概念

定位于唯一的jar包

| 标签         | 说明     
| ------------ | --- 
| project      | 工程的根标签。 
| modelVersion | 模型版本需要设置为 4.0。    
| groupId      | 这是工程组的标识。它在一个组织或者项目中通常是唯一的。例如，一个银行组织 com.companyname.project-group 拥有所有的和银行相关的项目。一般是倒写域名
| artifactId   | 这是工程的标识。它通常是工程的名称。例如，消费者银行。groupId 和 artifactId 一起定义了 artifact 在仓库中的位置。
| version      | 这是工程的版本号。在 artifact 的仓库中，它用来区分不同的版本。       



| 阶段   | 处理     | 描述                         |
| ------ | -------- | ---------------------------- |
| * 清理 | clear    | 执行必要清理                 |
| 验证   | validate | 验证项目                     | 验证项目是否正确且所有必须信息是可用的                   |
| * 编译 | compile  | 执行编译                     | 源代码编译在此阶段完成                                   |
| 测试   | Test     | 测试                         | 使用适当的单元测试框架（例如JUnit）运行测试。            |
| * 包装 | package  | 打包                         | 创建JAR/WAR包如在 pom.xml 中定义提及的包                 |
| 检查   | verify   | 检查                         | 对集成测试的结果进行检查，以保证质量达标                 |
| * 安装 | install  | 安装                         | 安装打包的项目到本地仓库，以供其他项目使用               |
| 部署   | deploy   | 部署                         | 拷贝最终的工程包到远程仓库中，以共享给其他开发人员和工程 |
| * 站点 | site     | 生产项目报告，站点，发布站点 |

```maven
maven install
```

| 版本管理       | 说明 |
| -------------- | ----- |
| 快照(SNAPSHOT) | 开发阶段，不稳定版本                             |
| Latest         | 最新发布版本，有可能是发布版，也有可能是snapshot |
| Release        | 最后一个发布版本 |

位置 | 名字 | 说明
---|---|---
本地仓库 | 本地仓库 |它是在第一次执行 maven 命令的时候才被创建。
远程仓库 | 中央仓库 | Maven 中央仓库是由 Maven 社区提供的仓库，其中包含了大量常用的库。
远程仓库 | 私服 | --
远程仓库 | 其他仓库 | --

## maven项目使用的仓库一共有如下几种方式：
1. 中央仓库，这是默认的仓库
2. 镜像仓库，通过 sttings.xml 中的 settings.mirrors.mirror 配置
3. 全局profile仓库，通过 settings.xml 中的 settings.repositories.repository 配置
4. 项目仓库，通过 pom.xml 中的 project.repositories.repository 配置
5. 项目profile仓库，通过 pom.xml 中的 project.profiles.profile.repositories.repository 配置
6. 本地仓库
   
## 搜索顺序如下：
local_repo > settings_profile_repo > pom_profile_repo > pom_repositories > settings_mirror >
central

setting 服务于当前电脑所有项目；  
pom：服务于当前项目


| 依赖范围           | 英文     | 说明 |
| ------------------ | -------- |---|
| 编译依赖范围，默认 | compile  | 编译，测试，运行都有效                                                                                  |
| * 测试依赖范围     | test     | 只对测试classpath有效，不会打包到运行和jar包，例如junit；如果不指定，导致以来加入到编译和运行，导致浪费 |
| * 已提供的依赖范围 | provided | 只对编译和测试的classpath有效，对运行的classpath无效，利润sevlet-api；如果不指定可能导致版本冲突        |
| 运行时的依赖范围   | runtime  | 只对测试和运行的classpath有效，对编译的classpatch无效，例如jdbc驱动，例如：JDBC驱动实现，               |

```maven
<scope>compile</scope>
```


# 依赖传递
最短路径原则；pom.xml，
路径相同，先声明的优先

```maven
<!-- 模型版本。必须是这样写，现在是maven唯一支持的版本 -->
<modelVersion>4.0.0</modelVersion>

<!-- 公司或者组织的唯一标志，并且配置时生成的路径也是由此生成， 如com.xinzhi，
maven会将该项目打成的jar包放本地路径：/com/xinzhi/ -->
<groupId>com.xinzhi</groupId>

<!-- 本项目的唯一ID，一个groupId下面可能多个项目，就是靠artifactId来区分的 -->
<artifactId>test</artifactId>

<!-- 本项目目前所处的版本号 -->
<version>1.0.0-SNAPSHOT</version>

<!-- 打包的机制，如pom,jar, war，默认为jar -->
<packaging>jar</packaging>

<!-- 为pom定义一些常量，在pom中的其它地方可以直接引用 使用方式 如下 ：
${file.encoding} -->
<!-- 常常用来整体控制一些依赖的版本号 -->
<properties>
    <file.encoding>UTF-8</file.encoding>
    <java.source.version>1.8</java.source.version>
    <java.target.version>1.8</java.target.version>
</properties>

<!-- 定义本项目的依赖关系，就是依赖的jar包 -->
<dependencies>
    <!-- 每个dependency都对应这一个jar包 -->
    <dependency>
        <!--一般情况下，maven是通过groupId、artifactId、version这三个元素值
        （俗称坐标）来检索该构件， 然后引入你的工程。如果别人想引用你现在开发的这个项目（前提是已开
        发完毕并发布到了远程仓库），-->
        <!--就需要在他的pom文件中新建一个dependency节点，将本项目的groupId、
        artifactId、version写入， maven就会把你上传的jar包下载到他的本地 -->
        <groupId>junit</groupId>
        <artifactId>junit</artifactId>
        <version>4.12</version>


        <!-- 依赖范围 -->
        <scope>complie</scope>

        <!-- 设置 依赖是否可选，默认为false,即子项目默认都继承。如果为true,
        则子项目必需显示的引入 -->
        <optional>false</optional>

        <!-- 依赖排除-->
        <exclusions>
            <exclusion>
                <groupId>org.slf4j</groupId>
                    <artifactId>slf4j-api</artifactId>
                </exclusion>
        </exclusions>
    </dependency>
</dependencies>
```

# 聚合与继承
模块与工程

聚合：多个模块可以打包成一个模块，打包方式pom。聚合的子模块可以再有子模块

集成：子模块可以使用父模块的依赖

# 仓库与镜像
maven/setting.xml
```maven
<repositories>

    <!-- 配置本地仓库的位置 -->
    <localRepository>/path/to/local/repo</localRepository>

    <!--更像一个拦截器，把下载指向指定的服务器-->
    <mirrors>
        <!--镜像-->
        <mirror>
            <id>alimaven</id>
            <!--被镜像的服务器ID-->
            <mirrorOf>central</mirrorOf>
            <name>aliyun maven</name>
            <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
        </mirror>
    </mirrors>


    <!-- 配置阿里云仓库 -->
    <repository>
        <id>alimaven</id>
        <name>aliyun maven</name>
        <url>http://maven.aliyun.com/nexus/content/groups/public/</url>

        <!-- 要release版本 -->
        <releases>
            <enabled>true</enabled>
        </releases>

        <!-- 不要快照 -->
        <snapshots>
            <enabled>false</enabled>
        </snapshots>
    </repository>

    <!-- 配置私服 -->
    <mirror>
        <id>Nexus Mirror</id>
        <name>Nexus Mirror</name>
        <url>http://localhost:8081/nexus/content/groups/public/</url>
        <mirrorOf>*</mirrorOf>
    </mirror>


</repositories>


<profiles>
```

pom配置仓库

```maven
<!-- 配置阿里云仓库 -->
</repositories>
    <repository>
        <id>alimaven</id>
        <name>aliyun maven</name>
        <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
        <!-- 要release版本 -->
        <releases>
            <enabled>true</enabled>
        </releases>
        <!-- 不要快照 -->
        <snapshots>
            <enabled>false</enabled>
        </snapshots>
    </repository>
</repositories>


<!-- 多环境配置 -->

<profiles>
    <profile>
        <!-- 激活这个配置 -->
        <activation>
            <activeByDefault>true</activeByDefault>
        </activation>

        <id>dev</id>
        <!-- 打包名 -->
        <build>
            <finalName>dev</finalName>
        </build>

        <!-- 依赖仓库, 优先级高 -->
        <repositories>
            <repository>
                <id>ali</id>
                <name>ali repo</name>
                <url>https://maven.aliyun.com/repository/central</url>
                <releases>
                    <enabled>true</enabled>
                </releases>
                <snapshots>
                    <enabled>true</enabled>
                </snapshots>
            </repository>
        </repositories>
    </profile>
<profiles>

```

pom.xml里面的仓库与setting.xml里的仓库功能是一样的。主要的区别在于，pom里的仓库是个性化
的。比如一家大公司里的setting文件是公用的，所有项目都用一个setting文件，但各个子项目却会引用
不同的第三方库，所以就需要在pom.xml里设置自己需要的仓库地址。


# Docker创建Nexus私服

1. 加速构建；
2. 节省带宽；
3. 节省中央maven仓库的带宽；
4. 稳定（应付一旦中央服务器出问题的情况）；
5. 可以建立本地内部仓库；
6. 可以建立公共仓库。
```maven
<mirror>
    <id>Nexus Mirror</id>
    <name>Nexus Mirror</name>
    <url>http://localhost:8081/nexus/content/groups/public/</url>
    <mirrorOf>*</mirrorOf>
</mirror>
```

Nexus 的仓库分为这么几类：
* hosted 宿主仓库：主要用于部署无法从公共仓库获取的构件（如 oracle 的 JDBC 驱动）以及自己
或第三方的项目构件；
* proxy 代理仓库：代理公共的远程仓库；
* group 仓库组：Nexus 通过仓库组的概念统一管理多个仓库，这样我们在项目中直接请求仓库组即可请求到仓库组管理的多个仓库。

```maven
<repositories>

    <repository>
        <!--仓库 id，repositories 可以配置多个仓库，保证 id 不重复-->
        <id>nexus</id>
        <!-- 优先级大于镜像 -->
        <!--仓库地址，即 nexus 仓库组的地址-->
        <url>http://192.168.120.201:8081/repository/maven-central/</url>
        <!--是否下载 releases 构件-->
        <releases>
        <enabled>true</enabled>
        </releases>
        <!--是否下载 snapshots 构件-->
        <snapshots>
        <enabled>true</enabled>
        </snapshots>
    </repository>
</repositories>

<!-- 发布 -->
<distributionManagement>
    <repository>
        <id>releases</id>
        <url>http://192.168.120.201:8081/repository/maven-releases/</url>
    </repository>

    <snapshotRepository>
        <id>snapshots</id>
        <url>http://192.168.120.201:8081/repository/maven-snapshots/</url>
    </snapshotRepository>
</distributionManagement>


<!-- 插件下载 -->
<pluginRepositories>
    <!-- 插件仓库，maven 的运行依赖插件，也需要从私服下载插件 -->
    <pluginRepository>
        <!-- 插件仓库的 id 不允许重复，如果重复后边配置会覆盖前边 -->
        <id>public</id>
        <name>Public Repositories</name>
        <url>http://192.168.120.201:8081/repository/maven-public/</url>
    </pluginRepository>
</pluginRepositories>

```

# maven
设置maven编译的jdk版本，maven3默认用jdk1.5，maven2默认用jdk1.3

```maven
<!-- 指定插件jdk版本 -->
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-compiler-plugin</artifactId>
    <version>3.1</version>
    <configuration>
        <source>1.8</source> <!-- 源代码使用的JDK版本 -->
        <target>1.8</target> <!-- 需要生成的目标class文件的编译版本 -->
        <encoding>UTF-8</encoding><!-- 字符集编码 -->
    </configuration>
</plugin>


<!-- tomcat插件 -->
<plugin>
    <groupId>org.apache.tomcat.maven</groupId>
    <artifactId>tomcat7-maven-plugin</artifactId>
    <version>2.2</version>
    <configuration>
        <port>8080</port>
        <uriEncoding>UTF-8</uriEncoding>
        <path>/xinzhi</path>
        <finalName>xinzhi</finalName>
    </configuration>
</plugin>

```

https://www.runoob.com/maven/maven-build-life-cycle.html


idea打包
https://www.bilibili.com/video/BV1Zo4y1o7Zx?p=9&spm_id_from=pageDriver