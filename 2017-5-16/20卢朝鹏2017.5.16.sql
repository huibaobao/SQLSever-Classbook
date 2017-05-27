--��5��  ���ݿ���
--��ϰ
--5.1 ���������̿������
--5.2 �ű��ļ�
--5.3 �α�
use score
go

--�¿�
--5.4��ͼ
--5.4.1 ������ͼ
--Create View [���ݿ�.][ӵ����.]<��ͼ��> [������1����������n��]
--[With Encryption]
--As
--Select ���
--[With Check Option]
--����5-22�������ɼ���ͼV_stuScore��ͨ������ͼ����ʾѧ��ѧ�ڡ�ѧ�š��������γ̺š�
--�γ������γ�������ͳɼ���
Create View v_stuScore
As
Select term,student.student_id ѧ��,student.name ����, 
course.course_id �γ̺�,course.name �γ���, 
course_type.name �γ������,score �ɼ�
From student 
Join score on student.student_id=score.student_id
Join course on course.course_id=score.course_id
Join course_type on course_type.course_type_id=course.course_type_id
go

--����5-23������ͼv_ stuScore��ѯ�γ�����Ϊ��רҵ�Ρ��ĳɼ���Ϣ��
select * from v_stuScore where �γ������='רҵ��'
go


--����5-24�� ����ѧ����ϵ�����༶������ͼv_student������ʾѧ����student�������ֶΣ�
--���༶���ơ�רҵ���ơ�ϵ��������Ϣ��ʹ����ͼv_student��ѯ������������Ϣ��ϵ����רҵ��
--�༶��ѧ�š��������Ա𣩣�
--ʹ����ͼv_student����ͳ�Ƹ�ϵ������Ů��������
--������ͼv_student  
Create View v_student
As 
Select student.*,  
department.name ϵ������,major.name רҵ����,school_class.name �༶����
From student
	  Join school_class on school_class.school_class_id=student.school_class_id
     Join major on major.major_id=school_class.major_id
		 Join department on department.department_id=major.department_id
Go
--ʹ����ͼv_student��ѯ����������������Ϣ
Select ϵ������,רҵ����,�༶����,
      Student_id ѧ��,name ����,sex �Ա�
From v_student
Where sex= 'M'
and name like '��%'
go
 
--ʹ����ͼv_student����ͳ�Ƹ�ϵ������Ů������
Select ϵ������, �༶����,sex �Ա�,Count(*) ѧ������
From v_student 
Group By ϵ������, �༶����,sex 
go

--2 �޸���ͼ
--Alter View [���ݿ�.][ӵ����.]<��ͼ��> [������1����������n��]
--[With Encryption]
--As
--Select ���
--[With Check Option]
--����5-25���޸���ͼv_stuscore��ͨ������ͼ����ʾѧ��ѧ�ڡ�ѧ�š�������
--�γ̺š��γ�������ʦ���ͳɼ���
Alter View v_student
As		
Select term,student.student_id ѧ��,student.name ����, 
course.course_id �γ̺�,course.name �γ���, 
faculty.name ��ʦ��,score �ɼ�
From student 
Join score on student.student_id=score.student_id
Join course on course.course_id=score.course_id
Join faculty on faculty. faculty_id=score.faculty_id
go


--5.4.3 ɾ����ͼ
--����5-26��ɾ�����е�v_stuscore��ͼ��
drop view v_stuScore
go

--5.4.4 ��ͼ��Ӧ��
--1��Ϊһ��������ͼ
--����5-27�����ڳɼ���score����2����ͼ���ֱ���ѧ���İٷ��Ƴɼ���ͼ�͵ȼ��Ƴɼ���ͼ��
Create View v_score 		--�ٷ��Ƴɼ���ͼ
As
Select score_id,term,score,score1,course_id,student_id,faculty_id,remark
From score
Where score is not null
Go

Create View v_grade 		--�ȼ��Ƴɼ���ͼ
As
Select score_id,term,grade,grade1,course_id,student_id,faculty_id,remark
From score
Where grade is not null
go

--2��Ϊ������Ӵ�����ͼ

--����5-28������ѧ���ɼ�������ͼv_scoreDetail������ʾѧ���ɼ���score�������ֶΡ�
--ѧ���������γ����ơ��༶���ơ�ϵ�����Ƶ���Ϣ������ͼv_scoreDetail��ѯ
--ѡ�ޡ�C++������ơ��γ̵�����ѧ���ɼ���Ϣ��ϵ�����ơ��༶���ơ�ѧ�š�
--ѧ���������γ����ơ��ٷ��Ƴɼ�������ѯ�������ϵ��������ſγ̵�
--ѧ��������ƽ���֡���߷֡���ͷ֡�
--��1������ѧ���ɼ�������ͼv_scoreDetail
Create View v_scoreDetail 
As 
Select score.*,student.name ѧ������,course.name �γ�����,
school_class.name �༶����,department.name ϵ������
From score
     Join course on course.course_id=score.course_id
Join student on student.student_id=score.student_id
Join school_class on school_class.school_class_id=student.school_class_id
Join major on major.major_id=school_class.major_id
Join department on department.department_id=major.department_id
go

--��2��ʹ����ͼv_scoreDetail��ѯѡ�ޡ�C++������ơ��γ̵�����ѧ���ɼ���Ϣ��
select * from v_scoreDetail
where �γ�����='C++�������'
go


--��3��ʹ����ͼv_scoreDetail��ѯ�����ϵ������ſγ̵�ѧ��������ƽ���֡�
--��߷֡���ͷ֣������༶��γ�����
select �༶����,�γ�����, count(*) ѧ������,avg(score) ƽ����,max(score) ��߷�,min(score) ��ͷ� from v_scoreDetail
group by �༶����,�γ�����
order by �༶����
go


--3������ת��Ϊ���
--����5-29���ɼ����ݿ��Է������ͼ5-7(a)����ʽ��ʾ���ӡ��������Ҫ����
--ͼ5-7(b)�ĸ�ʽ�г����1������2��ĸ��ſγ̵ĳɼ���
create view v_score_C1001 as select * from score where course_id='C1001' and student_id like 'SW%'	
go
create view v_score_C1002 as select * from score where course_id='C1002' and student_id like 'SW%'	
go
create view v_score_C2001 as select * from score where course_id='C2001' and student_id like 'SW%'	
go
create view v_score_C3004 as select * from score where course_id='C3004' and student_id like 'SW%'	
go
create view v_score_C3005 as select * from score where course_id='C3005' and student_id like 'SW%'	
go
create view v_score_C3006 as select * from score where course_id='C3006' and student_id like 'SW%'	
go



Select school_class.name �༶, student.name ����,
		  v_score_C1001.score Ӣ��,
		  v_score_C1002.score ��ѧ����,
		  v_score_C2001.score ����,
		  v_score_C3004.score ���ݿ�,
		  v_score_C3005.score [C++���1��],
		  v_score_C3006.score Java���2��
From student
		 Join school_class on student.school_class_id=school_class.school_class_id
		 Left Join v_score_C1001 on student.student_id=v_score_C1001.student_id
		 Left Join v_score_C1002 on student.student_id=v_score_C1002.student_id
		 Left Join v_score_C2001 on student.student_id=v_score_C2001.student_id
		 Left Join v_score_C3004 on student.student_id=v_score_C3004.student_id
		 Left Join v_score_C3005 on student.student_id=v_score_C3005.student_id
		 Left Join v_score_C3006 on student.student_id=v_score_C3006.student_id
Where student.student_id like 'SW%'
go
