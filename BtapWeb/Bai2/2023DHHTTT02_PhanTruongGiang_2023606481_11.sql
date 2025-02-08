use master
go
create database MarkManagement
go
use MarkManagement

create table Students(
	StudentID nvarchar(12) not null primary key,
	StudentName nvarchar(25) not null,
	DateofBirth Datetime not null,
	Email nvarchar(40),
	Phone nvarchar(12),
	Class nvarchar(10)
)
create table Subjects(
	SubjectID nvarchar(10) not null primary key,
	SubjectName nvarchar(25) not null,
)
create table Mark(
	StudentID nvarchar(12) not null,
	SubjectID nvarchar(10) not null,
	Dates Datetime,
	Theory Tinyint,
	Practical Tinyint
)

alter table Mark add constraint fk_M_St foreign key(StudentID)
	references Students(StudentID)
alter table Mark add constraint fk_M_Sb foreign key(SubjectID)
	references Subjects(SubjectID)
alter table Mark add constraint pk_Mark primary key(StudentID,SubjectID)

insert into Students values('AV0807005', N'Mail Trung Hiếu', '11/10/1989', 'trunghieu@yahoo.com', '0904115116' ,'AV1')
insert into Students values('AV0807006', N'Nguyễn Quý Hùng', '02/12/1988', 'quyhung@yahoo.com', '0955667787', 'AV2')
insert into Students values('AV0807007', N'Đỗ Đắc Huỳnh', '02/01/1990', 'dachuynh@yahoo.com', '0988574747', 'AV2')
insert into Students values('AV0807009', N'An Đăng Khuê','06/03/1986', 'dangkhue@yahoo.com', '0986757463', 'AV1')
insert into Students values('AV0807010', N'Nguyễn T. Tuyết Lan', '12/07/1989', 'tuyetlan@gmail.com', '0983310342', 'AV2')
insert into Students values('AV0807011', N'Đinh Phụng Long', '02/12/1990', 'phunglong@yahoo.com', '0292282882', 'AV1')
insert into Students values('AV0807012', N'Nguyễn Tuấn Nam', '02/03/1990', 'tuannam@yahoo.com', '0972727722', 'AV1')
delete from Students
select *from Students

insert into Subjects values('S001','SQL')
insert into Subjects values('S002','Java Simplefield')
insert into Subjects values('S003','Active Server Page')
delete from Subjects
select *from Subjects

insert into Mark values('AV0807005', 'S001','6/5/2008', 8, 25)
insert into Mark values('AV0807006', 'S002','6/5/2008', 16, 30)
insert into Mark values('AV0807007', 'S001','6/5/2008', 10, 25)
insert into Mark values('AV0807009', 'S003','6/5/2008',7, 13)
insert into Mark values('AV0807010', 'S003','6/5/2008', 9, 16)
insert into Mark values('AV0807011', 'S002','6/5/2008', 8, 30)
insert into Mark values('AV0807012', 'S001','6/5/2008',7 ,31)
insert into Mark values('AV0807005', 'S002','6/6/2008', 12, 11)
insert into Mark values('AV0807011', 'S003' ,'6/6/2008',11 ,20)
insert into Mark values('AV0807010', 'S001','6/6/2008', 7, 6)
delete from Mark
select *from Mark

--> Hiển thị nội dung bảng Students
select *from Students
-->Hiển thị danh sách sinh viên lớp AV1
select StudentID,StudentName,Class from Students
where Class = 'AV1'
-->Chuyển sinh viên có mã AV0807012 sang lớp AV2
update Students set Class = 'AV2' where StudentID = 'AV0807012'
-->Tính tổng số sinh viên của từng lớp
select Class, count(*) as N'Số SV'
from Students
group by Class
-->Hiển thị danh sách sinh viên lớp AV2 được sắp xếp tăng dần theo StudentName
select StudentID,StudentName,Class from Students
where Class = 'AV2'
order by StudentName asc
-->Hiển thị danh sách sinh viên không đạt lý thuyết môn S001(theory<10) thi ngày 6.5.2008
select Students.StudentID, StudentName, Class
from Students inner join Mark on Students.StudentID = Mark.StudentID
where SubjectID = 'S001' and Theory < 10 and Dates = '6/5/2008'
-->Hiển thị danh sách sinh viên không đạt lý thuyết môn S001(theory<10)
select Students.StudentID, StudentName, Class
from Students inner join Mark on Students.StudentID = Mark.StudentID
where SubjectID = 'S001' and Theory < 10 
--> Hiển thị danh sách sinh viên học lớp AV1 sinh sau ngày 1/1/1980
select StudentID,StudentName,Class from Students
where Class = 'AV1' and DateofBirth > '1/1/1980' 
-->Xóa sinh viên có mã AV0807011
delete from Mark where StudentID = 'AV0807011'
delete from Students where StudentID = 'AV0807011'
-->Hiện danh sách SV môn S001 say ngày 6/5/2008
select Students.StudentID, StudentName,SubjectName,Theory,Practical,Dates
from Students inner join Mark on Students.StudentID = Mark.StudentID
			  inner join Subjects on Mark.SubjectID = Subjects.SubjectID
where Mark.SubjectID = 'S001' and Dates = '6/5/2008'