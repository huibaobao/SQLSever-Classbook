--习题 4
--下列习题中，涉及到数据查询，请参考附录A学生成绩管理系统数据表结构。
--1．Select数据查询语句由哪些子句组成，分别起什么作用？
--2．Select语句中连接查询可为哪几类查询，分别叙述其特点？
--3．Group By子句的作用是什么？Having子句与Where子句中的条件有什么不同？
--4．在进行连接查询时，有几种连接表的方法？它们之间有什么区别？
--5．子查询又可分为哪几类查询，分别叙述其特点？ 
--6．编写Select语句，查询学生表中的学号、姓名和性别列。
--7．编写Select语句，在成绩表score中查询学号、课程代码、学年和学期、成绩（百分制），列名用汉字显示。
--8．编写Select语句，在成绩表score中查询百分制补考成绩前5名的学生学号和百分制补考成绩。
--9．编写Select语句，查询所属系部编码为“30”的专业信息，包括专业编号和专业名称。
--10．编写Select语句，从成绩表中查询出等级成绩为“优秀”、“良好”或“中等”的学生学号、课程编码和等级成绩。
--11．编写Select语句，显示课程表中的课程编号、课程名称、学时及学分（该列为计算列，学分=学时/16），使用别名“Course_Num”标识被计算列。查询结果按学时由高到低排列。
--12． 编写Select语句，查询出所有尚未定学时（即学时为空）的课程信息，包括课程编号和课程名称。
--13．编写Select语句，查询出课程表中的所有编号（Course_Id）中前两个字符为“C1”的课程信息，显示课程编号、课程名称和学时。
--14．编写Select语句，查询1988年上半年前（1月1日到6月30日）出生的学生信息（包括学号、姓名、班级）。
--15．编写Select语句，在学生表student中统计各班级的男女生人数。
--16．编写Select语句，统计出成绩表中各个学生的百分制成绩的平均分，要求显示学号、平均分。
--17．编写Select语句，查询成绩表中百分制成绩平均分低于70的学生学号。


--18．编写Select语句，使用内连接方式和等值连接两种方式显示学生的学号、姓名、班级名和专业名，并按学号升序排列。
--19．编写Select语句，使用外连接查询出班级编码为“SW1031”的每个学生的选课及成绩信息（包含学生学号、姓名、课程编码、百分制成绩）。如果学生没有选课，则课程编号和成绩列用空值填充。


--20．编写Select语句，在学生表student、班级表school_class和成绩表score中查询百分制成绩高于平均成绩的学生学号、姓名、班级名称。
use score
go

select stu.student_id,
		stu.name,
		scl.name 
from student stu,school_class scl,score sc
where sc.score>(select avg(score) from score)
	and stu.student_id=sc.student_id
	and stu.school_class_id=scl.school_class_id
go

--21．编写Select语句，分别使用嵌套子查询和内连接两种方式查询选修“科学技术基础”课程的学生学号和百分制成绩。
use score 
go
select sc.student_id,sc.score from score sc,course cs,student stu
where sc.course_id=(select course_id from course where name='科学技术基础')
		and sc.student_id=stu.student_id
		and cs.name='科学技术基础'
go

select stu.student_id,sc.score from score sc,course cs,student stu
where sc.course_id=cs.course_id
	and sc.student_id=stu.student_id
	and cs.name='科学技术基础'
go


--22．请根据【例4-50】的要求，写出表4-9中后面4条信息对应的成绩初始化语句。
--23．为班级表school_class插入一个字段：平均成绩avg_score，然后从成绩表中统计每个班级的平均百分制成绩，并更新到班级表的avg_score字段中。
--24．在学生表中删除已经毕业（学籍类型名称=“毕业”）的学生记录。
