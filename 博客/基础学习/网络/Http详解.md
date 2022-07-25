Http详解
<!-- TOC -->

- [1.简介](#1简介)
  - [1.1.特点](#11特点)
  - [1.2.Http注意](#12http注意)
  - [1.3.http格式](#13http格式)
  - [1.4.请求的过程](#14请求的过程)
- [2.请求方式](#2请求方式)
  - [1.GET](#1get)
  - [2.POST](#2post)
  - [3.PUT](#3put)
  - [4.DELETE](#4delete)
  - [5.HEAD](#5head)
  - [6.PUT](#6put)
- [3.常见头部](#3常见头部)
  - [1.Host](#1host)
  - [2.Content-Type](#2content-type)
  - [3.Content-Length](#3content-length)
  - [4.Transfer: chunked](#4transfer-chunked)
  - [6.Location](#6location)
  - [7.User-Agent](#7user-agent)
  - [8.Range / Accept-Range](#8range--accept-range)
  - [9.其他 Headers](#9其他-headers)
  - [10.Cache](#10cache)
  - [11.Buffer](#11buffer)
- [4.Content-Type详细说明](#4content-type详细说明)
  - [1.text/html](#1texthtml)
  - [2.x-www-form-urlencoded](#2x-www-form-urlencoded)
  - [3.multitype/form-data](#3multitypeform-data)
  - [4.application/json , image/jpeg , application/zip](#4applicationjson--imagejpeg--applicationzip)
- [4.Status Code状态码](#4status-code状态码)
- [参考文档](#参考文档)

<!-- /TOC -->



# 1.简介
HTTP协议是Hyper Text Transfer Protocol（超文本传输协议）的缩写,基于TCP/IP通信协议来传递数据（HTML 文件, 图片文件, 文字等）

## 1.1.特点
* HTTP协议工作于客户端-服务端架构上
* HTTP默认端口号为80，但是你也可以改为8080或者其他端口
*  80（HTTP） 或 443（HTTPS）端口通信

## 1.2.Http注意
* 1.HTTP是无连接：限制每次连接只处理一个请求。服务器处理完客户的请求，并收到客户的应答后，即断开连接。采用这种方式可以节省传输时间
* 2.HTTP是无状态协议：服务器不知道上传传输的数据内容，数据只能重新，数据量变大了，但是应答比较快
* 3.HTTP是媒体独立，客户端和服务器，通过mime-type告诉对方传输的内容格式

## 1.3.http格式
* 1.说明
```
请求行： 请求方式  url  协议版本
请求头/消息报头： 头部字段：值

请求内容
```
## 1.4.请求的过程
手机 App：
用户点击或界面自动触发联网需求 -> Android 代码调用拼装 HTTP 报文并发送请求到服务器 -> 域名解析器 ->服务器处理请求后发送响应报文给手机 -> Android 代码处理响应报文并作出相应处理（如储存数据、加?数据、显示数据到界面）

* 2.请求
```http
GET /hello.txt HTTP/1.1
User-Agent: curl/7.16.3 libcurl/7.16.3 OpenSSL/0.9.7l zlib/1.2.3
Host: www.example.com
Accept-Language: en, mi

<!-- @Body -->
{"name":"rengwuxian","gender":"male"}
<!-- @Field -->
name=rengwuxian&gender=male

```

* 3.响应
```
状态行： 协议/版本  状态码 状态消息 
消息报头： 头部字段：值

响应内容
```
```http
HTTP/1.1 200 OK
Server: Apache
Content-Type: text/html; charset=utf-8
Content-Length: 853
```
# 2.请求方式
## 1.GET
用于获取资源，请求内容写在url上，没有Body

## 2.POST
请求内容写在 Body 里面

## 3.PUT
用于修改资源，请求内容写在 Body 里

## 4.DELETE
用于删除资源，请求内容写在url上，没有Body

## 5.HEAD
和 GET 使?方法完全相同，唯一区别，返回的响应中没有Body

## 6.PUT
用于修改资源，请求内容写在 Body 里面

DELETE
用于删除资源，请求内容写在url上，没有Body

# 3.常见头部
每个header都以\r\n结尾，并且最后一行加上一个额外的空行\r\n

## 1.Host
  目标主机。注意：不是在网络上用于寻址的，而是在目标服务器上用于定位子服务的
## 2.Content-Type
 指定 Body 的类型。主要有四类

## 3.Content-Length
指定 Body 的长度（字节）

## 4.Transfer: chunked 
(分块传输编码 Chunked Transfer Encoding)  
用于当响应发起时，内容长度还没能确定的情况下。和 Content-Length不同时使用。用途是尽早给出响应，减少用户等待。
```http
HTTP/1.1 200 OK
Content-Type: text/html
Transfer-Encoding: chunked
4
Chun
9
ked Trans
12
fer Encoding
0
```
## 6.Location
指定重定向的目标 URL

## 7.User-Agent
用户代理，即是谁实际发送请求、接受响应的，例如手机浏览?、某款手机 App。
```http
User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15
(KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1
```

## 8.Range / Accept-Range
按范围取数据
Accept-Range: bytes 响应报文中出现，表示服务支持按字节来取范围数据
Range: bytes=< start>-< end> 请求报文中出现，表示要取哪段数据
Content-Range:-/total 响应报文中出现，表示发送的是哪段数据
作用：断点续传、多线程下载。


## 9.其他 Headers
Accept: 客户端能接受的数据类型。如 text/html
Accept-Charset: 客户端接受的字符集。如 utf-8
Accept-Encoding: 客户端接受的压缩编码类型。如 gzip
Content-Encoding：压缩类型。如 gzip

## 10.Cache
作用：在客户端或中间网络节点缓存数据，降低从服务器取数据的频率，以提高网络性能。用过的等会有可能继续使用的数据

## 11.Buffer
工作流缓冲，现在还没用，等会用到的数据
```http
Cache-Control : no-cache、 no-store、 max-age
Last-Modified ：If-Modified-Since
Etag ：If-None-Match
Cache-Control : private/public
```

# 4.Content-Type详细说明

```
常见的媒体格式类型如下：

text/html ： HTML格式
text/plain ：纯文本格式
text/xml ： XML格式
image/gif ：gif图片格式
image/jpeg ：jpg图片格式
image/png：png图片格式
以application开头的媒体格式类型：

application/xhtml+xml ：XHTML格式
application/xml： XML数据格式
application/atom+xml ：Atom XML聚合格式
application/json： JSON数据格式
application/pdf：pdf格式
application/msword ： Word文档格式
application/octet-stream ： 二进制流数据（如常见的文件下载）
application/x-www-form-urlencoded ： <form encType=””>中默认的encType，form表单数据被编码为key/value格式发送到服务器（表单默认的提交数据的格式）
另外一种常见的媒体格式是上传文件之时使用的：

multipart/form-data ： 需要在表单中进行文件上传时，就需要使用该格式
```

## 1.text/html  
请求 Web 页面时返回响应的类型，Body 中返回 html 文本
```http
HTTP/1.1 200 OK
Content-Type: text/html; charset=utf-8
Content-Length: 853
<!DOCTYPE html>
<html>
```
## 2.x-www-form-urlencoded
表单的提交
```http
POST /users HTTP/1.1
Host: api.github.com
Content-Type: application/x-www-form-urlencoded
Content-Length: 27
name=rengwuxian&gender=male
```

## 3.multitype/form-data

含有二进制文件时的提交方式
```http
POST /users HTTP/1.1
Host: hencoder.com
Content-Type: multipart/form-data; boundary=----
WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Length: 2382

------WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Disposition: form-data; name="name"
rengwuxian
------WebKitFormBoundary7MA4YWxkTrZu0gW
Content-Disposition: form-data; name="avatar"; filename="avatar.jpg"
Content-Type: image/jpeg
JFIFHHvOwX9jximQrWa......

------WebKitFormBoundary7MA4YWxkTrZu0gW--
```

```java
@Multipart
@POST("/users")
Call<User> addUser(@Part("name") RequestBody name, @Part("avatar") RequestBody avatar);
...
RequestBody namePart = RequestBody.create(MediaType.parse("text/plain"),nameStr);
RequestBody avatarPart = RequestBody.create(MediaType.parse("image/jpeg"),avatarFile);
api.addUser(namePart, avatarPart);
```
~~application/octet-stream~~  
只能提交二进制，而且只能提交一个二进制，如果提交文件的话，只能提交一个文件,后台接收参数只能有一个，而且只能是流（或者字节数组，很少使用
## 4.application/json , image/jpeg , application/zip
单项内容（文本或非文本都可以），用于Api的响应或者 POST / PUT 的请求

请求中提交 JSON
```http
POST /users HTTP/1.1
Host: hencoder.com
Content-Type: application/json; charset=utf-8
Content-Length: 38
{<!-- -->"name":"rengwuxian","gender":"male"}
```

```java
@POST("/users")
Call<User> addUser(@Body("user") User user);
```

请求中提交二进制内容
```http
POST /user/1/avatar HTTP/1.1
Host: hencoder.com
Content-Type: image/jpeg
Content-Length: 1575
JFIFHH9......
```
```java
@POST("users/{id}/avatar")
Call<User> updateAvatar(@Path("id") String id, @Body RequestBody avatar);

RequestBody avatarBody = RequestBody.create(MediaType.parse("image/jpeg"),avatarFile);
api.updateAvatar(id, avatarBody)
```

# 4.Status Code状态码
三位数字，用于对响应结果做出类型化描述（如「获取成功」「内容未找到」）。
* 1xx：临时性消息。如：100 （继续发送）、101（正在切换协议）
* 2xx：成功。最典型的是 200（OK）、201（创建成功）。
* 3xx：重定向。如 301（永久移动）、302（暂时移动）、304（内容未改变）。
* 4xx：客户端错误。如 400（客户端请求错误）、401（认证失败）、403（被禁止）、404（找不到内容）。
* 5xx：服务?错误。如 500（服务?内部错误）。


补充
1.一般加 sign:md5摘要，用来确认内容被篡改


# 参考文档  
https://www.codenong.com/cs109734857/   
content-type所有类型  
https://www.runoob.com/http/http-content-type.html