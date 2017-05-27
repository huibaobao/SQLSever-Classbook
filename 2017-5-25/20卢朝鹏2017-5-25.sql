use score
go

select * from score
go

���ȴ���һ������򵥵����б�bank����������2���˻�A��B���ֱ������2000Ԫ��3000Ԫ��
create database test

use test

Create Table bank
(
	account varchar(20) not null primary key,		-- �˻�������
	ammount money							-- �����Ŀ
)

insert into bank values('A', 2000)					-- �˻�A�д�� 2000Ԫ
insert into bank values('B', 3000) 					-- �˻�B�д�� 3000Ԫ

select * from bank

--�����˻���Ϣ��(userInfo)��������Ϣ��(trans)
create table userInfo(cardID char(4) primary key,                          --����
                  uName char(8),                                       --�˿�����
                  uMoney money constraint ck_uMoney check(uMoney>=1))  --��ǰ���
go
create table trans(cardID char(4),                                          --����
                   tType char(4),                                            --��������(����/֧ȡ)
                   tMoney money,                                            --���׽��
                   tDate datetime constraint df_tDate default(getdate()))   --��������
go


--����������ݣ�����1000Ԫ�����1Ԫ
insert into userInfo values('1001','����',1000)
insert into userInfo values('1002','���',1)
go


--����ʵ�ִ�ȡ��ʱ���ᴥ���Ĵ�������
create trigger trig_trans
on trans
after insert
as
begin
    declare @cardID char(4),@tType char(4),@tMoney money
    select @cardID,@tType,@tMoney from inserted
  if @tType='����'
     update userInfo set uMoney=uMoney+@tMoney where cardID=@cardID
  else
     update userInfo set uMoney=uMoney-@tMoney where cardID=@cardID
  print '���׳ɹ������׽��:'+convert(varchar(20),@tMoney)
end



--�������ݣ�
begin transaction 
insert into trans(cardID,tType,tMoney) values('1001','֧ȡ',200)
--select 5/0
if @@error!=0						-- ������ִ��󣬽��ع�
    rollback
insert into trans(cardID,tType,tMoney) values('1002','����',500)
--select 5/0
if @@error!=0						-- ������ִ��󣬽��ع�
    rollback
commit
go

--�鿴���
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