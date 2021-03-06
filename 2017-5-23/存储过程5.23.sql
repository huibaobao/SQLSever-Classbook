5.7 存储过程
5.7.1 存储过程的概念
5.7.2 系统存储过程
5.7.3 用户自定义存储过程
1．定义格式
Create Procedure <存储过程名> 
[形参列表]
As   
<SQL语句>
【例5-44】在scoresys中创建存储过程p_score，该存储过程能根据学号查询该学生的成绩信息（学号、姓名、性别、课程号、课程名、成绩）。


2．存储过程的调用
（1）调用格式1（按位置传递）   
Execute <存储过程名> <实参1>,<实参2>,…,<实参n>


（2）调用格式2（通过参数名传递）
Execute <存储过程名> @<形参1>=<实参1>，…，@<形参n>=<实参n>,


【例5-45】在scoresys中创建存储过程p_score1，该存储过程能根据提供的学号和课程号查询成绩。


3．带参数默认值的存储过程



【例5-46】在例【例5-44】中，定义带参数默认值的存储过程p_score2。



4．返回参数值存储过程
（1）定义返回参数值的存储过程
若要通过存储过程返回一个或多个值，则存储过程的形参应定义为：
@ <形参1> <类型>[=默认值] Output,…,@ <形参n> <类型>[=默认值] Output
【例5-47】在scoresys数据库中创建一个存储过程，存储过程名为p_stunum，要求根据班级号输出该班级的学生人数。



5．存储过程中状态或错误的常用处理方法
（1）@@rowCount
(2)@@error

6．存储过程的返回值



5.7.4 管理存储过程
1．查看存储过程
2．修改存储过程
【例5-50】通过Alter Procedure语句修改名为p_stunum存储过程，使其更改为根据班级名称统计学生人数。

3．重命名存储过程
【例5-51】将p_stunum存储过程重新命名为p_student_count

4．删除存储过程
