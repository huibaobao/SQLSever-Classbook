--4.4子查询
--4.4.1嵌套子查询
--嵌套子查询的常用语法格式如下：
--Select 列名列表
--From 表名
--Where 表达式 运算符  (Select 子查询)
--根据子查询返回值的类型，可以将嵌套子查询分为返回标量值的子查询、返回集合的子查询、返回表的子查询。
use score
go

--一、返回标量值的子查询
--这类子查询返回的值是一个标量，即子查询结果为单列单行的数值。这个标量可以使用在多数场合，一般用于关系运算符（=、>、<、>=、<=、<>、!=、!<、!>等）的运算中。
--【例4-37】查询百分制成绩高于全部学生平均成绩的学生成绩信息。
select	*	from score
where  score > (select avg(score) from score)


--【例4-38】 查询与学号为“SW103203”的同学同班的学生学号与姓名。
select student_id,name from student
where school_class_id =
	(select school_class_id from student 
	where student_id='SW103203')

--【例4-39】查询与学号为“SW103203”的同学同班的学生学号、姓名、班级编码与班级名称。

select st.student_id,
		st.name,
		scl.school_class_id,
		scl.name
 from student st,
	school_class scl
where scl.school_class_id=
		(select stu.school_class_id from student stu
		 where	stu.student_id='SW103203')


--二、返回集合的子查询
-- 当子查询返回的值仍然是单列，但可能有多行时，多行的值就形成了一个集合，因此可以使用与集合有关的运算操作，如In、Any、All等。
--1．In子查询
--【例4-40】查询与学生“刘文雪”同班的学生学号、姓名与班级编码。
select stu.id_number,
		stu.name,
		stu.school_class_id
from student stu
where stu.school_class_id in
	(select school_class_id from student where name='刘文雪')
go


--【例4-41】查询学生“刘文雪”的成绩信息。
select * from score
where student_id in
(select student_id from student where name='刘文雪')
go

--2．Any和All子查询
--当子查询中返回单值时可以使用比较运算符，而当子查询中返回多值时就不能单独使用比较运算符，此时可使用“关系运算符 Any” 或“关系运算符 All”组合运算符。表4-8列出了关系运算符与Any、All的各种组合使用方式。
--表4-8 关系运算符与Any或All的组合使用
--运算符	说明	举例（子查询返回的集合是 3,5,7，列名是col）
-->Any	大小集合中的任意一个值，即大于最小值	col > Any (3,5,7)，相当于 col > 3
--=Any	等于集合中的任意一个值，即等于任意一个值	col = Any (3,5,7)，相当于 col = 3 or col =5 or col = 7
--<Any	小于集合中的任意一个值，即小于最大值	col <Any (3,5,7)，相当于 col < 7
-->All	大于集合中的所有值，即大于最大值	col > All (3,5,7)，相当于 col > 7
--<All	小于集合中的所有值，即小于最小值	col <All (3,5,7)，相当于 col < 3
--说明：其中“=Any”的效果与In子查询相同，不存在“=All”子查询。

--【例4-42】查询比任何一门课程平均成绩高的学生成绩信息。
select * from score
where score >any (select avg(score) from score)
go


--【例4-43】查询比所有课程平均成绩高的学生成绩信息。
select * from score
where score>all(select AVG(score) from score)
go

--【例4-44】查询恰好等于某门课程平均成绩的学生成绩信息。
select * from score
where score=any(select avg(score) from score)
go


--三、返回表的子查询
--子查询不仅可以放在where子句中，还可以放在from子句之后。这时子查询可以返回多行多列，子查询的地位相当于一张表。
--【例4-45】查询各门课程的平均成绩。
--【例4-45】的子查询返回两列多行的结果，这样的结果就是一张数据表，为这张表起了一个别名为avgpscore，然后我们就能象使用普通的表一样使用avgpscore表了。

--4.4.2相关子查询
--相关子查询与前面的嵌套子查询有一个本质的区别，相关子查询的查询条件依赖于外部父查询中的某个字段值。因此，相关子查询中的子查询不能单独运行。
--相关子查询的执行过程与嵌套子查询不同，嵌套子查询中的子查询只执行一次，而相关子查询中的子查询需要重复地执行。
--一、引用子查询的值
--这种类型的父查询引用子查询的结果值，即将父查询中的列的值使用关系运算符与子查询中的值进行比较。
--【例4-46】查询成绩高于该同学平均成绩的学号、课程号和成绩。

select student_id,course_id,score from score	sc1
	where score>
	(select avg(score) from score sc2 
		where sc2.student_id=sc1.student_id) 
go


--二、不引用子查询的值
--这种类型的父查询不引用子查询的结果值，而只是检查子查询是否返回了记录，这时使用Exists关键字。使用Exists的子查询不返回任何数据，只产生逻辑值True或False，即子查询的结果集中至少包含一个元组，则Exists子查询返回True；子查询结果集为空，则Exists子查询返回False。
--【例4-47】 用Exists子查询，查询与“刘文雪”同班同学的信息（包括学号、姓名与班级编号）。
select student_id,name,school_class_id from student stu1
where exists 
		(select school_class_id from student stu2
			where stu2.school_class_id=stu1.school_class_id
			and name='刘文雪')
go

--【例4-48】 用Not Exists子查询，查询没有选修课程号为“C3001”的学生学号与姓名。
select * from student stu,course cs
where not exists 
		(select course_id from course where course_id='C3001')


--4.5基于数据查询的数据操纵
--在第3章中讨论了数据操纵语句的数据插入、更新和删除语句的基本格式，本节重点讨论在数据查询的基础上进行数据插入、更新和删除，即联合使用Select和Insert、Update、Delete语句。
--4.5.1联合使用Select和Insert语句
--Select语句可以联合使用Insert语句，把Select语句的查询结果插入到数据表中，格式如下：
--Insert [Into] <数据表名> [（字段列表1）]
--Select字段列表2
--From表名
--【例4-49】将成绩表中所有成绩不及格（百分制成绩小于60或者等级制成绩为不及格）的学生的信息插入到student_nopass表中（student_nopass表中包含以下字段：学号student_id、姓名name、性别sex和所属班级编号school_class_id，这些字段的数据类型等与student表中相应字段相同）。
--【例4-50】根据班级教学任务信息表（如表4-9所示）对成绩表score进行初始化工作，即将学生表student中指定的班级学生学号和相应的课程代码等信息添加到成绩表score中。


--4.5.2联合使用Select和Update语句
--Update语句中可以联合使用Select语句。Update语句中可以将Select语句的查询结果作为数据更新的条件，也可以作为更新的数值。
--【例4-51】为“计算机网络技术”课程所有成绩小于60分的记录增加5分。
--【例4-52】为班级表增加一个字段“班级人数student_number”，从学生表中统计出各班的班级人数，更新班级表中新增的班级人数字段的数据。


--4.5.3联合使用Select和Delete语句
--Delete语句中可以联合使用Select语句，将Select语句的查询结果作为数据删除的条件。
--【例4-53】在成绩表score中，删除“刘文雪”同学的所有成绩。

