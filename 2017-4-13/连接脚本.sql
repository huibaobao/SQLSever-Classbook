create database test
go
use test
go
create table R1(学号 char(6) not null primary key,
                  姓名 char(4),
				  年龄 int)
go
create table R2(学号 char(6) not null primary key,
                  姓名 char(4),
				  成绩 int)
go
insert into R1 values('950101','赵平',20)
insert into R1 values('950102','钱丽',21)
insert into R1 values('950103','王平',20)
insert into R1 values('950104','李明',19)
insert into R1 values('952005','周英',21)
go
insert into R2 values('950101','赵平',95)
insert into R2 values('950102','钱丽',97)
insert into R2 values('950103','王平',87)
insert into R2 values('950104','李明',83)
insert into R2 values('950105','周瑛',90)
go

