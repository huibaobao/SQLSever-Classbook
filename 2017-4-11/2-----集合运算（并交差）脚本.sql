create database test
go
use test
go
create table R1(ѧ�� char(6) not null primary key,
                  ���� char(4),
				  ���� int)
go
create table R2(ѧ�� char(6) not null primary key,
                  ���� char(4),
				  ���� int)
go
insert into R1 values('950101','��ƽ',20)
insert into R1 values('950102','Ǯ��',21)
insert into R1 values('950103','��ƽ',20)
insert into R1 values('950104','����',19)
insert into R1 values('952005','��Ӣ',21)
go
insert into R2 values('950101','��ƽ',20)
insert into R2 values('950102','Ǯ��',21)
insert into R2 values('950103','��ƽ',20)
insert into R2 values('950104','����',19)
insert into R2 values('950105','����',21)
go

