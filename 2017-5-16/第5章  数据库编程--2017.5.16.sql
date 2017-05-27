--第5章  数据库编程
复习
--5.1 变量与流程控制语句
--5.2 脚本文件
--5.3 游标

新课
--5.4视图
--5.4.1 创建视图
--Create View [数据库.][拥有者.]<视图名> [（列名1，…，列名n）]
--[With Encryption]
--As
--Select 语句
--[With Check Option]
--【例5-22】创建成绩视图V_stuScore，通过该视图能显示学年学期、学号、姓名、课程号、
--课程名、课程类别名和成绩。
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


--【例5-23】用视图v_ stuScore查询课程类型为“专业课”的成绩信息。


--【例5-24】 基于学生表、系部表、班级表创建视图v_student，能显示学生表student中所有字段，
--及班级名称、专业名称、系部名称信息。使用视图v_student查询王姓男生的信息（系部、专业、
--班级、学号、姓名、性别），
--使用视图v_student分组统计各系各班男女生人数。
--创建视图v_student  
Create View v_student
As 
Select student.*,  
department.name 系部名称,major.name 专业名称,school_class.name 班级名称
From student
	  Join school_class on school_class.school_class_id=student.school_class_id
     Join major on major.major_id=school_class.major_id
		 Join department on department.department_id=major.department_id
Go
--使用视图v_student查询“王”姓男生的信息
Select 系部名称,专业名称,班级名称,
      Student_id 学号,name 姓名,sex 性别
From v_student
Where sex= 'M'
and name like '王%' 
--使用视图v_student分组统计各系各班男女生人数
Select 系部名称, 班级名称,sex 性别,Count(*) 学生人数
From v_student 
Group By 系部名称, 班级名称,sex 

.2 修改视图
Alter View [数据库.][拥有者.]<视图名> [（列名1，…，列名n）]
[With Encryption]
As
Select 语句
[With Check Option]
--【例5-25】修改视图v_stuscore，通过该视图能显示学年学期、学号、姓名、
--课程号、课程名、教师名和成绩。
Alter View v_score
As		
Select term,student.student_id 学号,student.name 姓名, 
course.course_id 课程号,course.name 课程名, 
faculty.name 教师名,pscore 成绩
From student 
Join score on student.student_id=score.student_id
Join course on course.course_id=score.course_id
Join faculty on faculty. faculty_id=score.faculty_id


--5.4.3 删除视图
--【例5-26】删除已有的v_stuscore视图。

--5.4.4 视图的应用
--1．为一个表创建视图
--【例5-27】基于成绩表score创建2个视图，分别是学生的百分制成绩视图和等级制成绩视图。
Create View v_score 		--百分制成绩视图
As
Select score_id,term,pscore,pscore1,course_id,student_id,faculty_id,remark
From score
Where pscore is not null
Go
Create View v_grade 		--等级制成绩视图
As
Select score_id,term,grade,grade1,course_id,student_id,faculty_id,remark
From score
Where grade is not null


--2．为表的连接创建视图

【例5-28】创建学生成绩详情视图v_scoreDetail，能显示学生成绩表score的所有字段、
--学生姓名、课程名称、班级名称、系部名称等信息。用视图v_scoreDetail查询
--选修“C++程序设计”课程的所有学生成绩信息（系部名称、班级名称、学号、
--学生姓名、课程名称、百分制成绩），查询“计算机系”各班各门课程的
--学生人数、平均分、最高分、最低分。
--（1）创建学生成绩详情视图v_scoreDetail
Create View v_scoreDetail 
As 
Select score.*,student.name 学生姓名,course.name 课程名称,
school_class.name 班级名称,department.name 系部名称
From score
     Join course on course.course_id=score.course_id
Join student on student.student_id=score.student_id
Join school_class on school_class.school_class_id=student.school_class_id
Join major on major.major_id=school_class.major_id
Join department on department.department_id=major.department_id


--（2）使用视图v_scoreDetail查询选修“C++程序设计”课程的所有学生成绩信息。


--（3）使用视图v_scoreDetail查询计算机系各班各门课程的学生人数、平均分、
--最高分、最低分，并按班级与课程排序。


--3．竖表转换为横表
--【例5-29】成绩数据可以方便地以图5-7(a)的形式显示或打印，但现在要求以
--图5-7(b)的格式列出软件1班和软件2班的各门课程的成绩表。

