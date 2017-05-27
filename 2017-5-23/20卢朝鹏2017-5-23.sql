use score
go
--5.7 �洢����
--5.7.1 �洢���̵ĸ���
--5.7.2 ϵͳ�洢����
--5.7.3 �û��Զ���洢����
--1�������ʽ
--Create Procedure <�洢������> 
--[�β��б�]
--As   
--<SQL���>
--����5-44����scoresys�д����洢����p_score���ô洢�����ܸ���ѧ�Ų�ѯ��ѧ���ĳɼ���Ϣ��ѧ�š��������Ա𡢿γ̺š��γ������ɼ�����
create proc p_score @stu_id varchar(36)
as
select stu.student_id,stu.name,stu.sex,cs.course_id,cs.name,sc.score
from student stu,course cs,score sc
where stu.student_id=sc.student_id	and sc.course_id=cs.course_id and stu.student_id=@stu_id

exec p_score 'SW103203'
go

--2���洢���̵ĵ���
--��1�����ø�ʽ1����λ�ô��ݣ�   
--Execute <�洢������> <ʵ��1>,<ʵ��2>,��,<ʵ��n>


--��2�����ø�ʽ2��ͨ�����������ݣ�
--Execute <�洢������> @<�β�1>=<ʵ��1>������@<�β�n>=<ʵ��n>,


--����5-45����scoresys�д����洢����p_score1���ô洢�����ܸ����ṩ��ѧ�źͿγ̺Ų�ѯ�ɼ���
create proc p_score1 @stu_id varchar(36),@cs_id varchar(36)
as
select stu.student_id,stu.name,stu.sex,cs.course_id,cs.name,sc.score
from student stu,course cs,score sc
where stu.student_id=sc.student_id	and sc.course_id=cs.course_id 
		and stu.student_id=@stu_id	and cs.course_id=@cs_id

exec p_score1 'SW103203','C2002'
go
--3��������Ĭ��ֵ�Ĵ洢����
--����5-46����������5-44���У����������Ĭ��ֵ�Ĵ洢����p_score2��
create proc p_score2 @stu_id varchar(36) ='SW103203' ,@cs_id varchar(36) = 'C2002'
as
select stu.student_id,stu.name,stu.sex,cs.course_id,cs.name,sc.score
from student stu,course cs,score sc
where stu.student_id=sc.student_id	and sc.course_id=cs.course_id 
		and stu.student_id=@stu_id	and cs.course_id=@cs_id

exec p_score2
go
/*
4�����ز���ֵ�洢����
��1�����巵�ز���ֵ�Ĵ洢����
��Ҫͨ���洢���̷���һ������ֵ����洢���̵��β�Ӧ����Ϊ��
@ <�β�1> <����>[=Ĭ��ֵ] Output,��,@ <�β�n> <����>[=Ĭ��ֵ] Output
����5-47����scoresys���ݿ��д���һ���洢���̣��洢������Ϊp_stunum��Ҫ����ݰ༶������ð༶��ѧ��������*/
create proc p_stunum @scl_id varchar(10),@num int output
as
select @num=count(*) from student
where school_class_id=@scl_id

declare @count int
exec p_stunum  'SW1032',@count output
print '�ð�ѧ������:'+ convert(char(5),@count)
drop proc p_stunum
go

/*5���洢������״̬�����ĳ��ô�����
��1��@@rowCount
(2)@@error*/

--6���洢���̵ķ���ֵ



/*5.7.4 ����洢����
1���鿴�洢����
2���޸Ĵ洢����
����5-50��ͨ��Alter Procedure����޸���Ϊp_stunum�洢���̣�ʹ�����Ϊ���ݰ༶����ͳ��ѧ��������*/

/*3���������洢����
����5-51����p_stunum�洢������������Ϊp_student_count*/


--4��ɾ���洢����


--20.
create proc p_class @classid varchar(10)
as
select dept.name,mj.name,sc.name from school_class sc,major mj ,department dept
where sc.major_id=mj.major_id 
	and mj.department_id=dept.department_id 
	and sc.school_class_id=@classid

exec p_class 'SW1031'
go

--21
create proc p_num @courseid varchar(10),@coursecount int output
as 
select @coursecount=count(*) from score
where course_id=@courseid

declare @count int
exec p_num 'C1001',@count output
print 'ѡ������'+convert(varchar(10),@count)