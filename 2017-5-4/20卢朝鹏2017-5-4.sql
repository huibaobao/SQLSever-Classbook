--��5�� ���ݿ��� 
--��ϰ  
--5.1 ���������̿������ 

use score
go
--���¿�
--5.2 �ű��ļ�
--5.2.1 SQL�ű��ļ��ĸ���
--5.2.2 ������
--����5-14����д�������ļ�student.Sql��������ѯѧ����������ͼv_student��Ȼ���ø���ͼ��ѯ���С�������ѧ����ѧ�š��������Ա𡢰༶��
Create View v_student  		    
As
   Select student.*,  school_class.name as class_name
   From student 
Join school_class on student.school_class_id=school_class.school_class_id
Go						
Select student_id ѧ��,name ����,sex �Ա�, class_name �༶ 
From v_student
Where name like '��%' 
Go
--5.2.3ע��
--1������ע��
--2������ע��

--5.3 �α�
--5.3.1�α�ĸ���
--SQL Server ֧��3�����͵��α꣬����ֻ����Transact_SQL �������αꡣ
--5.3.2�α�Ļ�������
--����5-20������@@FETCH_STATUS����ѭ����ȡ�α����ݵĲ�����
--1.����һ���α�
declare current_student cursor
for select * from student						
--2.���α�
open current_student
--3.ִ����ȡ����				  
fetch next from current_student
--4.���@@FETCH_STATUS����ȷ���Ƿ񻹿��Լ�����ȡ
while @@FETCH_STATUS=0
begin
	fetch next from current_student;
end
--5.�ر��α�
close current_student;
--6.�ͷ��α�
deallocate current_student
go

--����5-21������һ���α�Cur_Student�����ڶ�ȡѧ�����С�SW1031�����ѧ����Ϣ��
--������3��ѧ����ѧ��״̬����ΪR05��
--1.����һ���α�						
declare cur_student scroll cursor
for 
select * from student
	where school_class_id = 'SW1031'
--2.���α�
open Cur_Student
--3.��λ����3����¼ִ����ȡ����
fetch absolute 3 from Cur_Student
--4.���µ�ǰ������
update student set roll_id='R05'
where current of Cur_Student
--5.�ر��α�
close Cur_Student
--6.�ͷ��α�
deallocate Cur_Student
go


--5.4��ͼ
--5.4.1��ͼ�ĸ���
--1.����
--2.�ŵ�
--5.5.2������ͼ
1����Create View��䴴����ͼ
Create View [���ݿ�.][ӵ����.]<��ͼ��> [������1����������n��]
[With Encryption]
As
Select ���
[With Check Option]

--����5-22�������ɼ���ͼV_stuScore��ͨ������ͼ����ʾѧ��ѧ�ڡ�ѧ�š��������γ̺š��γ������γ�������ͳɼ���
Create View v_stuScore
With Encryption
As
Select term,student.student_id ѧ��,student.name ����, 
course.course_id �γ̺�,course.name �γ���, 
course_type.name �γ������,pscore �ɼ�
From student 
Join score on student.student_id=score.student_id
Join course on course.course_id=score.course_id
Join course_type on course_type.course_type_id=course.course_type_id

--5.5.3ʹ����ͼ��ѯ����
--����5-23������ͼv_ stuScore��ѯ�γ�����Ϊ��רҵ�Ρ��ĳɼ���Ϣ
--����5-24�� ����ѧ����ϵ�����༶������ͼv_student������ʾѧ����student�������ֶΣ�
--���༶���ơ�רҵ���ơ�ϵ��������Ϣ��ʹ����ͼv_student��ѯ������������Ϣ
--��ϵ����רҵ���༶��ѧ�š��������Ա𣩣�ʹ����ͼv_student����ͳ�Ƹ�ϵ������Ů��������



--5.5.4�޸���ͼ
Alter View [���ݿ�.][ӵ����.]<��ͼ��> [������1����������n��]
[With Encryption]
As
Select ���
[With Check Option]
--����5-25���޸���ͼv_stuscore��ͨ������ͼ����ʾѧ��ѧ�ڡ�ѧ�š��������γ̺š�
--�γ�������ʦ���ͳɼ���

--5.5.5ɾ����ͼ
--5.5.5��ͼ��Ӧ��
--1��Ϊһ��������ͼ
--����5-27�����ڳɼ���score����2����ͼ���ֱ���ѧ���İٷ��Ƴɼ���ͼ�͵ȼ���
--�ɼ���ͼ��
--2��Ϊ������Ӵ�����ͼ
--����5-28������ѧ���ɼ�������ͼv_scoreDetail������ʾѧ���ɼ���score�������ֶΡ�ѧ��������
--�γ����ơ��༶���ơ�ϵ�����Ƶ���Ϣ������ͼv_scoreDetail��ѯѡ�ޡ�C++������ơ��γ̵�
--����ѧ���ɼ���Ϣ��ϵ�����ơ��༶���ơ�ѧ�š�ѧ���������γ����ơ��ٷ��Ƴɼ�������ѯ
--�������ϵ��������ſγ̵�ѧ��������ƽ���֡���߷֡���ͷ֡�


--3������ת��Ϊ���
--����5-29���ɼ����ݿ��Է������ͼ5-7(a)����ʽ��ʾ���ӡ��������Ҫ����ͼ5-7(b)�ĸ�ʽ
--�г����1������2��ĸ��ſγ̵ĳɼ���
--��1����������ͼ
Create View v_score_c1001
As
Select *
From score
Where course_id='C1001' and student_id like 'SW%'


--��2����ʹ�������ӽ���7����ͼ��ѧ����Ͱ༶������������
Select school_class.name �༶, student.name ����,
		  v_score_C1001.grade Ӣ��,
		  v_score_C1002.grade ��ѧ����,
		  v_score_C2001.grade ����,
		  v_score_C3004.pscore ���ݿ�,
		  v_score_C3005.pscore [C++���1��],
		  v_score_C3006.pscore Java���2��
From student
		 Join school_class on student.school_class_id=school_class.school_class_id
		 Left Join v_score_C1001 on student.student_id=v_score_C1001.student_id
		 Left Join v_score_C1002 on student.student_id=v_score_C1002.student_id
		 Left Join v_score_C2001 on student.student_id=v_score_C2001.student_id
		 Left Join v_score_C3004 on student.student_id=v_score_C3004.student_id
		 Left Join v_score_C3005 on student.student_id=v_score_C3005.student_id
		 Left Join v_score_C3006 on student.student_id=v_score_C3006.student_id
Where student.student_id like 'SW%'

