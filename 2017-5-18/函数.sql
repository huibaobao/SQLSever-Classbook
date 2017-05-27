use score
go

--5.5函数
--5.5.1标准函数（内置函数) 
--【例5-30】显示输出当前日期中的年、月、日。


--【例5-31】分别使用CAST和CONVERT函数将字符串ABCDEFGHIG转换为NVARCHAR(6)类型。
print cast('ABCDEFGHIG' as NVARCHAR(6))
select convert(NVARCHAR(6),'ABCDEFGHIG')

--【例5-32】编写程序获得服务器名、当前数据库用户名、数据库ID号和当前数据库名。
select HOST_NAME(),CURRENT_USER,DB_ID(),DB_NAME(DB_ID())
go

--5.5.2自定义函数
--SQL Server 2012支持三种用户自定义函数，分别是标量型函数、内联（单语句）表值型函数
--和多语句表值型函数。
--1．标量型函数
/*Create Function  [用户名].<函数名> （形参列表）
Returns <函数返回类型>
[As]
Begin
<语句组1>
Return 函数值
<语句组2>
End*/
--【例5-33】在scoresys数据库中创建一个自定义函数，按出生日期计算年龄，然后从
--学生情况表中检索出含有年龄的学生信息（包括学号、姓名、性别和年龄）。


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
--2．内联（单语句）表值型函数
/*Create Function  [用户名].<函数名> （形参列表）
Returns  Table 
[With Encryption]
[As]
<语句组1>
Return （Select 语句）
<语句组2>*/
--【例5-34】在scoresys数据库中创建一个自定义函数，根据输入的系部名称
--查询出该系部所有班级的基本信息（包括班级编码、班级名、专业名称）。

create function dept_func(@dept_name varchar(50))
returns table
as 
	return
		(select sc.school_class_id 班级编码,sc.name 班级名,mj.name 专业名称
			 from school_class sc,major mj,department dept
			 where sc.major_id=mj.major_id 
					and mj.department_id=dept.department_id
					and dept.name=@dept_name)
go

select * from dept_func('计算机系')
go
--3．多语句表值型函数
/*Create Function  [用户名].<函数名> （形参列表）
Return @局部变量 Table (<返回表定义>)
[With Encryption]
[As]
Begin
<语句组>
Return
End*/
--【例5-35】在scoresys数据库中创建一个自定义函数，根据输入的班级名称
--查询出该班级所有学生的相关信息（要求包括学号、姓名、性别、班级名、专业名、系名）。
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
select * from class_info('物联网1021')


Select student_id,course_id,score
From score

