--��4�� ���ݲ�ѯ  ��ϰ��
--��2017.4.27��
--�ο��̲�  ��¼A  ѧ���ɼ�����ϵͳ���ݱ�ṹ

--һ���򵥲�ѯ��
--1.	��ѯ�����У���ʾѧ����Ϣ��student������ѧ���ļ�¼��
--2.	��ѯָ���У���ʾѧ����Ϣ��student������ѧ����student_id��name��sex��
--3.	�ڲ�ѯ��ʹ���б�������ʾѧ����Ϣ��student������ѧ����student_id������Ϊѧ�ţ���name������Ϊ��������birthday������Ϊ�������ڣ���
--4.	ʹ��TOP��PERCENT���Ʒ�����������ʾstudent����ǰ3����¼��student_id��name��birthday�ֶΡ�
--5.	ʹ��Distinct�����ظ����У���ʾѧ���ɼ���score��ѡ���˿γ̵�ѧ��ѧ�š�
--6.	�ڲ�ѯ��ʹ�þۺϺ�����sum��avg ��max��min������ѧ���ɼ���score�в�ѯ��ʾ�ܳɼ���ƽ���ɼ�����߷ּ���ͷ֡�
--7.	��count������ʾѧ���ɼ���score�м�¼����
--8.	INTO�Ӿ䣺��ѯ��ʾstudent����������ѧ������Ϣ�����γ��±�student_info������ʾ����fromǰ�����into student_info�Ӿ䣬ˢ�����ݿ⣬�ῴ������һ���������ָ��·������·����Դ����ͬ����
--9.	Where�Ӿ䣬��ʹ�ñȽ����������ѯ��ʾѧ���ɼ���score�гɼ���80�ּ����ϵ�ѧ����¼��
--10.	Where�Ӿ䣬��ʹ��between�ؼ��֣���ѯ��ʾѧ����Ϣ��student�г���������1989��1��1����1990��12��31��֮���ѧ����¼��
--11.	ʹ��LIKE�ؼ��֣�ģ����ѯ������ѧ����Ϣ��student�в�ѯ��ʾ����������ѧ����Ϣ��
--12.	Group by�Ӿ䣺ͳ�Ƴɼ���score�в�ͬ�γ̵�ƽ���֡�
--13.	ͳ��ѧ���ɼ���score��ÿ��ѧ�����ܳɼ���ƽ���ɼ���
--14.	Having�Ӿ䣺��ʾѧ���ɼ���score��ƽ���ɼ���70�ּ����ϵ�ѧ����ѧ�ź�ƽ���ɼ���
--15.	��ʾѧ���ɼ���score��ѡ�޿γ̳���2�ţ����ҳɼ�����70�����ϵ�ѧ����ѧ�š�
--16.	Order by�Ӿ䣺��ʾѧ���ɼ���score��ÿ��ѧ����ѧ�ż�ƽ���ɼ�������ƽ���ɼ���������

--����������Ӳ�ѯ��
--1.	�����ӣ���ѯ��ʾ���вμ��˿��Ե�ѧ����ѧ�š��������γ̱�ż����Գɼ���
--2.	�������ӣ�ͳ������ѧ���Ŀ��������Ҫ����ʾ���вμӿ��Ե�ѧ����ѧ�š��������γ̱�źͿ��Գɼ���û�вμӿ��Ե�ѧ��ҲҪ��ʾ������
--3.	�������ӣ�ͳ�����пγ̵�ѡ�������Ҫ����ʾ���пγ̱�š����Գɼ������п���Ŀγ����ơ�

--�����Ӳ�ѯ��
--1.  ʹ�ñȽ����������ѯѧ����Ϣ��student������ȡ����ա����ѧ����Ҫ����ʾ��Щѧ������Ϣ��

select * from student
where	birthday<(select birthday from student	where name='����')
go

--2.	ʹ��IN����ѯ���вμ��˿��Ե�ѧ��������
/*select stu.name,sc.score from student stu,score sc
where sc.student_id=stu.student_id
	and stu.student_id in (select student_id from score
			where score is not NULL)
go*/

select stu.name from student stu
where stu.student_id in (select student_id from score
			where score is not NULL)
go


--3.	ʹ��Exists����ѯ��ʾѡ����C1001�γ̵�����ѧ����������
select stu.name from student stu
where exists 
	(select * from score sc where course_id='C1001'
	and	stu.student_id=sc.student_id)
