use score
go

--5.5����
--5.5.1��׼���������ú���) 
--����5-30����ʾ�����ǰ�����е��ꡢ�¡��ա�


--����5-31���ֱ�ʹ��CAST��CONVERT�������ַ���ABCDEFGHIGת��ΪNVARCHAR(6)���͡�
print cast('ABCDEFGHIG' as NVARCHAR(6))
select convert(NVARCHAR(6),'ABCDEFGHIG')

--����5-32����д�����÷�����������ǰ���ݿ��û��������ݿ�ID�ź͵�ǰ���ݿ�����
select HOST_NAME(),CURRENT_USER,DB_ID(),DB_NAME(DB_ID())
go

--5.5.2�Զ��庯��
--SQL Server 2012֧�������û��Զ��庯�����ֱ��Ǳ����ͺ���������������䣩��ֵ�ͺ���
--�Ͷ�����ֵ�ͺ�����
--1�������ͺ���
/*Create Function  [�û���].<������> ���β��б�
Returns <������������>
[As]
Begin
<�����1>
Return ����ֵ
<�����2>
End*/
--����5-33����scoresys���ݿ��д���һ���Զ��庯�������������ڼ������䣬Ȼ���
--ѧ��������м��������������ѧ����Ϣ������ѧ�š��������Ա�����䣩��


create function stuAge(@birthday datetime)
returns tinyint
as 
   begin
       return year(getdate())-year(@birthday)
   end
go

select student_id,name,sex, stuAge(birthday)
  from student
go
--2������������䣩��ֵ�ͺ���
/*Create Function  [�û���].<������> ���β��б�
Returns  Table 
[With Encryption]
[As]
<�����1>
Return ��Select ��䣩
<�����2>*/
--����5-34����scoresys���ݿ��д���һ���Զ��庯�������������ϵ������
--��ѯ����ϵ�����а༶�Ļ�����Ϣ�������༶���롢�༶����רҵ���ƣ���

create function dept_func(@dept_name varchar(50))
returns table
as 
	return
		(select sc.school_class_id �༶����,sc.name �༶��,mj.name רҵ����
			 from school_class sc,major mj,department dept
			 where sc.major_id=mj.major_id 
					and mj.department_id=dept.department_id
					and dept.name=@dept_name)
go

select * from dept_func('�����ϵ')
go
--3��������ֵ�ͺ���
/*Create Function  [�û���].<������> ���β��б�
Return @�ֲ����� Table (<���ر���>)
[With Encryption]
[As]
Begin
<�����>
Return
End*/
--����5-35����scoresys���ݿ��д���һ���Զ��庯������������İ༶����
--��ѯ���ð༶����ѧ���������Ϣ��Ҫ�����ѧ�š��������Ա𡢰༶����רҵ����ϵ������
use score
go
create function class_info(@classname varchar(50))
returns @t_class table (student_id	varchar(36),name	varchar(50),
						sex char(1),classname	varchar(50),
						majorname varchar(50),deptname varchar(50))
begin 
	insert @t_class
		select stu.student_id,stu.name,stu.sex,scl.name,mj.name,dept.name
		 from student stu,school_class scl,major mj,department dept
		 where stu.school_class_id=scl.school_class_id 
			and scl.major_id=mj.major_id
			and	mj.department_id=dept.department_id
			and scl.name=@classname
	return
end

go
select * from class_info('������1021')


Select student_id,course_id,score
From score

