use  score
go

--P106  习题 4
--下列习题中，涉及到数据查询，请参考附录A学生成绩管理系统数据表结构。 
--6．编写Select语句，查询学生表中的学号、姓名和性别列。
select name 姓名,
		student_id 学号,
		sex 性别
from student
go

--7．编写Select语句，在成绩表score中查询学号、课程代码、学年和学期、成绩（百分制），列名用汉字显示。
select student_id 学号,
		course_id 课程代码,
		term 学年学期 ,
		score 成绩
 from score
 go

--8．编写Select语句，在成绩表score中查询百分制补考成绩前5名的学生学号和百分制补考成绩。
select top(5) 
		score1 补考成绩,
		student_id 学号
		from score
		order by score1 desc
go

--9．编写Select语句，查询所属系部编码为“30”的专业信息，包括专业编号和专业名称。

select major_id 专业编号,
		name 专业名称
from major
	where department_id like '30'
go


--10．编写Select语句，从成绩表中查询出等级成绩为“优秀”、“良好”或“中等”的学生学号、课程编码和等级成绩。
update score
	set grade = 
		case  
			when score>=90 then '优秀'
			when score>=80 then '良好'
			when score>=70 then '中等'
			when score>=60 then '及格'
			when score<60 then '不及格'
		end

select student_id ,course_id,grade from score
	where grade not in('及格','不及格')
		group by grade,student_id,course_id
			order by grade desc
go

--11．编写Select语句，显示课程表中的课程编号、课程名称、学时及学分（该列为计算列，学分=学时/16），使用别名“Course_Num”标识被计算列。查询结果按学时由高到低排列。

select course_id ,name,class_hour, class_hour/16 Course_Num
	
from course
	order by class_hour asc
go

--12． 编写Select语句，查询出所有尚未定学时（即学时为空）的课程信息，包括课程编号和课程名称。
select course_id ,name from course
	where class_hour is null;
go

--13．编写Select语句，查询出课程表中的所有编号（Course_Id）中前两个字符为“C1”的课程信息，显示课程编号、课程名称和学时。
select course_id,name,class_hour from course
	where course_id like '%C1'
go

--14．编写Select语句，查询1988年上半年前（1月1日到6月30日）出生的学生信息（包括学号、姓名、班级）。


--15．编写Select语句，在学生表student中统计各班级的男女生人数。
select count(sex) ,school_class_id from student where sex='M'
	group by school_class_id
union
select count(sex) ,school_class_id from student where sex='F'
	group by school_class_id		

--16．编写Select语句，统计出成绩表中各个学生的百分制成绩的平均分，要求显示学号、平均分。

--17．编写Select语句，查询成绩表中百分制成绩平均分低于70的学生学号。
