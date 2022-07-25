SQl
<!-- TOC -->

- [1.简介](#1简介)
  - [1.1 数据模型](#11-数据模型)
  - [1.2 关系型数据库](#12-关系型数据库)
  - [1.3 非关系型数据库](#13-非关系型数据库)
- [2.SQL](#2sql)
  - [2.1介绍](#21介绍)
  - [2.2 SQl](#22-sql)
- [3.数据库操作](#3数据库操作)
  - [3.1 查询数据](#31-查询数据)
  - [练习](#练习)
- [4.MySQl](#4mysql)
- [4.1 mysql 命令](#41-mysql-命令)
  - [4.2 连接远程服务器](#42-连接远程服务器)
  - [2.1数据库/表操作](#21数据库表操作)
  - [2.2实用SQL语句](#22实用sql语句)
  - [总结](#总结)
- [5.事务](#5事务)
  - [5.1 数据库事务](#51-数据库事务)
  - [5.1 Read Uncommitted](#51-read-uncommitted)
  - [3.Read Committed](#3read-committed)
  - [4.Repeatable Read](#4repeatable-read)
  - [Serializable](#serializable)
- [注意](#注意)

<!-- /TOC -->
# 1.简介

Mac
bash mysql.server start：启动MySQL
重启MySQL服务
sudo mysql.server restart

mysqld_safe
mysqld_safe --port 3306

system clear;:清理内容

## 1.1 数据模型
模型 | 说明
---|---
层次模型 | 以“上下级”的层次关系来组织数据，数据结构看起来就像一颗树
网状模型 | 把每个数据节点和其他很多节点都连接起来
关系模型 | 把数据看作是一个二维表格，任何数据都可以通过行号+列号来唯一确定

## 1.2 关系型数据库
  * 采用了关系模型来组织数据的数据库。简单来说，关系模式就是二维表格模型。

数据类型
名称 | 类型 | 说明
---|---|---
TINYINT | |范围在0~255,不常用
INT | 整型 | 4字节整数类型，范围约+/-21亿
BIGINT | 长整型 | 8字节整数类型，范围约+/-922亿亿，常用
REAL/FLOAT(24) | 浮点型 | 4字节浮点数，范围约+/-1038
DOUBLE | 浮点型 | 8字节浮点数，范围约+/-10308
DECIMAL(M,N) | 高精度小数 | 由用户指定精度的小数，例如，DECIMAL(20,10)表示一共20位，其中小数10位，通常用于财务计算
CHAR(N) | 定长字符串 | 存储指定长度的字符串，例如，CHAR(100)总是存储100个字符的字符串
VARCHAR(N) | 变长字符串 | 存储可变长度的字符串，例如，VARCHAR(100)可以存储0~100个字符的字符串,常用
BOOLEAN | 布尔类型 | 存储True或者False
DATE | 日期类型 | 存储日期，例如，2018-06-22
TIME | 时间类型 | 存储时间，例如，12:20:59
DATETIME | 日期和时间类型 | 存储日期+时间，例如，2018-06-22 12:20:59

约束名称 | 描述
---|---
NOT | NULL | 非空约束
UNIQUE | 唯一约束，取值不允许重复,
PRIMARY | KEY | 主键约束（主关键字），自带非空、唯一、索引
FOREIGN | KEY | 外键约束（外关键字）
DEFAULT | 默认值（缺省值）


名称 | 类型
---|---
Oracle，SQL Server，DB2 | 商用数据库
MySQL，PostgreSQL | 开源数据库
微软Access为代表 | 适合桌面应用程序使用；
Sqlite为代表 | 嵌入式数据库，适合手机应用和桌面程序。

## 1.3 非关系型数据库
非关系型的、分布式的，且一般不保证ACID的数据存储系统
数据库 | 特点
---|---
Redis、Tokyo Cabint等 | 具有极高的并发读写性能，面向高性能并发读写的key-value数据库
MongoDB以及CouchDB | 海量的数据库快速的查询数据，面向海量数据访问的面向文档数据库

* NoSql   
以键值来存储，且结构不稳定，每一个元组都可以有不一样的字段，这种就不会局限于固定的结构，可以减少一些时间和空间的开销。使用这种方式，为了获取用户的不同信息，不需要像关系型数据库中，需要进行多表查询。仅仅需要根据key来取出对应的value值即可。

缺点  
由于Nosql约束少，所以也不能够像sql那样提供where字段属性的查询。因此适合存储较为简单的数据。有一些不能够持久化数据，所以需要和关系型数据库结合


# 2.SQL
## 2.1介绍
Structured Query Language
SQL，结构化查询语言，对数据库系统增删改查

SQL语言定义了操作数据库的能力
名字 | 内容
---|---
DDL：Data Definition Language | 允许用户定义数据，也就是创建表、删除表、修改表结构这些操作。通常，DDL由数据库管理员执行。
DML:Data Manipulation Language | 提供添加、删除、更新数据的能力，这些是应用程序对数据库的日常操作。
DQL：Data Query Language | DQL允许用户查询数据，这也是通常最频繁的数据库日常操作。


## 2.2 SQl
概念 | 说明
---|---
记录(record) | 行
字段(colum) | 列
主键 | 唯一，能区分不能记录，并且最好于业务无关。通常设置为BIGINT NOT NULL AUTO_INCREMENT<br/>可以使用自增类型 <br/>全局唯一GUID类型,通过计算机随机产生的数据
联合主键 | 多字段设置为主键，只有不是一起重复就是允许的，一般不用联合主键
外键 | 通过外键，与另一个表关联起来
索引 | 对某一列/多列预排序的数据结果，可以不必扫描整个表，而快速定位。<br/>索引字段越多不同，效率越高。<br/>缺点：插入/删除/更新时，也要修改索引，索引越多，增删改效率越低


```sql
/************ 外键 ***********/

/******* 指定外键约束  ***********/
-- 因为外键降低数据库性能，一般不设置外键
-- 即如果classes表不存在id=99的记录，students表就无法插入class_id=99的记录

ALTER Table students add (address varchar(100), hobby varchar(100));

-- 修改数据类型
ALTER Table students modify hobby varchar(100); 

-- 改变字段名字，数据类型
alter table student change name newname varchar(15);

ALTER TABLE students 
-- 指定外键约束
ADD CONSTRAINT fk_class_id
-- 指定外键盘
FOREIGN KEY (class_id)
-- 指定外键将关联到classes表id列
REFERENCES classes (id);


ALTER TABLE students
-- 删除外键
DROP FOREIGN KEY fk_class_id;


-- 创建一个名称为idx_score，列score的索引
ALTER TABLE students
-- 添加索引
ADD INDEX idx_score (score);
-- UNIQUE指定唯一
ADD UNIQUE INDEX uni_name (name);
ADD INDEX idx_name_score (name, score);

```

# 3.数据库操作

## 3.1 查询数据
```sql
/************* 基本查询 *****************/
-- select 关键字; 可以作计算，但一般不这样; 查询的结果是一个二维表。
--  * 所有列; 
-- FROM从单/多表查询，也可以没有
SELECT * FROM students;
SELECT 100+200; -- 300

SELECT id+200 From students; -- 计算

SELECT DISTINCT name FROM students; --去重

SELECT id s_id, score "成绩", gender as sex From students; -- 别名

SELECT id s.s_id, score s."成绩", gender as s.sex From students as s; -- 别名

/************* 查询最后一次插入的数据 *****************/
 select last_insert_id();

/************* 条件查询 *****************/
SELECT * FROM students WHERE score >= 80
SELECT * FROM students WHERE NOT score == 80
SELECT * FROM students WHERE score <> 80 --等价于上面
SELECT * FROM students WHERE score >= 80 AND/OR/NOT gender = 'M'
-- 多条件查询
SELECT * FROM students WHERE (score < 80 OR score > 90) AND gender = 'M';

select * from user WHERE id in( 2 , 3 , 4 )

-- 模糊查询
select * from user WHERE name like '%新'

/************* 投影查询 *****************/
-- 仅返回指定列
SELECT id, score, name FROM students;

-- 列名score重命名为points
SELECT id, score points, name FROM students;

/************* 排序 *****************/
-- 分组要和聚合函数配合使用

-- 根据score进行排序；DESC倒序，ASC(默认)正序
SELECT id, name, gender, score FROM students ORDER BY score (DESC);

-- 先按照score 倒序排列，如果sore相同的，再按照gender正序排列, 多条件排序
SELECT id, name, gender, score FROM students ORDER BY score DESC, gender asc;

-- 多条件
SELECT id, name, gender, score
FROM students
WHERE class_id = 1
ORDER BY score DESC;

/************* 分页查询 *****************/
-- LIMIT 3 OFFSET 0
SELECT id, name, gender, score
FROM students
-- 先执行排序，在截取
ORDER BY score DESC
-- 偏移量0，只截取前3个
LIMIT 3 OFFSET 0;
//OFFSET 是可选的
-- LIMIT 3;

SELECT * from student limit 1,2 --从第1个开始，查2个

/************* 聚合查询 *****************/
-- 查询所有列的行数，查询的结果是一个一行一列的二维表，列名COUNT(*)
SELECT COUNT(*) FROM students; --多少条数据
SELECT MAX(*) FROM students; --最大成绩
SELECT MIN(*) FROM students; --最小成绩
SELECT SUM(*) FROM students; --成绩总和
SELECT AVG(score) FROM students; --平均成绩

 /************* 分组 *****************/
-- 分组经常和聚合一起使用
SELECT id, AVG(socre)  
FROM students 
group by gander -- 分组条件，可以比前面少，但不能多
HAVING gander='男';  -- 只保留男
--先对性别分组，再只保留‘男’的

SELECT grander, AVG(age) FROM students where gander='男'; -- 先把男的挑出来，然后展示

SELECT '组', grander, AVG(age) FROM students where gander='男'; -- 先把男的挑出来，然后展示

-- 每页3条记录，通过聚合查询获得总页数
SELECT CEILING(COUNT(*) / 3) FROM students;

select id, money, truncate(money, -1), pi(), pi()*money*money "面积", from student;
-- ROUND(x,y) – 四舍五入一个正数或者负数，结果为一定长度的值。
-- CEILING() - 返回最小的整数，使这个整数大于或等于指定数的数值运算。
-- FLOOR() - 返回最大整数，使这个整数小于或等于指定数的数值运算。
-- TRUNCATE(x,y) -返回x截取y位小树的结果
-- PI() -返回pi的值
-- RAND() 返回0-1之间的随机数，可以提供一个参数(种子)rand的随机生成指定的值

-- 统计各班男女人数
SELECT class_id, gender, COUNT(*) num FROM students GROUP BY class_id, gender;

/************* union/union all *****************/
-- 合并两个表
select id, name from studnet
union
select id, name from teacher2 -- 去除重复的

select id, name from studnet
union all
select id, name from teacher2 -- 不去除重复的


/************* 多表查询 *****************/
-- 查询结果行数是M x N行记录
SELECT * FROM students, classes; --笛卡尔集

-- 定义别名
select u.*, a.id as aid, a.uid, a.money from user u,account a where u.id=a.uid;

-- 定义别名，用于区分字段
SELECT
    students.id sid,
    students.name,
    students.gender,
    students.score,
    classes.id cid,
    classes.name cname
FROM students, classes;

-- 为表设置别名
SELECT
    s.id sid,
    s.name,
    s.gender,
    s.score,
    c.id cid,
    c.name cname
FROM students s, classes c
WHERE s.gender = 'M' AND c.id = 1;


-- 多表查询
/************* 连接查询 *****************/
-- 左连接，右表可以为空；右连接，左表可以为空；
SELECT s.id, s.name, s.class_id, c.name class_name, s.gender, s.score
-- 主表
FROM students s
-- 需要连接的表
INNER JOIN classes c --内连接
-- 连接条件
ON s.class_id = c.id;
-- 可选 where
WHERE s.score = 100

-- 连接查询
select u.*, a.id as aid, a.uid, a.money from user u,account a where u.id=a.uid
-- 左外连接
select u.*, a.id as aid, a.uid, a.money from user u left outer join account a on u.id= a.uid;

-- 全链接 左表可以为空，右表也可为空
select u.*, a.id as aid, a.uid, a.money from user u left outer join account a on u.id= a.uid
union
select u.*, a.id as aid, a.uid, a.money from user u right outer join account a on u.id= a.uid;


-- 多次查询
select u.*, p.id as pid, p.name as pname, role.uid from position p 
left outer join user_role role 
on p.id=role.pid left outer join user u on uid=u.id; -- 连接条件

```

```sql
-- 子查询
select * from scores where s_id in (select id from scores where age > 10); -- where 后面作为条件

select * from (select id from scores where age > 10) a where a.id > 3 ; -- from后面作为表使用

select * from (select id from scores where age > 10) t 
left join score on t.id = score.id 
left join score2 on t.id = score2.id 
where t.id in (3,8,9); -- 左连接

````



常用的条件表达式
条件 | 表达式举例1 | 表达式举例2 | 说明
---|---|---|---
使用=判断相等 | score = 80 | name = 'abc' | 字符串需要用单引号括起来
使用>判断大于 | score > 80 | name > 'abc' | 字符串比较根据ASCII码，中文字符比较根据数据库设置
使用>=判断大于或相等 | score >= 80 | name >= 'abc' | 
使用<判断小于 | score < 80 | name <= 'abc' | 
使用<=判断小于或相等 | score <= 80 | name <= 'abc' | 
使用<>判断不相等 | score <> 80 | name <> 'abc' | 
使用LIKE判断相似 | name LIKE 'ab%' | name LIKE '%bc%' | %表示任意字符，例如'ab%'将匹配'ab'，'abc'，'abcd'


聚合函数
没有查询到的会返回null
函数 | 说明
---|---
SUM | 计算某一列的合计值，该列必须为数值类型
AVG | 计算某一列的平均值，该列必须为数值类型
MAX | 计算某一列的最大值
MIN | 计算某一列的最小值

函数
函数 | 说明
---|---
ROUND() | 四舍五入一个正数或者负数。
CEILING() | 返回最小的整数，使这个整数大于或等于指定数的数值运算。
FLOOR() | 返回最大整数，使这个整数小于或等于指定数的数值运算。


连接查询

连接 | 函数 | 说明
---|---|---
INNER JOIN | 内连接 | 同时存在两张表中
RIGHT OUTER JOIN | 右连接 | 返回右表存在的行，左表不存在的返回NULL
LEFT OUTER JOIN | 左连接 | 返回左表存在的行，右表不存在的返回NULL
FULL OUTER JOIN | 全连接 | 所有记录都展示，自动把对方不存在的列显示NULL

## 3.2.修改数据
连接 | 函数
---|---
INSERT | 插入新记录；
UPDATE | 更新已有记录；
DELETE | 删除已有记录。

```sql
/************* INSERT *****************/
-- 插入记录
-- id 一般是自增主键，数据库推断出来的
INSERT INTO students (class_id, name, gender, score) VALUES (2, '大牛', 'M', 80);

-- 一次性插入多条数据
INSERT INTO students (class_id, name, gender, score) VALUES
  (1, '大宝', 'M', 87),
  (2, '二宝', 'M', 81);


/************* UPDATE *****************/
-- 更新记录
UPDATE students SET name='大牛', score=66 WHERE id=1;
-- 小于80分的+10分
UPDATE students SET score=score+10 WHERE score<80;
-- 如果没有WHERE,所有数据都会被修改。
-- 因此为了防止出现意外，最好先SELECT找到，再改为UPDATA
UPDATE students SET score=60;

/************* DELETE *****************/
-- 如果没有找到，不会报错，也不会有任何提示
DELETE FROM students WHERE id=1;
-- 一次性删除多条数据
DELETE FROM students WHERE id>=5 AND id<=7;
-- 没有WHERE,会删除这个表，因此最好先查询数据集，再改为删除
DELETE FROM students;
```

## 练习
```sql
-- where 第二张表数据无法显示
-- left/right join 第二张表的数据可以显示

-- 课程变化为01且分数大于80分的学生编号和名字
select s.id, s.name from students where s.id in
((select c.s_id from score c where c.score > 80 and c.c_id = "01");

-- 查询课程名称为“java”，并且分数大于60的学生名字以及分数
select s.name, m.course from students right join 
(select c.s_id, c.course from score c left right course on c.e_id = e.id where course.name = "java" and c.score < 60) m -- 把
on m.s_id = s.id
where m.s_id is not null

```

# 4.MySQl

# 4.1 mysql 命令
命令 | 说明
---|---
mysql -u root -p | 连接Mysql
mysql -u root | 连接Mysql
exit | 断开Mysql连接
mysql -h 10.0.1.99 -u root -p | 连接到远程MySQL Server
MySQL Workbench/MySQL Client命令行 | 图形客户端

## 4.2 连接远程服务器
```mysql
mysql -h127.0.0.1 -uroot -proot;

```

## 2.1数据库/表操作
```sql
/************* 数据库 *****************/
-- 系统库
-- information_schema,mysql,performance_schema和sys
-- 展示数据库
SHOW DATABASES;

-- 创建数据库
CREATE DATABASE test;

-- utf-8 防止中文乱码
create database testdb character set utf8;

-- 删除数据库
DROP DATABASE test;

-- 切换数据库
USE test;

/************* 表 *****************/
-- 展示所有的表名
SHOW TABLES;

-- 展示自己创建的表
SHOW CREATE TABLE students

-- 查看表结构
DESC students

-- 创建表
CREATE TABLE `students` (
	`id` bigint(20) NOT NULL AUTO_INCREMENT,
	`class_id` bigint(20) NOT NULL, --定义在前面
	`name` varchar(100) NOT NULL, 
	`gender` varchar(1) NOT NULL, 
	`score` int(11) NOT NULL,
  `index` unsigned NOT NULL
	PRIMARY KEY (id), --定义在后面
  foreign key(id) references author(aut_id), --外键 
  unique(class_id), 
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8
//ENGINE：引擎

CREATE TABLE students (
	class_id bigint(20) NOT NULL, 
	id bigint(20) NOT NULL AUTO_INCREMENT primary key,
	name varchar(100) NOT NULL, 
	gender varchar(1) NOT NULL, 
	score int(11) NOT NULL,
  index tinyint(3) unsigned NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8

-- 删除表
DROP TABLE students;

DROP DATABASE if EXISTS student; --如果存在就删除

-- 新增字段
ALTER TABLE students ADD COLUMN birth VARCHAR(10) NOT NULL;
-- 修改字段类型
ALTER TABLE students CHANGE COLUMN birth birthday VARCHAR(20) NOT NULL;

-- 删除字段
alter table student drop other; 

ALTER TABLE students DROP COLUMN birthday;

-- 重命名表名 
alter table student rename to students;

```

## 2.2实用SQL语句
```sql
/************* 插入或更新 *****************/
-- 插入
INSERT INTO students (id, class_id, name, gender, score) VALUES (1, 1, '小明', 'F', 99) ON DUPLICATE KEY UPDATE name='小明', gender='F', score=99;

INSERT INTO students VALUES (1, 1, '小明', 'F', 99) ON DUPLICATE KEY UPDATE name='小明', gender='F', score=99;


/************* 插入或替换 *****************/
-- 先查询，如果存在先删除旧的，再插入；如果没有直接插入
REPLACE INTO students (id, class_id, name, gender, score) VALUES (1, 1, '小明', 'F', 99);

/************* 插入或忽略 *****************/
-- 先查询，如果存在再停止；如果没有直接插入
INSERT IGNORE INTO students (id, class_id, name, gender, score) VALUES (1, 1, '小明', 'F', 99);

/************* 快照 *****************/
-- 复制当前表的数据到一个新表
CREATE TABLE students_of_class1 SELECT * FROM students WHERE class_id=1;

/************* 写入查询结果集 *****************/
CREATE TABLE statistics (
    id BIGINT NOT NULL AUTO_INCREMENT,
    class_id BIGINT NOT NULL,
    average DOUBLE NOT NULL,
    PRIMARY KEY (id)
);


-- 写入各班的平均成绩
INSERT INTO statistics (class_id, average) SELECT class_id, AVG(score) FROM students GROUP BY class_id;

/************* 强制使用指定索引 *****************/
-- 数据库系统会自动分析查询语句，并选择一个最合适的索引，但是数据库系统的查询优化器并不一定是最优索引，可以使用FORCE INDEX强制查询使用指定的索引
SELECT * FROM students FORCE INDEX (idx_class_id) WHERE class_id = 1 ORDER BY id DESC;
```

## 总结
* 命令行程序mysql实际上是MySQL客户端，真正的MySQL服务器程序是mysqld，在后台运行。

# 5.事务
## 5.1 数据库事务
数据库事务:把多条语句作为一个整体进行操作,要么都完成，要么都不完成。

数据库事务具有ACID这4个特性
* A：Atomic，原子性，将所有SQL作为原子工作单元执行，要么全部执行，要么全部不执行；
* C：Consistent，一致性，事务完成后，所有数据的状态都是一致的，即A账户只要减去了100，B账户则必定加上了100；
* I：Isolation，隔离性，如果有多个事务并发执行，每个事务作出的修改必须与其他事务隔离；
* D：Duration，持久性，即事务完成后，对数据库数据的修改被持久化存

隐式事务：对于单条SQL语句，数据库系统自动将其作为一个事务执行。
显式事务：手动把多条SQL语句作为一个事务执行，使用BEGIN开启一个事务，使用COMMIT提交一个事务。

```sql
//显式事务
BEGIN;
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;
//试图把事务内的所有SQL所做的修改永久保存；如果失败了，整个事务也会失败
COMMIT;
```
SQL标准定义了4种隔离级别
Isolation Level | 脏读（Dirty Read） | 不可重复读（Non Repeatable Read） | 幻读（Phantom Read）
---|---|---|---
Read Uncommitted | Yes | Yes | Yes
Read Committed | - | Yes | Yes
Repeatable Read | - | - | Yes
Serializable | - | -


## 5.1 Read Uncommitted
隔离级别最低的一种事务级别.读取更新但未提交的数据，回滚的话，就获取数据库中的数据。
如果另一个事务回滚，那么当前事务读到的数据就是脏数据，这就是脏读（Dirty Read）。

```sql
-- 事务A
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
BEGIN;
UPDATE students SET name = 'Bob' WHERE id = 1;	
ROLLBACK;	
	
-- 事务B
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
BEGIN;
SELECT * FROM students WHERE id = 1;
SELECT * FROM students WHERE id = 1;
COMMIT;
```

## 3.Read Committed
Read Committed隔离级别下：一个事务可能会遇到不可重复读（Non Repeatable Read，因为很可能读到的结果不一致。

```sql
-- 事务A
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN;
UPDATE students SET name = 'Bob' WHERE id = 1;	
COMMIT;	
	
-- 事务B
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN;
--没提交，读取旧数据
SELECT * FROM students WHERE id = 1;
--提交了，读取新数据，同一个事务，读取到的数据不一样
SELECT * FROM students WHERE id = 1;
COMMIT;
```

## 4.Repeatable Read
Repeatable Read隔离级别下，一个事务中，只要不更新数据，就一直读旧的。
因此在一个事务可能会遇到幻读（Phantom Read）的问题。
幻读是指，在一个事务中，第一次查询某条记录，发现没有，但是，当试图更新这条不存在的记录时，竟然能成功，并且，再次读取同一条记录，它就神奇地出现了。

```sql
-- 事务A
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN;
INSERT INTO students (id, name) VALUES (99, 'Bob');
COMMIT;
	
-- 事务B
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN;
-- 读取不到
SELECT * FROM students WHERE id = 99;
//上个事务已经提交了，但还读取不到
SELECT * FROM students WHERE id = 99;
-- 可以更新
UPDATE students SET name = 'Alice' WHERE id = 99;
-- 能读取到了
SELECT * FROM students WHERE id = 99;
COMMIT;
```

## Serializable
最严格的隔离级别。所有事务按照次序依次执行，因此，脏读、不可重复读、幻读都不会出现。
但是，由于事务是串行执行，所以效率会大大下降，应用程序的性能会急剧降低。如果没有特别重要的情景，一般都不会使用Serializable隔离级别。

* 默认隔离级别
如果没有指定隔离级别，数据库就会使用默认的隔离级别。在MySQL中，如果使用InnoDB，默认的隔离级别是Repeatable Read。 

InnoDB，是MySQL的数据库引擎之一，InnoDB的最大特色就是支持了ACID兼容的事务（Transaction）功能，类似于PostgreSQL。


```sql
-- 创建数据库
CREATE TABLE IF NOT EXISTS `user`(
   `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
   `username` VARCHAR(100) NOT NULL COMMENT '用户名',
   `birthday` datetime default NULL  COMMENT '生日',
   `sex` char(1) default NULL  COMMENT '性别',
   `address` varchar(256) default NULL  COMMENT '地址',
   PRIMARY KEY (`id`),

    PRIMARY KEY (`id`, c_id) --联合组件
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `account` (
  `ID` int(11) NOT NULL COMMENT '编号',
  `UID` int(11) unsigned default NULL COMMENT '用户编号',
  `MONEY` double default NULL COMMENT '金额',
  PRIMARY KEY  (`ID`),
  KEY `FK_Reference_8` (`UID`),
  CONSTRAINT `FK_Reference_8` FOREIGN KEY (`UID`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `role` (
  `ID` int(11) NOT NULL COMMENT '编号',
  `ROLE_NAME` varchar(30) default NULL COMMENT '角色名称',
  `ROLE_DESC` varchar(60) default NULL COMMENT '角色描述',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
​
insert  into `role`(`ID`,`ROLE_NAME`,`ROLE_DESC`) values (1,'组长','管理整个组'),(2,'班主任','管理整个班级'),(3,'校长','管理整个学校');
​
-- 创建关联表
CREATE TABLE `user_role` (
  `UID` int(11) NOT NULL COMMENT '用户编号',
  `RID` int(11) NOT NULL COMMENT '角色编号',
  PRIMARY KEY  (`UID`,`RID`),
  KEY `FK_Reference_10` (`RID`),
  CONSTRAINT `FK_Reference_10` FOREIGN KEY (`RID`) REFERENCES `role` (`ID`),
  CONSTRAINT `FK_Reference_9` FOREIGN KEY (`UID`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

# 注意
* (1)字符串添加
  * Statement字符串拼接Sql
  * PrepatedStatement参数占位符(更好)
* (2)数据库查创建的时，字段名使用``,而不是‘’
* (3)子查询的效率偏低，因此能用左连接就不用子查询



# 例子
```sql
-- 行转列
select name "姓名", 
    max(case course when "语文" then score else 0 end) "语文",
    max(case course when "数学" then score else 0 end) "数学",
    max(case course when "英语" then score else 0 end) "英语" 
from student group by name

```