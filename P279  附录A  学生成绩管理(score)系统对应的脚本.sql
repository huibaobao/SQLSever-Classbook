--P279  附录A  学生成绩管理系统数据表结构
--1、创建数据库、表
create database score
go
use score
go
create table department (						-- 系部表
	department_id varchar(36) not null primary key, 	-- 主键，程序生成的UUID，测试时人工指定
	--department_no varchar(6) not null unique,		-- 学校指定的系部代码
	name varchar(50) not null unique,				-- 系部名称
	remark varchar(500) null					-- 备注
);

create table major (
	major_id varchar(36) not null primary key,		-- UUID主键
	--major_no varchar(12) not null unique,			-- 学校指定的专业代码
	name varchar(50) not null unique,				-- 专业名称
	department_id varchar(36) not null,			-- 所属系部
	remark varchar(500) null
);

create table school_class (						-- 班级表
	school_class_id varchar(36) not null primary key, 	-- UUID主键
	--school_class_no varchar(12) not null unique,		-- 学校指定的班级代码
	name varchar(50) not null unique,				-- 班级名称
	major_id varchar(36) not null,				-- 所属专业
	remark varchar(500) null
);

create table course_type (						-- 课程类别表
	course_type_id varchar(36) not null primary key,	-- UUID主键
	--course_type_no varchar(6) not null unique,		-- 学校指定的课程类别代码
	name varchar(50) not null unique				-- 类别名称
);

create table course (							-- 课程表
	course_id varchar(36) not null primary key,		-- UUID主键
	--course_no varchar(12) not null unique,			-- 学校指定的课程代码（模块号）
	name varchar(50) not null unique,				-- 课程名称
	class_hour tinyint null,						-- 学时
	course_type_id varchar(36) not null,			-- 所属类别
	remark varchar(500) null
);

create table faculty (							-- 教师表
	faculty_id varchar(36) not null primary key,		-- UUID主键
	--account varchar(16) not null unique,			-- 登录帐号（可用工号等）
	password varchar(50) null ,					-- 登录密码
	name char(8) not null,						-- 姓名
	tel varchar(32) null,						-- 电话
	remark varchar(500) null
);

create table ethnicity (
	ethnicity_id char(2) not null primary key,		-- 主键采用国家标准，2字母民族代码
	name varchar(16) not null unique
);

create table region (
	region_id char(6) not null primary key,			-- 主键采用国家标准，6个数字的行政区域代码
	name varchar(20) not null unique
);

create table roll (								-- 学籍类型表
	roll_id varchar(6) not null primary key,			-- 主键，直接采用本系统自定的标准代码
	name varchar(16) not null unique
);

create table student (
	student_id varchar(36) not null primary key,		-- UUID主键
	--studentid char(16) not null,					-- 学号
	--account varchar(16) not null unique,			-- 登录帐号（可以与学号相同）
	password varchar(50) null ,					-- 登录密码
	name varchar(8) null unique,					-- 姓名
	sex char(1) null,							-- 性别
	birthday datetime null,						-- 生日
	admission_date datetime  null,					-- 入学日期
	id_number char(18) null,					-- 身份证号
	home_address varchar(100) null,				-- 家庭地址
	zip_code char(6) null,						-- 邮编
	telephone varchar(32) null,					-- 联系电话
	school_class_id varchar(36) not null,			-- 所属班级
	region_id char(6) not null,					-- 家庭所在省份
	ethnicity_id char(2) not null,					-- 民族
	roll_id varchar(6) not null,					-- 学籍
	remark varchar(500) null
);

create table score (
	score_id varchar(36) not null primary key,		-- UUID主键
	term varchar(10) not null,					-- 学年和学期
	score tinyint null,						-- 成绩（百分制）
	score1 tinyint null,						-- 补考成绩（百分制）
	grade varchar(6) null,						-- 成绩（等级制）
	grade1 varchar(6) null,						-- 补考成绩（等级制）
	course_id varchar(36) not null,				-- 课程ID
	student_id varchar(36) not null,				-- 学生ID
	faculty_id varchar(36) not null,				-- 教师ID
	remark varchar(500) null
);

