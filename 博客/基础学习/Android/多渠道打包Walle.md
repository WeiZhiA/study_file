
多渠道打包Walle

# 基本概念
数字签名：保证信息不回被串改
当公钥算法与摘要算法结合起来使用时，便构成了一种有效地数字签名方案

签名证书：保证安全传输公钥。  

数字证书是一个经证书授权（Certificate Authentication）中心数字签名的包含公钥拥有者信息以及公钥的文件。格式普遍采用的是 X.509 V3 国际标准。

# v1/v2/v3
v1 到 v2 主要是为了解决 JAR 签名方案的安全性问题，v3 结构上并没有太大的调整。

优秀的渠道吧方案：Walle（美团）、VasDolly（腾讯）

7.0以上的手机优先检测V2签名，如果V2签名不存在，再校验V1签名，对于7.0以下的手机，不存在V2签名校验机制，只会校验V1，所以，如果你的App的miniSdkVersion<24(N)，那么你的签名方式必须内含V1签名

覆盖安装同全新安装相比较多了几个校验

包名一致
证书一致
versioncode不能降低

## v1
(1)签名校验速度慢 校验过程中需要对apk中所有文件进行摘要计算，在 APK 资源很多、性能较差的机器上签名校验会花费较长时间，导致安装速度慢。
(2)完整性保障不够 META-INF 目录用来存放签名，自然此目录本身是不计入签名校验过程的，可以随意在这个目录中添加文件，比如一些快速批量打包方案就选择在这个目录中添加渠道文件。

可以理解单个文件完整性校验的意义并不是很大，安装的时候反而耗时，不如采用更加简单的便捷的校验方式。V2签名就不针对单个文件校验了，而是针对APK进行校验，将APK分成1M的块，对每个块计算值摘要，之后针对所有摘要进行摘要，再利用摘要进行签名。

安装的时候，块摘要可以并行处理，这样可以提高校验速度。



META-INF文件
MANIFEST.MF：摘要文件，存储文件名与文件SHA1摘要（Base64格式）键值对

CERT.SF：二次摘要文件，存储文件名与MANIFEST.MF摘要条目的SHA1摘要（Base64格式）键值对，格式如下

CERT.RSA中，我们能获的证书的指纹信息，在微信分享、第三方SDK申请的时候经常用到，其实就是公钥+开发者信息的一个签名。
从整体上保证APK的来源及完整性，不过META_INF中的文件不在校验范围中，这也是V1的一个缺点

# v2
只有V2签名，那么APK包内容几乎是没有改动的

V1：应该是通过ZIP条目进行验证，这样APK 签署后可进行许多修改 - 可以移动甚至重新压缩文件。

V2：验证压缩文件的所有字节，而不是单个 ZIP 条目，因此，在签名后无法再更改(包括 zipalign)。正因如此，现在在编译过程中，我们将压缩、调整和签署合并成一步完成。好处显而易见，更安全而且新的签名可缩短在设备上进行验证的时间（不需要费时地解压缩然后验证），从而加快应用安装速度。



# 美团打包
我们直接解压apk，解压后的根目录会有一个META-INF目录，
如果在META-INF目录内添加空文件，可以不用重新签名应用。因此，通过为不同渠道的应用添加不同的空文件，可以唯一标识一个渠道。


V1签名：META_INFO文件夹下增加文件不会对校验有任何影响，则是美团V1多渠道打包方案的切入点
V2签名：V2签名块中可以添加一些附属信息，不会对签名又任何影响，这是V2多渠道打包的切入点。
