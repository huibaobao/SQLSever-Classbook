--5.6事务和锁
--5.6.1事务
--【例5-37】将【例5-36】的银行转帐的问题改用事务进行处理。
--（1）首先创建一个极其简单的银行表（bank），其中有2个账户A和B，分别存入了2000元和3000元。
Create Table bank
(
	account varchar(20) not null primary key,		-- 账户，主键
	ammount money							-- 存款数目
)

insert into bank values('A', 2000)					-- 账户A有存款 2000元
insert into bank values('B', 3000) 					-- 账户B有存款 3000元
--（2）现在账户A想转500元钱给账户B，这时的操作应该是：
Update bank set ammount = ammount - 500
Where account = 'A'
-- 时间点
Update bank set ammount = ammount + 500
Where account = 'B'


--5.6.2锁机制
--【例5-39】下述2段代码演示了一个排它锁。打开两个并排的窗口，在其中一个查询窗口（窗口1），输入下述代码，并执行。
Begin Transaction
Update score 
set score = score + 5
Where score <60
commit
--这时显示“(13 行受影响)”，并且对成绩表score加上了排它锁，禁止任何人访问这个表。由于这个事务已经开始，但没有结束（提交或回滚），这个排它锁没有被释放。
--在另一个查询窗口（窗口2）输入下述代码，并执行。
Select student_id,course_id,score
From score
