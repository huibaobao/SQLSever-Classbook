use  score
go

--P106  ϰ�� 4
--����ϰ���У��漰�����ݲ�ѯ����ο���¼Aѧ���ɼ�����ϵͳ���ݱ�ṹ�� 
--6����дSelect��䣬��ѯѧ�����е�ѧ�š��������Ա��С�
select name ����,
		student_id ѧ��,
		sex �Ա�
from student
go

--7����дSelect��䣬�ڳɼ���score�в�ѯѧ�š��γ̴��롢ѧ���ѧ�ڡ��ɼ����ٷ��ƣ��������ú�����ʾ��
select student_id ѧ��,
		course_id �γ̴���,
		term ѧ��ѧ�� ,
		score �ɼ�
 from score
 go

--8����дSelect��䣬�ڳɼ���score�в�ѯ�ٷ��Ʋ����ɼ�ǰ5����ѧ��ѧ�źͰٷ��Ʋ����ɼ���
select top(5) 
		score1 �����ɼ�,
		student_id ѧ��
		from score
		order by score1 desc
go

--9����дSelect��䣬��ѯ����ϵ������Ϊ��30����רҵ��Ϣ������רҵ��ź�רҵ���ơ�

select major_id רҵ���,
		name רҵ����
from major
	where department_id like '30'
go


--10����дSelect��䣬�ӳɼ����в�ѯ���ȼ��ɼ�Ϊ�����㡱�������á����еȡ���ѧ��ѧ�š��γ̱���͵ȼ��ɼ���
update score
	set grade = 
		case  
			when score>=90 then '����'
			when score>=80 then '����'
			when score>=70 then '�е�'
			when score>=60 then '����'
			when score<60 then '������'
		end

select student_id ,course_id,grade from score
	where grade not in('����','������')
		group by grade,student_id,course_id
			order by grade desc
go

--11����дSelect��䣬��ʾ�γ̱��еĿγ̱�š��γ����ơ�ѧʱ��ѧ�֣�����Ϊ�����У�ѧ��=ѧʱ/16����ʹ�ñ�����Course_Num����ʶ�������С���ѯ�����ѧʱ�ɸߵ������С�

select course_id ,name,class_hour, class_hour/16 Course_Num
	
from course
	order by class_hour asc
go

--12�� ��дSelect��䣬��ѯ��������δ��ѧʱ����ѧʱΪ�գ��Ŀγ���Ϣ�������γ̱�źͿγ����ơ�
select course_id ,name from course
	where class_hour is null;
go

--13����дSelect��䣬��ѯ���γ̱��е����б�ţ�Course_Id����ǰ�����ַ�Ϊ��C1���Ŀγ���Ϣ����ʾ�γ̱�š��γ����ƺ�ѧʱ��
select course_id,name,class_hour from course
	where course_id like '%C1'
go

--14����дSelect��䣬��ѯ1988���ϰ���ǰ��1��1�յ�6��30�գ�������ѧ����Ϣ������ѧ�š��������༶����


--15����дSelect��䣬��ѧ����student��ͳ�Ƹ��༶����Ů��������
select count(sex) ,school_class_id from student where sex='M'
	group by school_class_id
union
select count(sex) ,school_class_id from student where sex='F'
	group by school_class_id		

--16����дSelect��䣬ͳ�Ƴ��ɼ����и���ѧ���İٷ��Ƴɼ���ƽ���֣�Ҫ����ʾѧ�š�ƽ���֡�

--17����дSelect��䣬��ѯ�ɼ����аٷ��Ƴɼ�ƽ���ֵ���70��ѧ��ѧ�š�
