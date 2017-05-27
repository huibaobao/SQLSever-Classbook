--���ݲ�ѯ��䣨Select�������ṹ
--���һ���ʽ����:
/*Select   [All | Distinct]  <Ŀ����ʽ1> [������n]
**From  <���� | ��ͼ��> [������n]
**[Where  <�������ʽ>]
**[Group  By  <���ʽ�б�> ]
**[Having  <�������ʽ> ] 
**[Order  By  <���ʽ>  [Asc | Desc] ]
*/
use score
go

--�򵥲�ѯ
--��1��Select��From�Ӿ�
--һ��ѡ��ȫ����
--����4-1����ѯѧ����������Ϣ��
select * from student
go
--����ѡ��ָ����
--����4-2����ѯѧ�����������Ա�ͳ������ڡ�
select name,sex,birthday from student
go

--����ʹ�ü�����
--����4-3����ѯѧ�����ѧ�š��������Ա�����䡣
select student_id,name,sex,year(getdate())-year(birthday) as age from student
go

--�ġ�Ϊ��ָ������

--����4-4����ѯѧ����ѧ�š��������Ա�����䣬�����ı�����ʾ�ֶ�����
select student_id	ѧ��,
		name	����,
		sex		�Ա�,
		year(getdate())-year(birthday) ����
	from student
go

--�塢�����ظ�����
--����4-5������ѧ�����ѯ�༶��š�

select distinct school_class_id from student
go

--����������ѡ�񲿷���
--����4-6����ѯ�ɼ����аٷ��Ƴɼ���ߵ�ǰ3�С�
select top 3 score from score
	order by score desc
go


--��2��Where�Ӿ�
--һ����ϵ���ʽ
--����4-7����ѯ������ͬѧ�������͵绰��

select name,telephone from student
	where sex='M'
go

--����4-8����ѯ�������21���ѧ����ѧ�š��������Ա�����䡣
select student_id	ѧ��,
		name	����,
		sex		�Ա�,
		year(getdate())-year(birthday) ����
	from student where year(getdate())-year(birthday)>21
go

--����4-9����ѯ������ٷ��Ƴɼ�����ԭ���԰ٷ��Ƴɼ���ѧ��ѧ�ź�2�ο��Եĳɼ���
select student_id ѧ��,
		score ���Գɼ�,
		score1	�����ɼ� from score
	where score1<score
go

--������Χ��ѯ
--����4-10����ѯ�ٷ��Ƴɼ���80����95�ֵ�ѧ��ѧ�š��γ̺źͳɼ�������80�ֺ�95�֣���
select student_id ѧ��,
		course_id �γ̺�,
		score �ɼ�
	from score where score between 80 and 95
go


--����4-11����ѯ���䲻��21��23֮���ѧ����Ϣ������ѧ�š��������Ա�����䡣
select student_id	ѧ��,
		name	����,
		sex		�Ա�,
		year(getdate())-year(birthday) ����
	from student where year(getdate())-year(birthday) 
						not between 21 and 23
go


--�������ϲ�ѯ
--����4-12����ѯ�ȼ��ɼ����š������е�ѧ��ѧ�š��γ̺źͳɼ���
		  --���ڵȼ��Ƶĳɼ��ǲ������ģ�����Ӧ��ʹ�ü��ϲ�ѯ��

update score 
	set grade=
		case
			when score>=90 then '��'
			when score>=80 then '��'
			when score>=70 then '��'
			when score>=60 then '����'
			when score<60	then '������'
		end
select * from score
go

select student_id ѧ��,
		course_id �γ̺�,
		score �ɼ�,
		grade �ȼ�
	from score
	where grade in('��','��','��')
go

--�ġ�ģ����ѯ
--����4-13����ѯ��������ѧ��
select name ���� from student
	where name like '��%'
go

--����4-14����ѯ�����е�2����������־�򽨵�ѧ����
select name ����
	from student
	where name like '_[��־��]%'  --�˴�����������ʽ
go

--�塢�߼����ʽ
--����4-15����ѯ�ɼ�����60�ֻ򲻼����ѧ��ѧ�š�
select student_id ѧ��,
		course_id �γ̺�,
		score �ɼ�,
		grade �ȼ�
	from score
	where score<60 or grade='������'
go
--������ֵ�ж�
--����4-16����ѯ�ٷ��ƿ��Գɼ�С��60�֣��Ҳμӹ������������ٷ��Ƴɼ���Ϊ�գ���ѧ���ɼ���Ϣ��
select * from score
	where score<60 and score1 is not null
go


--����4-17����ѯ�γ̱����C3��ʼ����ȱ�����ٷ��ƿ��Գɼ�Ϊ�գ���ѧ���ɼ���Ϣ��
select * from score
	where course_id like 'C3%'
		and score is null
go

--��3��Order by�Ӿ�
--����4-18����ѯ�ɼ����пγ̱����C3��ʼ��ѧ���ɼ���Ϣ������ѧ�š��γ̺źͰٷ��Ƴɼ���Ҫ���Ȱ��γ̺���������Ȼ�󰴳ɼ��Ӹߵ��ͽ�������
select student_id ѧ��,
		course_id �γ̺�,
		score �ɼ�
		from score
	where course_id like 'C3%'
	order by course_id  
go
--��4��Group by�Ӿ�
--����4-19��ͳ��ѧ����������

--����4-20��ͳ��ѧ���ĳɼ������

--����4-21������ͳ��ѧ�����и����༶����Ů��������

--����4-22��ͳ�Ƴɼ����и��ſγ̰ٷ��Ƴɼ���ƽ���֡���߷ֺ���ͷ֡�

--����4-23��ͳ�Ƴɼ����и��ſγ��м���ѧ���İٷ��Ƴɼ���ƽ���֡���߷ֺ���ͷ֡�

--����4-24��ͳ�Ƴɼ����и��ſγ��м���ѧ���İٷ��Ƴɼ���ƽ���֡���߷ֺ���ͷ֣�Ҫ����ʾƽ���ֳ���75�ֵ�ͳ�Ƽ�¼��������ѯ�����ƽ���ִӸߵ�������

--��5�����ϲ�ѯ
--һ�����ϲ�����
--����4-25����ѯϵ�����е�ϵ�����ƺ�רҵ���е�רҵ���ơ�
--�������Ͻ�����
--����4-26����ѯ��ѡ���ˡ�C3001���γ���ѡ���ˡ�C3002���γ̵�ѧ����ѧ�š�



--�������ϲ�����
--����4-27����ѯѡ���ˡ�C3001���γ̵���û��ѡ�� ��C3002���γ̵�ѧ����ѧ�š�

