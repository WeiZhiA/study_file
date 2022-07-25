Git使用

git: 分布式版本控制系统，工具
github：代码托管平台
gitee：国内
gitlab：私用的，本公司在用


>> 追加
touch 创建文件

git3个区域：工作区，暂存区(add)，版本库（commit）

head 指向当前分支，最新提交

# 常用名利
git config --list :显示配置信息

git config --globe user.name '姓名'  
git config --globe user.email '邮箱'  

git init :初始化本地仓库  

git add: 添加代码
git add . : 提交所有文件

git commit -m 'first' : 提交本地版本管理

git status: 查看文件状态

git log --pretty=oneline :只显示一行

git diff : 比较暂存区和工作目录
git diff --cached: 缓存区 与当前版本
git diff 18ad651113cbdf53c4032c4f17be961d2 :比较两个版本差异
git mv b.txt c.txt : 改文件名为c.txt

.gitignore: 忽略文件


# 回退
git reset head~ :回退一个版本
git reset head~10:回退10个版本
git reflog: 查看所有提交记录


参数选择
--hard：回退版本库，暂存区，工作区（之前修改的代码就没了，谨慎使用）
--mixed：回退版本库，暂存区（默认）
--soft：回退版本库

举例：git reset --hard head~

git reset --hard 18ad651113cbdf53c4032c4f17be961d2a6 : 指定快照回退


# 创建和切换分支
git branch feature-login : 创建分支  
git checkout feature-login：切换分支  

git merge feature-login: 合并feature-login到当前分支

git branch -d feature-login: 删除分支


# 远程托管平台
git remote add origin 

git clone http://gitee.com/study.git   ：远程托管平台，clone到本地库
git push: 推送到远程托管平台 
git remote -v :查看远程仓库


## 跨团队仓库
licence：开源许可

fork: 复制别人的仓库

pull request：推送到别人分支请求

issues:任务指派，或者bug追踪器

git rebase -i head～ ：本地合并多个提交，减少提交日志  

## idea
file -> new -> project version control : 拉代码


企业防火墙一般都打开80(http)443(https)端口

* ssh拉代码
需要配置公钥，配置之后就不要密码了  
ssh-keygen -t rsa -C "邮箱"：生成ssh的公/私钥

id_ras: 
id_ras.pub:给代码版本工具
设置->ssh公钥
