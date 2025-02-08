use master
go
create database DeptEmp
go
use DeptEmp

create table Department(
	DepartmentNo integer not null primary key,
	DepartmentName char(25) not null,
	Location char(25) not null
)
create table Employee(
	EmpNo integer not null primary key,
	Fname varchar(15) not null,
	Lname varchar(15) not null,
	Job varchar(25) not null,
	HireDate Date not null,
	Salary Numeric not null,
	Commision Numeric,
	DepartmentNo Integer
)
alter table Employee add constraint fk_E_D foreign key(DepartmentNo)
	references Department(DepartmentNo)

insert into Department values(10, 'Accounting', 'Melbourne')
insert into Department values(20 ,'Research', 'Adealide')
insert into Department values(30, 'Sales', 'Sydney')
insert into Department values(40, 'Operations', 'Perth')

insert into Employee values(1, 'John', 'Smith', 'Clerk', '12-17-1980', 800, null ,20)
insert into Employee values(2, 'Peter', 'Allen', 'Salesman', '11-20-1981', 1600, 300, 30)
insert into Employee values(3, 'Kate', 'Ward', 'Salesman', '11-22-1981', 1250, 500, 30)
insert into Employee values(4, 'Jack', 'Jones', 'Manager', '07-02-1981', 2975, null, 20)
insert into Employee values(5, 'Joe', 'Martin', 'Salesman', '09-28-1981', 1250, 1400, 30)

-->Hiển thị nội dung bảng Department
select *from Department
-->Hiển thị nội dung bảng Employee
select *from Employee
-->Hiển thị employee number, employee first name và employee last name từ bảng Employee mà employee first name có tên là ‘Kate’.
Select EmpNo, Fname,Lname from Employee
where Fname = 'Kate'
-->Hiển thị ghép 2 trường Fname và Lname thành Full Name, Salary, 10%Salary (tăng 10% so với lương ban đầu).
select Fname + ' ' + Lname as 'Full Name',Salary, Salary + 0.1*Salary as 'Increase'
from Employee
-->Hiển thị Fname, Lname, HireDate cho tất cả các Employee có HireDate là năm 1981 và sắp xếp theo thứ tự tăng dần của Lname.
select Fname,Lname,HireDate from Employee
where year(HireDate) = 1981
order by Lname asc
-->Hiển thị trung bình(average), lớn nhất (max) và nhỏ nhất(min) của lương(salary) cho từng phòng ban trong bảng Employee.
select DepartmentNo, avg(Salary) as 'Average', max(Salary) as 'Maximum', min(Salary) as 'Minimun'
from Employee
group by DepartmentNo
-->Hiển thị DepartmentNo và số người có trong từng phòng ban có trong bảng Employee.
select DepartmentNo,Count(*) as 'Count of People' from Employee
group by DepartmentNo
--> Hiển thị DepartmentNo, DepartmentName, FullName (Fname và Lname), Job, Salary trong bảng Department và bảng Employee.
select Employee.DepartmentNo,DepartmentName,Fname + ' ' + Lname as 'Full Name', Job,Salary
from Employee inner join Department on Employee.DepartmentNo = Department.DepartmentNo
--> Hiển thị DepartmentNo, DepartmentName, Location và số người có trong từng phòng ban của bảng Department và bảng Employee.
select Employee.DepartmentNo,DepartmentName,Location,count(*) as 'Count of People'
from Department inner join Employee on Employee.DepartmentNo = Department.DepartmentNo
group by Employee.DepartmentNo,DepartmentName,Location
--> Hiển thị tất cả DepartmentNo, DepartmentName, Location và số người có trong từng phòng ban của bảng Department và bảng Employee.
select Department.DepartmentNo,DepartmentName,Location,count(Employee.DepartmentNo) as 'Count of People'
from Department left join Employee on Employee.DepartmentNo = Department.DepartmentNo
group by Department.DepartmentNo,DepartmentName,Location
