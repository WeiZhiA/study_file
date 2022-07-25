network-security-config

# 1.介绍
Android 7.0 Nougat通过引入Android网络安全配置Network Security Configuration。配置安卓app定制网络配置的一个XML文件。如果它会检查所以的网络连接，禁止不符合要求的连接。

版本号   | 特点  
---|---    
Android 9.0 | 其网络通信将默认为TLS。仅信任系统证书
7.0-8.0 | 允许http的明文传输，仅信任系统证书
6.0及以下 | 允许http的明文传输，信任系统证书/用户证书


## 配置内容
配置内容   | 说明    
---|---                                                    
自定义信任锚     | 针对应用的安全连接自定义哪些证书授权机构 (CA) 值得信赖。例如，信任特定的自签名证书或限制应用信任的公共 CA 集。 |
仅调试替换   | 在应用中以安全方式调试安全连接，而不会增加安装设备的风险。 
选择停用明文流量 | 防止应用意外使用明文流量。
证书固定 | 限制应用仅安全连接到特定的证书。

# 2.内容
## 2.1 网络安全配置

res/xml/network_security_config.xml文件
```xml
<?xml version="1.0" encoding="utf-8"?>
<network-security-config> 

    <!-- 多个数据源，共同信任的证书 -->
    <base-config> 
        <!-- 配置信任的主机地址  -->
        <domain includeSubdomains="true">example.com</domain>
        <!-- 限制可信 CA 集，防止应用信任由任何其他 CA 颁发的欺诈性证书
        cleartextTrafficPermitted:true:配置可以使用明文流量。
        官方建议使用false，但是实际中有需要http连接-->
        <trust-anchors cleartextTrafficPermitted="true">
            <!-- 信任系统证书 -->
            <certificates src="system"/>
            <!-- 信任用户添加的 CA 证书 -->
            <certificates src="user" />
            <!-- 信任自定义的证书 -->
            <certificates src="@raw/extracas"/>   
        </trust-anchors> 
    </base-config>


    <!-- 针对每个网域的自定义配置 -->
    <domain-config> 
        <!-- 限制信任的域，可配置多个 -->
        <domain includeSubdomains="true">example.com</domain>

        <!-- 配置信任ca证书 -->
        <trust-anchors> 
            <!-- 可配置多个 -->
            <certificates src="@raw/my_ca"/> 
        </trust-anchors> 

        <!-- 一组公钥固定。若要信任某个安全连接，信任链中必须有一个公钥位于固定集内 -->
        <pin-set expiration="2018-01-01">
            <!-- 公钥的哈希值（X.509 证书的 SubjectPublicKeyInfo）提供证书集 -->
            <pin digest="SHA-256">7HIpactkIAq2Y49orFOOQKurWxmmSFZhBCoQYcRhJ3Y=</pin>
            
            <pin digest="SHA-256">fwza0LRMXouZHRC8Ei+4PyuldPDcf3UKgO/04cDM1oE=</pin>
            </pin-set>
    </domain-config> 


    <domain-config>
        <domain includeSubdomains="true">example.com</domain>
        <pin-set expiration="2018-01-01">
            <pin digest="SHA-256">7HIpactkIAq2Y49orFOOQKurWxmmSFZhBCoQYcRhJ3Y=</pin>
            <!-- 备用密钥，防止强制切换到新密钥或更改 CA 时，固定到某个 CA 证书或该 CA 的中间证书时），应用的连接性不会受到影响。 -->
            <pin digest="SHA-256">fwza0LRMXouZHRC8Ei+4PyuldPDcf3UKgO/04cDM1oE=</pin>
        </pin-set>
    </domain-config>


    <!-- 仅在清单文件 android:debuggable = true才会走这个，用于开发中的调试。
    但是一般不用这个，都是在当前文件夹下自定义一个网络安全配置  -->
    <debug-overrides>
        <trust-anchors>
            <certificates src="@raw/debug_cas"/>
        </trust-anchors>
    </debug-overrides>

</network-security-config>
```


## 2.清单文件配置
```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest>
    <application android:networkSecurityConfig="@xml/network_security_config" >
    </application>
</manifest>
```