--数据查询语句（Select）基本结构
--语句一般格式如下:
/*Select   [All | Distinct]  <目标表达式1> [，……n]
**From  <表名 | 视图名> [，……n]
**[Where  <条件表达式>]
**[Group  By  <表达式列表> ]
**[Having  <条件表达式> ] 
**[Order  By  <表达式>  [Asc | Desc] ]
*/
use score
go

--简单查询
--（1）Select…From子句
--一、选择全部列
--【例4-1】查询学生的所有信息。
select * from student
go
--二、选择指定列
--【例4-2】查询学生的姓名、性别和出生日期。
select name,sex,birthday from student
go

--三、使用计算列
--【例4-3】查询学生表的学号、姓名、性别和年龄。
select student_id,name,sex,year(getdate())-year(birthday) as age from student
go

--四、为列指定别名

--【例4-4】查询学生的学号、姓名、性别和年龄，用中文别名显示字段名。
select student_id	学号,
		name	姓名,
		sex		性别,
		year(getdate())-year(birthday) 年龄
	from student
go

--五、消除重复的行
--【例4-5】基于学生表查询班级编号。

select distinct school_class_id from student
go

--六、无条件选择部分行
--【例4-6】查询成绩表中百分制成绩最高的前3行。
select top 3 score from score
	order by score desc
go


--（2）Where子句
--一、关系表达式
--【例4-7】查询所有男同学的姓名和电话。

select name,telephone from student
	where sex='M'
go

--【例4-8】查询年龄大于21岁的学生的学号、姓名、性别和年龄。
select student_id	学号,
		name	姓名,
		sex		性别,
		year(getdate())-year(birthday) 年龄
	from student where year(getdate())-year(birthday)>21
go

--【例4-9】查询补考后百分制成绩低于原考试百分制成绩的学生学号和2次考试的成绩。
select student_id 学号,
		score 考试成绩,
		score1	补考成绩 from score
	where score1<score
go

--二、范围查询
--【例4-10】查询百分制成绩在80分至95分的学生学号、课程号和成绩（包括80分和95分）。
select student_id 学号,
		course_id 课程号,
		score 成绩
	from score where score between 80 and 95
go


--【例4-11】查询年龄不在21到23之间的学生信息，包括学号、姓名、性别和年龄。
select student_id	学号,
		name	姓名,
		sex		性别,
		year(getdate())-year(birthday) 年龄
	from student where year(getdate())-year(birthday) 
						not between 21 and 23
go


--三、集合查询
--【例4-12】查询等级成绩是优、良和中的学生学号、课程号和成绩，
		  --由于等级制的成绩是不连续的，所以应该使用集合查询。

update score 
	set grade=
		case
			when score>=90 then '优'
			when score>=80 then '良'
			when score>=70 then '中'
			when score>=60 then '及格'
			when score<60	then '不及格'
		end
select * from score
go

select student_id 学号,
		course_id 课程号,
		score 成绩,
		grade 等级
	from score
	where grade in('优','良','中')
go

--四、模糊查询
--【例4-13】查询所有王姓学生
select name 姓名 from student
	where name like '王%'
go

--【例4-14】查询姓名中第2个字是明、志或建的学生。
select name 姓名
	from student
	where name like '_[明志建]%'  --此处可用正则表达式
go

--五、逻辑表达式
--【例4-15】查询成绩低于60分或不及格的学生学号。
select student_id 学号,
		course_id 课程号,
		score 成绩,
		grade 等级
	from score
	where score<60 or grade='不及格'
go
--六、空值判断
--【例4-16】查询百分制考试成绩小于60分，且参加过补考（补考百分制成绩不为空）的学生成绩信息。
select * from score
	where score<60 and score1 is not null
go


--【例4-17】查询课程编号以C3起始，且缺考（百分制考试成绩为空）的学生成绩信息。
select * from score
	where course_id like 'C3%'
		and score is null
go

--（3）Order by子句
--【例4-18】查询成绩表中课程编号以C3起始的学生成绩信息，包括学号、课程号和百分制成绩，要求先按课程号升序排序，然后按成绩从高到低降序排序。
select student_id 学号,
		course_id 课程号,
		score 成绩
		from score
	where course_id like 'C3%'
	order by course_id  
go
--（4）Group by子句
--【例4-19】统计学生总人数。

--【例4-20】统计学生的成绩情况。

--【例4-21】分组统计学生表中各个班级的男女生人数。

--【例4-22】统计成绩表中各门课程百分制成绩的平均分、最高分和最低分。

--【例4-23】统计成绩表中各门课程中及格学生的百分制成绩的平均分、最高分和最低分。

--【例4-24】统计成绩表中各门课程中及格学生的百分制成绩的平均分、最高分和最低分，要求显示平均分超过75分的统计记录，并将查询结果按平均分从高到低排序。

--（5）联合查询
--一、集合并运算
--【例4-25】查询系部表中的系部名称和专业表中的专业名称。
--二、集合交运算
--【例4-26】查询既选修了“C3001”课程又选修了“C3002”课程的学生的学号。



--三、集合差运算
--【例4-27】查询选修了“C3001”课程但是没有选修 “C3002”课程的学生的学号。