alter table course add constraint fk_course_course_type
	foreign key (course_type_id) references course_type (course_type_id);

alter table major add constraint fk_major_department
	foreign key (department_id) references department (department_id);

alter table school_class add constraint fk_school_class_major
	foreign key (major_id) references major (major_id);

alter table score add constraint fk_score_course
	foreign key (course_id) references course (course_id);

alter table score add constraint fk_score_faculty
	foreign key (faculty_id) references faculty (faculty_id);

alter table score add constraint fk_score_student
	foreign key (student_id) references student (student_id);

alter table student add constraint fk_student_ethnicity
	foreign key (ethnicity_id) references ethnicity (ethnicity_id);

alter table student add constraint fk_student_region
	foreign key (region_id) references region (region_id);

alter table student add constraint fk_student_roll1
	foreign key (roll_id) references roll (roll_id);

alter table student add constraint fk_student_school_class
	foreign key (school_class_id) references school_class (school_class_id);

create index idx_score on score (term, course_id, student_id);
go

--2、添加记录
insert into department values ('D01','计算机系',null)
insert into department values ('D02','电子系',null)

insert into major values ('SW','软件专业','D01',null)
insert into major values ('NW','网络专业','D01',null)
insert into major values ('MD','多媒体专业','D01',null)
insert into major values ('IT','物联网专业','D02',null)
insert into major values ('ME','微电子专业','D02',null)

insert into school_class values ('SW1031','软件1031','SW',null)
insert into school_class values ('SW1032','软件1032','SW',null)
insert into school_class values ('NW1031','网络1031','NW',null)
insert into school_class values ('IT1021','物联网1021','IT',null)
insert into school_class values ('ME1021','微电子1021','ME',null)

insert into course_type values ('CT01','基础课')
insert into course_type values ('CT02','选修课')
insert into course_type values ('CT03','专业课')

insert into course values ('C1001','大学英语',64,'CT01',null)
insert into course values ('C1002','科学技术基础',64,'CT01',null)
insert into course values ('C2001','打字训练',16,'CT02',null)
insert into course values ('C2002','科普英语',32,'CT02',null)
insert into course values ('C3001','计算机网络技术',80,'CT03',null)
insert into course values ('C3002','网络安全技术',48,'CT03',null)
insert into course values ('C3003','交换与路由',80,'CT03',null)
insert into course values ('C3004','数据库程序设计',80,'CT03',null)
insert into course values ('C3005','C++程序设计',80,'CT03',null)
insert into course values ('C3006','Java程序设计',64,'CT03',null)
insert into course values ('C3007','数字电子技术',64,'CT03',null)
insert into course values ('C3008','微电子制造工艺',80,'CT03',null)

insert into faculty values ('T001','123','高颖','13912341231',null)
insert into faculty values ('T002','123','吴琪琪','13912341232',null)
insert into faculty values ('T003','123','刘伟','13912341233',null)
insert into faculty values ('T004','123','王培林','13912341234',null)
insert into faculty values ('T005','123','李得燕','13912341235',null)
insert into faculty values ('T006','123','史萍','13912341236',null)
insert into faculty values ('T007','123','许荧中','13912341237',null)
insert into faculty values ('T008','123','黄敏','13912341238',null)
insert into faculty values ('T009','123','周可望','13912341239',null)
insert into faculty values ('T010','123','汪德强','13912341230',null)

insert into roll values ('R01','在读')
insert into roll values ('R02','毕业')
insert into roll values ('R03','休学')
insert into roll values ('R04','退学')
insert into roll values ('R05','参军')

insert into ethnicity values ('HA','汉族')
insert into ethnicity values ('MG','蒙古族')
insert into ethnicity values ('ZA','藏族')
insert into ethnicity values ('UG','维吾尔族')
insert into ethnicity values ('ZH','壮族')

insert into region values ('320000','江苏省')
insert into region values ('420000','湖北省')
insert into region values ('340000','安徽省')
insert into region values ('350000','福建省')
insert into region values ('360000','江西省')
insert into region values ('370000','山东省')
insert into region values ('130000','河北省')
insert into region values ('440000','广东省')
insert into region values ('530000','云南省')
insert into region values ('540000','西藏自治区')
insert into region values ('650000','新疆维吾尔自治区')

insert into student values ('SW103101','123','蔡日','F','1990-5-7','2010-8-29','372822199005076000','云南省南涧县长潭河乡洗马坪村6组','211516','05138001498','SW1031','530000','HA','R01',NULL);
insert into student values ('SW103102','123','陈琳','M','1990-2-20','2010-8-28','420922199002200000','安徽省霍邱县乌龙镇铜佛村仓房组','215600','05105003107','SW1031','340000','HA','R01',NULL);
insert into student values ('SW103103','123','程恒坤','F','1989-9-29','2010-8-28','320283198909296000','福建省漳州市平和县坂仔镇广成路南街2号','225001','0520-0005766','SW1031','350000','ZH','R01',NULL);
insert into student values ('SW103104','123','范烨','F','1989-8-12','2010-8-27','320201198908122000','新疆乌鲁木齐市阿勒泰路星河市场10号','214174','5163001852','SW1031','650000','UG','R01',NULL);
insert into student values ('SW103105','123','顾建芳','M','1989-7-13','2010-8-29','320322198907130000','江西省龙南县杨村镇新陂村田心塘18号','224031','13016003062','SW1031','360000','HA','R01',NULL);
insert into student values ('SW103201','123','侯学亮','M','1989-3-18','2010-8-29','340822198903180000','深圳市南山区蛇口花果山招北振兴36栋163市','215626','0510-0064647','SW1032','440000','MG','R01',NULL);
insert into student values ('SW103202','123','霍勇','M','1989-9-5','2010-8-29','32022219890905322X','','215600','0510-0025186','SW1032','360000','HA','R01',NULL);
insert into student values ('SW103203','123','季建龙','M','1990-2-9','2010-8-27','370881199002091000','河北省唐山市迁安县南林桥镇太平村','214426','5102007223','SW1032','130000','HA','R01',NULL);
insert into student values ('SW103204','123','鞠迪','M','1990-5-5','2010-8-27','342623199005058000','江苏省东台市经济园货场东巷23号','215425','5138002609','SW1032','320000','HA','R01',NULL);
insert into student values ('SW103205','123','练德生','F','1989-2-28','2010-8-29','320222198902280000',null,'214016','0511-0051574','SW1032','360000','HA','R01',NULL);
insert into student values ('SW103206','123','刘凯健','M','1990-10-15','2010-8-29','330424199010150000','江苏省兴化市旧县镇旧县村8组','214177','0523-0062395','SW1032','320000','HA','R01',NULL);
insert into student values ('SW103207','123','刘文雪','M','1989-11-14','2010-8-28','320203198911142000','江西省南昌市进贤县钟陵街2号','226200','5153002164','SW1032','360000','HA','R01',NULL);
insert into student values ('NW103101','123','马吉太','F','1989-7-28','2010-8-28','320811198907284000','安徽省滁州市来安县新昌北路18号15室','214064','0515-0051626','NW1031','340000','HA','R01',NULL);
insert into student values ('NW103102','123','欧艳辉','F','1989-6-2','2010-8-29','320831198906021000','江西省上饶市信州区秦峰乡老坞村','226500','025-4001811','NW1031','360000','HA','R01',NULL);
insert into student values ('NW103103','123','齐小芮','F','1989-5-26','2010-8-29','320684198905260000','湖北省汉川市分水镇光3村','214431','0512-0063278','NW1031','420000','HA','R01',NULL);
insert into student values ('NW103104','123','任阳','F','1989-5-3','2010-8-28','320682198905030000','江西省赣州市红旗大道17号','214216','0510-0019592','NW1031','360000','HA','R01',NULL);
insert into student values ('NW103105','123','史坚','M','1989-10-15','2010-8-29','432522198910151000','江西省南昌市进贤县下橰集乡前东大队库下村','225002','0520-0009016','NW1031','360000','HA','R01',NULL);
insert into student values ('NW103106','123','司林','F','1990-5-15','2010-8-29','320204199005153000','江西吉安市吉安县敦厚镇厚丰村','214191','0511-0037702','NW1031','360000','HA','R03',NULL);
insert into student values ('NW103107','123','宋明','M','1989-5-28','2010-8-29','413026198905284000','山东省招远市大秦家镇水口村','215633','0519-0092926','NW1031','370000','HA','R01',NULL);
insert into student values ('IT102101','123','孙成浩','M','1989-6-24','2010-8-29','410882198906241000','江苏南京六合县高桥镇耿家田夏家田8组','221000','0512-00832968','IT1021','320000','HA','R01',NULL);
insert into student values ('IT102102','123','王俊峰','M','1989-4-22','2010-8-29','362424198904222000','西藏堆龙德庆县河东村','211215','0519-0068231','IT1021','540000','ZA','R01',NULL);
insert into student values ('IT102103','123','王明星','F','1989-4-9','2010-8-28','320283198904095000','湖北咸宁市通山县南林桥镇太平村','211135','025-3001426','IT1021','420000','HA','R01',NULL);
insert into student values ('IT102104','123','王秋静','M','1990-9-15','2010-8-29','320222199009150000','湖北省宣恩县长潭河乡洗马坪村6组','215101','0511-0038858','IT1021','420000','HA','R01',NULL);
insert into student values ('IT102105','123','王一军','F','1989-4-1','2010-8-28','320212198904010000','江苏省宜兴市王家畈乡龙潭河村3组','211316','0510-0013229','IT1021','320000','HA','R01',NULL);
insert into student values ('IT102106','123','王志超','M','1989-7-1','2010-8-27','320283198907014000','江苏徐州市沛县松木坪镇泉水垱村7组','211302','0514-0098224','IT1021','320000','HA','R01',NULL);
insert into student values ('ME102101','123','王希','M','1990-9-15','2010-8-29','32022219900915057x','江苏省姜堰曹市镇向前村3组','210016','025-7000476','ME1021','320000','HA','R05',NULL);
insert into student values ('ME102102','123','吴青','M','1989-5-9','2010-8-28','513721198905090000','江西省吉安市万安县潞田镇楼下村','214135','0512-00583378','ME1021','360000','HA','R01',NULL);
insert into student values ('ME102103','123','夏习瑞','M','1989-5-18','2010-8-27','320203198905180000','江苏省淮安市邓村乡黄金河村12组','212325','0514-0014968','ME1021','320000','HA','R01',NULL);
insert into student values ('ME102104','123','徐祥','M','1989-8-3','2010-8-29','36042119890803081X','山东省枣庄市台儿庄区马兰镇万庄村298号','215431','0510-0042852','ME1021','370000','HA','R01',NULL);
insert into student values ('ME102105','123','徐亚祥','F','1989-4-21','2010-8-29','320822198904210000','江苏宜兴市净潭乡荷花池村','214174','0515-0059753','ME1021','320000','HA','R01',NULL);

insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('33AB3F2D-6D1B-46B1-8ED1-278FFDCE0EB2','10-11(II)',32,60,'C3003','NW103103','T002');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('549F6A74-ABFC-490A-8C9E-9463C7C2AC8D','10-11(I)',53,58,'C3001','NW103103','T001');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('8F1072F5-A515-4C54-BE44-9DBC3C87044C','10-11(II)',53,NULL,'C3004','SW103207','T009');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('EF26245D-8E0D-4AD8-9624-E82289318C57','09-10(I)',37,60,'C2001','SW103105','T008');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('55049D72-6CB7-4853-91CA-EC790C557925','09-10(II)',54,61,'C1002','SW103103','T010');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('F1EB8A83-63A1-4465-9FD6-5CDF75CC81B3','10-11(II)',54,60,'C3008','ME102105','T003');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('F688A006-11DB-475F-9BDB-73C94D8AC864','09-10(II)',54,55,'C2002','SW103104','T007');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('2A0F9505-5E76-44B5-9FD0-A23357A856AC','09-10(II)',55,62,'C2002','NW103104','T007');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('F580DF27-DBA2-4894-AC87-8810F544623A','10-11(II)',55,NULL,'C3003','NW103104','T002');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('FF717142-57F6-40A9-AEBA-3B7D27E2F333','10-11(II)',43,60,'C3004','SW103206','T009');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('2015FFA5-5254-4099-9108-44C3AD4E6559','09-10(I)',56,54,'C1001','SW103105','T007');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('2D856597-E76F-4A08-8956-A048BCBAB088','09-10(I)',56,60,'C1001','SW103205','T007');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('3155C879-11E5-44FD-90F0-8AD9A591B94A','09-10(II)',56,60,'C1002','NW103104','T010');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('3E7DC00F-9C07-4EC8-A5E0-A532F550F801','09-10(II)',56,61,'C1002','NW103105','T010');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('4003CCE6-0392-4463-939F-C27A61683C9D','10-11(II)',57,51,'C3004','SW103203','T009');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('F4E3638E-C68B-4C29-A065-BE8F6FA06889','09-10(II)',57,62,'C2002','ME102102','T007');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('99FE7717-E45D-4857-8035-5B68A751DD40','10-11(II)',NULL,86,'C3002','NW103105','T002');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('2356F348-4023-4B7B-B9CE-CB099C4F2E7D','09-10(I)',59,61,'C2001','SW103102','T008');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('27018494-84D4-42E3-A985-0B776E04063C','09-10(II)',59,62,'C1002','NW103102','T010');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('4877925F-469D-4876-B214-39FB7AB528C6','09-10(I)',59,60,'C2001','SW103104','T008');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('54EDDCA4-1792-4E7E-9E1E-F1EAA7D1BB73','09-10(I)',60,NULL,'C1001','SW103103','T007');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('3731E119-61F9-4FB3-A5EF-D3502E4B750D','10-11(I)',61,NULL,'C3007','ME102104','T006');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('3746986B-F0CE-488B-8315-DACF67786736','09-10(II)',61,NULL,'C1002','SW103104','T010');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('6754F534-EDC4-422A-A5FA-0AE23EC72268','09-10(II)',62,NULL,'C1002','SW103204','T010');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('6E4E944F-E689-460B-BFF6-8361624DF015','10-11(II)',62,NULL,'C3003','NW103102','T002');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('8298097A-9729-40B5-B626-1201D1696317','09-10(I)',62,NULL,'C1001','NW103107','T007');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('9F60B847-3D5C-4A39-A4E1-71882F103503','09-10(II)',62,NULL,'C1002','SW103205','T010');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('AADBFE59-3CFF-4615-9747-6F9A1C95369A','10-11(II)',62,NULL,'C3008','ME102104','T003');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('D4004E16-82E5-4A6D-ADC7-17458D513558','10-11(II)',62,NULL,'C3003','NW103107','T002');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('60CF9F85-1CEB-4D98-8BB3-17E3A87173D6','10-11(I)',63,NULL,'C3001','NW103107','T001');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('A9D6BF6F-9849-4973-B4DA-F710051C8A19','09-10(I)',63,NULL,'C2001','SW103103','T008');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('08CFCC81-8FBC-483E-862F-B7CAAD815D50','09-10(I)',65,NULL,'C1001','SW103201','T007');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('5247423D-1DBD-4458-B2B0-9F1A88E00EA5','10-11(I)',65,NULL,'C3001','NW103102','T001');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('89758F01-906A-4419-8143-EC646055756C','10-11(II)',65,NULL,'C3006','SW103201','T005');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('D330EFF0-B864-483D-B684-A50E2A27ABEE','09-10(I)',65,NULL,'C1001','ME102104','T007');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('E014A4E0-C427-414B-928B-7565F40F8747','09-10(II)',65,NULL,'C2002','ME102103','T007');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('20820701-FCB1-4C8F-A730-B0A0BD909690','09-10(I)',66,NULL,'C2001','SW103203','T008');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('3D2D1252-1DD6-48E3-AA38-81A94EC374DD','10-11(I)',66,NULL,'C3001','NW103105','T001');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('639A9B7D-B969-4F64-8E38-E5CDE4DF96D5','09-10(I)',66,NULL,'C1001','NW103101','T007');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('AE5712F8-7B68-459D-8E62-F05D734F3A4E','10-11(II)',66,NULL,'C3004','SW103101','T009');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('0CCEC038-8C43-4DA1-A7B7-F49DAF8EAAA0','10-11(I)',67,NULL,'C3005','SW103105','T004');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('18A9764F-31F1-4BEA-8E91-D3E7D09B03C0','10-11(I)',67,NULL,'C3001','NW103101','T001');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('6AABEB14-0FD0-4B04-92AC-3F62CE6C204E','09-10(II)',67,NULL,'C1002','SW103101','T010');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('8AC0CDC5-BEF2-4D76-9D4D-C9A070248F8A','09-10(II)',67,NULL,'C1002','SW103105','T010');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('E25118D7-DB38-4775-ABC5-5BCCB2D505D0','09-10(II)',67,NULL,'C1002','SW103207','T010');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('30884C29-E334-4C59-8C93-BCA863E3A6E1','09-10(II)',68,NULL,'C1002','SW103102','T010');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('92851DC0-FC61-4462-818D-07A8E80892C3','09-10(II)',69,NULL,'C1002','NW103103','T010');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('E4DC2BAA-DB81-4A9C-BA2A-E4A47D390B0A','09-10(I)',69,NULL,'C1001','ME102103','T007');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('0D79B3B6-CCA8-4FB8-AE36-C11CEEBBDCFD','09-10(I)',70,NULL,'C2001','SW103204','T008');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('6EEA5229-3328-4F43-A56F-CFD81D748246','10-11(II)',70,NULL,'C3004','SW103105','T009');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('CED478A7-2E7A-45BA-A181-395325130669','09-10(I)',70,NULL,'C2001','SW103201','T008');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('F8D1A453-604F-4A72-B547-708250BBB7C0','09-10(I)',71,NULL,'C2001','SW103202','T008');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('1E3279BA-E478-4E26-9DE6-9688282C9A53','09-10(I)',72,NULL,'C1001','ME102102','T007');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('2AB3CA42-8825-4C83-A26D-7423F2D2FA8C','09-10(I)',72,NULL,'C1001','ME102105','T007');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('4BE49773-11AC-4FC7-BEC2-DFC5534EDA68','09-10(I)',72,NULL,'C2001','SW103101','T008');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('66126762-CC34-4CFB-80B8-EAED2C12857A','10-11(II)',72,NULL,'C3004','SW103204','T009');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('5E8D750A-F420-4FE8-A5AA-8FAEFFF220AE','10-11(II)',73,NULL,'C3002','NW103107','T002');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('F27DF8AD-30E3-4C6B-B0B1-C75CBE66DF15','09-10(II)',75,NULL,'C2002','SW103204','T007');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('6A7106BA-9F28-4F21-B4DA-C51E3101D520','10-11(I)',76,NULL,'C3007','ME102102','T006');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('97235681-4A0A-4194-9704-92B43E364CE8','09-10(I)',76,NULL,'C1001','SW103203','T007');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('F303555F-1792-4894-B780-C2C3546B7FC9','10-11(II)',77,NULL,'C3002','NW103102','T002');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('99FA0939-F1DA-4812-8084-7047F8C7F955','10-11(II)',78,NULL,'C3003','NW103105','T002');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('CFC3C083-BE7A-49F5-8C8D-422CE0D89846','09-10(I)',78,NULL,'C1001','NW103105','T007');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('5035FFB7-7424-44CE-877E-0BF8B1B281D8','10-11(II)',79,NULL,'C3004','SW103102','T009');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('52B197D6-7233-41A1-A663-A5D96C8997DD','09-10(II)',79,NULL,'C1002','SW103201','T010');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('658770F2-FAEE-449D-95FB-895CBCE549B0','09-10(I)',79,NULL,'C2001','SW103207','T008');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('173A8B59-3429-4281-B23E-A833F6BCCF3D','09-10(II)',80,NULL,'C1002','ME102102','T010');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('95457627-0728-41A3-9859-AB5D2B47C069','09-10(I)',80,NULL,'C1001','SW103206','T007');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('B3A97E32-4367-410B-8004-9A816443F205','09-10(I)',80,NULL,'C1001','NW103103','T007');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('B9B10F21-53B3-4690-9C70-76869E14ABA2','10-11(II)',80,NULL,'C3004','SW103104','T009');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('CE8D669D-3C6B-4439-B358-7A1DC6A7C2E5','09-10(I)',80,NULL,'C1001','SW103102','T007');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('F39EC5E7-3D3A-4361-8A49-83D961D1E1EF','09-10(II)',80,NULL,'C1002','ME102103','T010');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('34AC4996-E18B-43AA-8AD3-6FB23B2CC618','09-10(I)',81,NULL,'C2001','SW103205','T008');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('599991B2-09F0-49B2-B098-56E5C5364A71','09-10(II)',81,NULL,'C2002','NW103101','T007');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('CD017716-6A37-4F68-88A2-2506402036F5','09-10(I)',81,NULL,'C1001','SW103204','T007');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('B95DCBFE-7A76-44F4-94F1-162F3D5ABB1B','10-11(I)',82,NULL,'C3005','SW103101','T004');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('C676886E-0F19-47D1-80DC-5B4BD619BF81','10-11(II)',82,NULL,'C3002','NW103103','T002');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('25828406-45C4-4012-AD64-81A62FF76393','09-10(II)',83,NULL,'C1002','ME102104','T010');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('256F045A-3A2D-46E7-BB9F-64C8138DE83B','10-11(II)',84,NULL,'C3006','SW103204','T005');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('E52249A2-BB76-4FD5-922D-032D179A8D6B','10-11(II)',84,NULL,'C3006','SW103202','T005');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('DA3A0AD6-9797-4E0A-B611-9E02A844CBCA','09-10(II)',85,NULL,'C1002','SW103203','T010');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('DA6EFFFE-ED3D-42D8-AC13-CE200B205033','10-11(II)',85,NULL,'C3006','SW103203','T005');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('FED8A9FD-A3B8-453C-B790-7C03118E441E','10-11(II)',85,NULL,'C3006','SW103206','T005');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('042AC4D4-0EAD-40C5-A1F1-918DF02DA8EC','10-11(I)',86,NULL,'C3005','SW103103','T004');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('73A592C5-CE5A-428B-9BBB-82DF1C3ADEF2','09-10(II)',86,NULL,'C1002','SW103202','T010');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('0F493094-CD79-48AF-A158-A8160E749957','10-11(II)',87,NULL,'C3003','NW103101','T002');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('7493740A-2E7E-4D93-9B6B-98D46CC8D060','09-10(II)',87,NULL,'C1002','ME102105','T010');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('9CE466F1-0BAE-4A9E-91DF-D8EB22E50069','09-10(I)',87,NULL,'C2001','SW103206','T008');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('CDFBDF7E-EDD7-4BEA-9F44-EBD9892C6122','10-11(II)',87,NULL,'C3004','SW103205','T009');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('7F9D3965-3D04-46A6-B2E0-7ECFD3A415D0','10-11(II)',88,NULL,'C3006','SW103207','T005');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('E7692D2F-D099-4D68-A985-92D38D563C7F','10-11(I)',88,NULL,'C3007','ME102105','T006');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('0587D749-DB51-43F5-9629-B9C5ED689840','09-10(II)',89,NULL,'C1002','SW103206','T010');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('6703C119-7316-44EE-A2AD-C5613541E7D0','10-11(I)',89,NULL,'C3007','ME102103','T006');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('C5C584D9-B4DF-4A85-9F08-4A7C5831FE48','10-11(II)',89,NULL,'C3006','SW103205','T005');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('27731D17-6EFD-465D-A400-EBE927CC61FC','10-11(I)',90,NULL,'C3005','SW103104','T004');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('A27ED42A-A88D-45C4-9F80-F90DAF50C65B','10-11(II)',90,NULL,'C3002','NW103104','T002');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('16D21957-F88A-4819-A3DC-C1D01341E86D','10-11(I)',91,NULL,'C3001','NW103104','T001');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('2CFA88B6-8EBF-427F-84D7-E305DB4D7F1C','09-10(I)',91,NULL,'C1001','NW103104','T007');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('7F030B76-6ADB-4B13-9C4C-E2D1ACD3D149','09-10(II)',91,NULL,'C1002','NW103101','T010');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('92782DEE-F787-495A-A53E-1A4093315711','09-10(II)',91,NULL,'C1002','NW103107','T010');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('F95CBBCB-D37D-4DAD-86AA-96F003CD8521','10-11(II)',91,NULL,'C3008','ME102102','T003');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('00F63D7D-F90A-4D09-9EC7-A7CEFA5EFC4C','09-10(II)',92,NULL,'C2002','SW103203','T007');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('08F0AA82-1054-40D8-AFB1-A0A8636AAFB8','09-10(I)',92,NULL,'C1001','SW103207','T007');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('1F2040D0-17A0-4EDB-90D0-468B7F612947','10-11(II)',92,NULL,'C3002','NW103101','T002');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('B28B6750-4108-42C2-87D8-EB0901F6406F','09-10(I)',92,NULL,'C1001','SW103202','T007');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('5BC317E6-3DF1-4776-94A1-68F7313D581A','09-10(I)',93,NULL,'C1001','NW103102','T007');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('8C4B77CB-7C0F-4B0E-939F-5C5B290E52EF','09-10(I)',93,NULL,'C1001','SW103104','T007');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('0E5E88E3-B82D-49A0-8025-8015AE92E5AD','10-11(I)',94,NULL,'C3005','SW103102','T004');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('112FF5B7-6144-4663-BF3B-B296D6510BDA','10-11(II)',94,NULL,'C3008','ME102103','T003');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('42A7B808-97F6-43CE-BC67-1050C1A6227D','10-11(II)',94,NULL,'C3004','SW103103','T009');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('7DD5D39B-39E9-4417-BAC7-D08CB41C6D43','09-10(I)',94,NULL,'C1001','SW103101','T007');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('90A3C754-15B9-4474-9E41-44FBA3D63D89','10-11(II)',95,NULL,'C3004','SW103201','T009');
insert into score (score_id, term, score, score1, course_id, student_id, faculty_id) values ('9C9A31DE-C4E3-4DC4-8D7B-F90BE0C2567D','10-11(II)',97,NULL,'C3004','SW103202','T009');
go
