--第4章 数据查询  练习卷
--（2017.4.27）
--参考教材  附录A  学生成绩管理系统数据表结构

--一、简单查询。
--1.	查询所有列：显示学生信息表student中所有学生的记录。
--2.	查询指定列：显示学生信息表student中所有学生的student_id，name及sex。
--3.	在查询中使用列别名：显示学生信息表student中所有学生的student_id（别名为学号）、name（别名为姓名）和birthday（别名为出生日期）。
--4.	使用TOP或PERCENT限制返回行数：显示student表中前3条记录的student_id、name和birthday字段。
--5.	使用Distinct消除重复的行：显示学生成绩表score中选修了课程的学生学号。
--6.	在查询中使用聚合函数（sum、avg 、max、min）：在学生成绩表score中查询显示总成绩、平均成绩、最高分及最低分。
--7.	（count）：显示学生成绩表score中记录数。
--8.	INTO子句：查询显示student表中所有男学生的信息，并形成新表student_info。（提示：在from前面加入into student_info子句，刷新数据库，会看到多了一个表。如果不指定路径，则路径与源表相同。）
--9.	Where子句，并使用比较运算符：查询显示学生成绩表score中成绩在80分及以上的学生记录。
--10.	Where子句，并使用between关键字：查询显示学生信息表student中出生日期在1989年1月1日至1990年12月31日之间的学生记录。
--11.	使用LIKE关键字（模糊查询）：在学生信息表student中查询显示所有姓王的学生信息。
--12.	Group by子句：统计成绩表score中不同课程的平均分。
--13.	统计学生成绩表score中每个学生的总成绩及平均成绩。
--14.	Having子句：查示学生成绩表score中平均成绩在70分及以上的学生的学号和平均成绩。
--15.	显示学生成绩表score中选修课程超过2门，并且成绩都在70分以上的学生的学号。
--16.	Order by子句：显示学生成绩表score中每个学生的学号及平均成绩，并按平均成绩降序排序。

--二．多表联接查询。
--1.	内联接：查询显示所有参加了考试的学生的学号、姓名、课程编号及考试成绩。
--2.	左外联接：统计所有学生的考试情况，要求显示所有参加考试的学生的学号、姓名及课程编号和考试成绩，没有参加考试的学生也要显示出来。
--3.	右外联接：统计所有课程的选修情况，要求显示所有课程编号、考试成绩和所有开设的课程名称。

--三．子查询。
--1.  使用比较运算符：查询学生信息表student中年龄比“陈琳”大的学生，要求显示这些学生的信息。

select * from student
where	birthday<(select birthday from student	where name='陈琳')
go

--2.	使用IN：查询所有参加了考试的学生名单。
/*select stu.name,sc.score from student stu,score sc
where sc.student_id=stu.student_id
	and stu.student_id in (select student_id from score
			where score is not NULL)
go*/

select stu.name from student stu
where stu.student_id in (select student_id from score
			where score is not NULL)
go


--3.	使用Exists：查询显示选修了C1001课程的所有学生的姓名。
select stu.name from student stu
where exists 
	(select * from score sc where course_id='C1001'
	and	stu.student_id=sc.student_id)
