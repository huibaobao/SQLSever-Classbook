--1.创建book数据库、book_details表、插入3条记录
create database book
go
use book
go
create table book_details(bno char(4),
                          bname char(20))
go
insert into dbo.book_details values('b01','数据库开发')
insert into dbo.book_details values('b02','C#程序设计')
insert into dbo.book_details values('b03','Java项目制作')
go
--2.查看当前服务器是否支持混合验证
--3.创建SQL Server登录账户student,密码student,默认数据库book
--服务器角色，不勾选任何选项
--用户映射：勾选book，数据库用户设为stud_xs。
--4.创建新架构
create schema info authorization stud_xs
go
--5.重新打开student的登录属性，用户映射选择卡中，设置默认架构设为info
--6.右击book库，进入属性设置----权限。
勾选create table权限。
7.右击dbo.book_details表，进入属性设置----权限。
勾选select、insert、delete、update权限。
8. 断开目前连接，以student进入SQL Server，测试。
--测试select、insert、delete、update
select * from dbo.book_details
go
insert into dbo.book_details values('b04','IT技术')
go
delete 
  from dbo.book_details
    where bno='b04'
go
update dbo.book_details
  set bname='C++程序设计'
    where bno='b02'
go
--测试create table
create table book_user(uno char(4),
                       uname char(20))
go
