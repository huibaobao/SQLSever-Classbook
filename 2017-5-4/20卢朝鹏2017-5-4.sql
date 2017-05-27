--第5章 数据库编程 
--复习  
--5.1 变量与流程控制语句 

use score
go
--讲新课
--5.2 脚本文件
--5.2.1 SQL脚本文件的概念
--5.2.2 批处理
--【例5-14】编写批处理文件student.Sql，建立查询学生档案的视图v_student，然后用该视图查询所有“王”姓学生的学号、姓名、性别、班级。
Create View v_student  		    
As
   Select student.*,  school_class.name as class_name
   From student 
Join school_class on student.school_class_id=school_class.school_class_id
Go						
Select student_id 学号,name 姓名,sex 性别, class_name 班级 
From v_student
Where name like '王%' 
Go
--5.2.3注释
--1．单行注释
--2．多行注释

--5.3 游标
--5.3.1游标的概述
--SQL Server 支持3种类型的游标，本书只介绍Transact_SQL 服务器游标。
--5.3.2游标的基本操作
--【例5-20】利用@@FETCH_STATUS控制循环读取游标数据的操作。
--1.声明一个游标
declare current_student cursor
for select * from student						
--2.打开游标
open current_student
--3.执行提取操作				  
fetch next from current_student
--4.检查@@FETCH_STATUS，以确定是否还可以继续提取
while @@FETCH_STATUS=0
begin
	fetch next from current_student;
end
--5.关闭游标
close current_student;
--6.释放游标
deallocate current_student
go

--【例5-21】声明一个游标Cur_Student，用于读取学生表中“SW1031”班的学生信息，
--并将第3个学生的学籍状态更改为R05。
--1.声明一个游标						
declare cur_student scroll cursor
for 
select * from student
	where school_class_id = 'SW1031'
--2.打开游标
open Cur_Student
--3.定位至第3条记录执行提取操作
fetch absolute 3 from Cur_Student
--4.更新当前行数据
update student set roll_id='R05'
where current of Cur_Student
--5.关闭游标
close Cur_Student
--6.释放游标
deallocate Cur_Student
go


--5.4视图
--5.4.1视图的概念
--1.定义
--2.优点
--5.5.2创建视图
1．用Create View语句创建视图
Create View [数据库.][拥有者.]<视图名> [（列名1，…，列名n）]
[With Encryption]
As
Select 语句
[With Check Option]

--【例5-22】创建成绩视图V_stuScore，通过该视图能显示学年学期、学号、姓名、课程号、课程名、课程类别名和成绩。
Create View v_stuScore
With Encryption
As
Select term,student.student_id 学号,student.name 姓名, 
course.course_id 课程号,course.name 课程名, 
course_type.name 课程类别名,pscore 成绩
From student 
Join score on student.student_id=score.student_id
Join course on course.course_id=score.course_id
Join course_type on course_type.course_type_id=course.course_type_id

--5.5.3使用视图查询数据
--【例5-23】用视图v_ stuScore查询课程类型为“专业课”的成绩信息
--【例5-24】 基于学生表、系部表、班级表创建视图v_student，能显示学生表student中所有字段，
--及班级名称、专业名称、系部名称信息。使用视图v_student查询王姓男生的信息
--（系部、专业、班级、学号、姓名、性别），使用视图v_student分组统计各系各班男女生人数。



--5.5.4修改视图
Alter View [数据库.][拥有者.]<视图名> [（列名1，…，列名n）]
[With Encryption]
As
Select 语句
[With Check Option]
--【例5-25】修改视图v_stuscore，通过该视图能显示学年学期、学号、姓名、课程号、
--课程名、教师名和成绩。

--5.5.5删除视图
--5.5.5视图的应用
--1．为一个表创建视图
--【例5-27】基于成绩表score创建2个视图，分别是学生的百分制成绩视图和等级制
--成绩视图。
--2．为表的连接创建视图
--【例5-28】创建学生成绩详情视图v_scoreDetail，能显示学生成绩表score的所有字段、学生姓名、
--课程名称、班级名称、系部名称等信息。用视图v_scoreDetail查询选修“C++程序设计”课程的
--所有学生成绩信息（系部名称、班级名称、学号、学生姓名、课程名称、百分制成绩），查询
--“计算机系”各班各门课程的学生人数、平均分、最高分、最低分。


--3．竖表转换为横表
--【例5-29】成绩数据可以方便地以图5-7(a)的形式显示或打印，但现在要求以图5-7(b)的格式
--列出软件1班和软件2班的各门课程的成绩表。
--第1步：创建视图
Create View v_score_c1001
As
Select *
From score
Where course_id='C1001' and student_id like 'SW%'


--第2步：使用外连接将这7个视图与学生表和班级表连接起来。
Select school_class.name 班级, student.name 姓名,
		  v_score_C1001.grade 英语,
		  v_score_C1002.grade 科学技术,
		  v_score_C2001.grade 打字,
		  v_score_C3004.pscore 数据库,
		  v_score_C3005.pscore [C++软件1班],
		  v_score_C3006.pscore Java软件2班
From student
		 Join school_class on student.school_class_id=school_class.school_class_id
		 Left Join v_score_C1001 on student.student_id=v_score_C1001.student_id
		 Left Join v_score_C1002 on student.student_id=v_score_C1002.student_id
		 Left Join v_score_C2001 on student.student_id=v_score_C2001.student_id
		 Left Join v_score_C3004 on student.student_id=v_score_C3004.student_id
		 Left Join v_score_C3005 on student.student_id=v_score_C3005.student_id
		 Left Join v_score_C3006 on student.student_id=v_score_C3006.student_id
Where student.student_id like 'SW%'

