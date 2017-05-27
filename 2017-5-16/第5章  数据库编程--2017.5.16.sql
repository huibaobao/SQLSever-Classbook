--��5��  ���ݿ���
��ϰ
--5.1 ���������̿������
--5.2 �ű��ļ�
--5.3 �α�

�¿�
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
With Encryption
As
Select term,student.student_id ѧ��,student.name ����, 
course.course_id �γ̺�,course.name �γ���, 
course_type.name �γ������,pscore �ɼ�
From student 
Join score on student.student_id=score.student_id
Join course on course.course_id=score.course_id
Join course_type on course_type.course_type_id=course.course_type_id


--����5-23������ͼv_ stuScore��ѯ�γ�����Ϊ��רҵ�Ρ��ĳɼ���Ϣ��


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
--ʹ����ͼv_student����ͳ�Ƹ�ϵ������Ů������
Select ϵ������, �༶����,sex �Ա�,Count(*) ѧ������
From v_student 
Group By ϵ������, �༶����,sex 

.2 �޸���ͼ
Alter View [���ݿ�.][ӵ����.]<��ͼ��> [������1����������n��]
[With Encryption]
As
Select ���
[With Check Option]
--����5-25���޸���ͼv_stuscore��ͨ������ͼ����ʾѧ��ѧ�ڡ�ѧ�š�������
--�γ̺š��γ�������ʦ���ͳɼ���
Alter View v_score
As		
Select term,student.student_id ѧ��,student.name ����, 
course.course_id �γ̺�,course.name �γ���, 
faculty.name ��ʦ��,pscore �ɼ�
From student 
Join score on student.student_id=score.student_id
Join course on course.course_id=score.course_id
Join faculty on faculty. faculty_id=score.faculty_id


--5.4.3 ɾ����ͼ
--����5-26��ɾ�����е�v_stuscore��ͼ��

--5.4.4 ��ͼ��Ӧ��
--1��Ϊһ��������ͼ
--����5-27�����ڳɼ���score����2����ͼ���ֱ���ѧ���İٷ��Ƴɼ���ͼ�͵ȼ��Ƴɼ���ͼ��
Create View v_score 		--�ٷ��Ƴɼ���ͼ
As
Select score_id,term,pscore,pscore1,course_id,student_id,faculty_id,remark
From score
Where pscore is not null
Go
Create View v_grade 		--�ȼ��Ƴɼ���ͼ
As
Select score_id,term,grade,grade1,course_id,student_id,faculty_id,remark
From score
Where grade is not null


--2��Ϊ������Ӵ�����ͼ

����5-28������ѧ���ɼ�������ͼv_scoreDetail������ʾѧ���ɼ���score�������ֶΡ�
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


--��2��ʹ����ͼv_scoreDetail��ѯѡ�ޡ�C++������ơ��γ̵�����ѧ���ɼ���Ϣ��


--��3��ʹ����ͼv_scoreDetail��ѯ�����ϵ������ſγ̵�ѧ��������ƽ���֡�
--��߷֡���ͷ֣������༶��γ�����


--3������ת��Ϊ���
--����5-29���ɼ����ݿ��Է������ͼ5-7(a)����ʽ��ʾ���ӡ��������Ҫ����
--ͼ5-7(b)�ĸ�ʽ�г����1������2��ĸ��ſγ̵ĳɼ���

