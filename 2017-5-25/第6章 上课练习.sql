--1.����book���ݿ⡢book_details������3����¼
create database book
go
use book
go
create table book_details(bno char(4),
                          bname char(20))
go
insert into dbo.book_details values('b01','���ݿ⿪��')
insert into dbo.book_details values('b02','C#�������')
insert into dbo.book_details values('b03','Java��Ŀ����')
go
--2.�鿴��ǰ�������Ƿ�֧�ֻ����֤
--3.����SQL Server��¼�˻�student,����student,Ĭ�����ݿ�book
--��������ɫ������ѡ�κ�ѡ��
--�û�ӳ�䣺��ѡbook�����ݿ��û���Ϊstud_xs��
--4.�����¼ܹ�
create schema info authorization stud_xs
go
--5.���´�student�ĵ�¼���ԣ��û�ӳ��ѡ���У�����Ĭ�ϼܹ���Ϊinfo
--6.�һ�book�⣬������������----Ȩ�ޡ�
��ѡcreate tableȨ�ޡ�
7.�һ�dbo.book_details��������������----Ȩ�ޡ�
��ѡselect��insert��delete��updateȨ�ޡ�
8. �Ͽ�Ŀǰ���ӣ���student����SQL Server�����ԡ�
--����select��insert��delete��update
select * from dbo.book_details
go
insert into dbo.book_details values('b04','IT����')
go
delete 
  from dbo.book_details
    where bno='b04'
go
update dbo.book_details
  set bname='C++�������'
    where bno='b02'
go
--����create table
create table book_user(uno char(4),
                       uname char(20))
go
