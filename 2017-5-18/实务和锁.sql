--5.6�������
--5.6.1����
--����5-37��������5-36��������ת�ʵ��������������д���
--��1�����ȴ���һ������򵥵����б�bank����������2���˻�A��B���ֱ������2000Ԫ��3000Ԫ��
Create Table bank
(
	account varchar(20) not null primary key,		-- �˻�������
	ammount money							-- �����Ŀ
)

insert into bank values('A', 2000)					-- �˻�A�д�� 2000Ԫ
insert into bank values('B', 3000) 					-- �˻�B�д�� 3000Ԫ
--��2�������˻�A��ת500ԪǮ���˻�B����ʱ�Ĳ���Ӧ���ǣ�
Update bank set ammount = ammount - 500
Where account = 'A'
-- ʱ���
Update bank set ammount = ammount + 500
Where account = 'B'


--5.6.2������
--����5-39������2�δ�����ʾ��һ�������������������ŵĴ��ڣ�������һ����ѯ���ڣ�����1���������������룬��ִ�С�
Begin Transaction
Update score 
set score = score + 5
Where score <60
commit
--��ʱ��ʾ��(13 ����Ӱ��)�������ҶԳɼ���score����������������ֹ�κ��˷��������������������Ѿ���ʼ����û�н������ύ��ع��������������û�б��ͷš�
--����һ����ѯ���ڣ�����2�������������룬��ִ�С�
Select student_id,course_id,score
From score
