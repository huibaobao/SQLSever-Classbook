use score
go

select * from score
go

首先创建一个极其简单的银行表（bank），其中有2个账户A和B，分别存入了2000元和3000元。
create database test

use test

Create Table bank
(
	account varchar(20) not null primary key,		-- 账户，主键
	ammount money							-- 存款数目
)

insert into bank values('A', 2000)					-- 账户A有存款 2000元
insert into bank values('B', 3000) 					-- 账户B有存款 3000元

select * from bank

--创建账户信息表(userInfo)、交易信息表(trans)
create table userInfo(cardID char(4) primary key,                          --卡号
                  uName char(8),                                       --顾客姓名
                  uMoney money constraint ck_uMoney check(uMoney>=1))  --当前余额
go
create table trans(cardID char(4),                                          --卡号
                   tType char(4),                                            --交易类型(存入/支取)
                   tMoney money,                                            --交易金额
                   tDate datetime constraint df_tDate default(getdate()))   --交易日期
go


--插入测试数据：张明1000元，李宏1元
insert into userInfo values('1001','张明',1000)
insert into userInfo values('1002','李宏',1)
go


--创建实现存取款时，会触发的触发器：
create trigger trig_trans
on trans
after insert
as
begin
    declare @cardID char(4),@tType char(4),@tMoney money
    select @cardID,@tType,@tMoney from inserted
  if @tType='存入'
     update userInfo set uMoney=uMoney+@tMoney where cardID=@cardID
  else
     update userInfo set uMoney=uMoney-@tMoney where cardID=@cardID
  print '交易成功！交易金额:'+convert(varchar(20),@tMoney)
end



--测试数据：
begin transaction 
insert into trans(cardID,tType,tMoney) values('1001','支取',200)
--select 5/0
if @@error!=0						-- 如果出现错误，将回滚
    rollback
insert into trans(cardID,tType,tMoney) values('1002','存入',500)
--select 5/0
if @@error!=0						-- 如果出现错误，将回滚
    rollback
commit
go

--查看结果
select * from userInfo
select * from trans
go


use score
go
create trigger t_up
on student
instead of update
as
	begin
	end