--5.5����
--5.5.1��׼���������ú���) 
--����5-30����ʾ�����ǰ�����е��ꡢ�¡��ա�


--����5-31���ֱ�ʹ��CAST��CONVERT�������ַ���ABCDEFGHIGת��ΪNVARCHAR(6)���͡�
print cast('ABCDEFGHIG' as NVARCHAR(6))
select convert(NVARCHAR(6),'ABCDEFGHIG')

--����5-32����д�����÷�����������ǰ���ݿ��û��������ݿ�ID�ź͵�ǰ���ݿ�����
select HOST_NAME(),CURRENT_USER,DB_ID(),DB_NAME(DB_ID())

--5.5.2�Զ��庯��
--SQL Server 2012֧�������û��Զ��庯�����ֱ��Ǳ����ͺ���������������䣩��ֵ�ͺ���
--�Ͷ�����ֵ�ͺ�����
--1�������ͺ���
Create Function  [�û���].<������> ���β��б�
Returns <������������>
[As]
Begin
<�����1>
Return ����ֵ
<�����2>
End
--����5-33����scoresys���ݿ��д���һ���Զ��庯�������������ڼ������䣬Ȼ���
--ѧ��������м��������������ѧ����Ϣ������ѧ�š��������Ա�����䣩��
create function Age(@birthday datetime)
returns tinyint
as 
   begin
       return year(getdate())-year(@birthday)
   end

select [student_id],[name],[sex],[dbo].[Age]([birthday])
  from [dbo].[student]

--2������������䣩��ֵ�ͺ���
Create Function  [�û���].<������> ���β��б�
Returns  Table 
[With Encryption]
[As]
<�����1>
Return ��Select ��䣩
<�����2>
--����5-34����scoresys���ݿ��д���һ���Զ��庯�������������ϵ������
--��ѯ����ϵ�����а༶�Ļ�����Ϣ�������༶���롢�༶����רҵ���ƣ���



--3��������ֵ�ͺ���
Create Function  [�û���].<������> ���β��б�
Return @�ֲ����� Table (<���ر���>)
[With Encryption]
[As]
Begin
<�����>
Return
End
--����5-35����scoresys���ݿ��д���һ���Զ��庯������������İ༶����
--��ѯ���ð༶����ѧ���������Ϣ��Ҫ�����ѧ�š��������Ա𡢰༶����רҵ����ϵ������



