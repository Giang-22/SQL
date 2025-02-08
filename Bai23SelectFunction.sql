use master
go
create database QLSinhVien
go
use QLSinhVien
go
create table SinhVien(
	MaSV nchar(10) not null primary key,
	Hoten nvarchar(30) not null,
	QueQuan nvarchar(30) not null,
	GioiTinh nchar(10),
	Ngaysinh date,
	MaLop nchar(10)
)
create table Lop(
	MaLop nchar(10) not null primary key,
	TenLop nvarchar(30),
	Phong int,
	MaGV nchar(10)
)
create table GiaoVien(
	MaGV nchar(10) not null primary key,
	Hoten nvarchar(30),
	SoDT nchar(15)
)
go
alter table SinhVien add constraint fk_SV_Lop foreign key(MaLop)
	references Lop(MaLop)
alter table Lop add constraint fk_Lop_GV foreign key(MaGV)
	references GiaoVien(MaGV)

insert into GiaoVien values('GV01',N'Nguyễn Văn An','092888')
insert into GiaoVien values('GV02',N'Võ Thị Hà','08228')
insert into GiaoVien values('GV03',N'Trần Văn Bình','0768888')
insert into GiaoVien values('GV04',N'Trần Mai Linh','097688')
delete from GiaoVien
select * from GiaoVien

insert into Lop values('IT01',N'Công nghệ thông tin 01',10,'GV03')
insert into Lop values('IT08',N'Hệ thống thông tin 02',9,'GV01')
insert into Lop values('AF03',N'Kế Toán 02',35,'GV02')
select * from Lop
order by Phong asc

insert into SinhVien values('SV01',N'Nguyễn Văn Sang',N'Hà Nội',N'Nam','2002-12-04','IT08')
insert into SinhVien values('SV02',N'Nguyễn Thị Thủy',N'Thái Bình',N'Nữ','2001-02-08','AF03')
insert into SinhVien values('SV03',N'Hà Văn An',N'Nghệ An',N'Nam','2005-09-07','IT01')
insert into SinhVien values('SV04',N'Trần Thị Lan Anh',N'Hà Nam',N'Nữ','2004-11-10','AF03')
insert into SinhVien values('SV05',N'Lý Mạc Sầu',N'Hà Nội',N'Nữ','2005-01-09','IT08')
insert into SinhVien values('SV06',N'Đào Anh Tú',N'Hà Nam',N'Nữ','2004-03-03','IT01')
delete from SinhVien
select * from SinhVien

select * from SinhVien
	inner join Lop on SinhVien.MaLop = Lop.MaLop
	inner join GiaoVien on GiaoVien.MaGV = Lop.MaGV
where Phong = (select max(Phong) from Lop)

-- đưa ra toàn bộ thông tin bảng
-- select * from TableName

-- đưa ra một số cột
-- select ColumnName from TableName 

-- đưa ra một cột duy nhất không bị lặp lại dữ liệu
-- select distinct ComlumName from TableName

-- sắp xếp kết quả theo chiều tăng hoặc giảm dần
-- select Column1Name,... from TableName
-- order by Column2Name desc/asc
-- vd, đưa ra các sinh viên có số phòng giảm dần
select MaSV,Hoten from SinhVien
inner join Lop on SinhVien.MaLop = Lop.MaLop
order by Phong desc
-- vd, đưa ra tên sinh viên theo chiều tăng dần của họ tên và giảm dần của năm sinh
-- select * from sv order by Hoten asc, Ngaysinh desc

-- Lấy ra N dữ liệu đầu tiên của bảng (Top N/Top N percent)
-- Câu lệnh hay dùng trong lập trình
-- vd, Đưa ra 2 sinh viên cao tuổi nhất
select top 2 MaSV,Hoten from SinhVien
order by Ngaysinh asc

-- vd, đưa ra 30% các sinh viên
select top 30 percent * from SinhVien

--6, Câu lệnh lọc dữ liệu: where điều kiên ( =, <, > ,<= ,>= ,<> , and, or, not)
--vd, đưa ra các sinh viên quê Hà Nội
select * from SinhVien
where QueQuan = N'Hà Nội'
--vd, đưa ra các sinh viên quên Hà Nội, giới tính nữ
select MaSV,Hoten from SinhVien
where QueQuan = N'Hà Nội' and GioiTinh = N'Nữ'

--7, Kết nối bảng: TableName1 inner join TableName2 on TableName1.ColumnName = TableName2.ColumnName
-- on là điều kiện kết nối
-- vd, đưa ra các sinh viên học lớp Hệ Thống thông tin 02 quê Hà Nội
select MaSV, Hoten from SinhVien inner join Lop on SinhVien.MaLop = Lop.MaLop
where TenLop = N'Hệ thống thông tin 02' and QueQuan = N'Hà Nội'
-- vd, đưa ra các sinh viên Nữ do thầy Nguyễn Văn An Chủ nhiệm
select MaSV, SinhVien.Hoten, GioiTinh
from SinhVien inner join Lop on SinhVien.MaLop = Lop.MaLop
	inner join GiaoVien on GiaoVien.MaGV = Lop.MaGV
where GiaoVien.Hoten = N'Nguyễn Văn An' and GioiTinh = N'Nữ'


-- 8, in/not in (Select kép)
--vd, đưa ra các sinh viên quê Hà Nội hoặc Hà Tây hoặc Nghệ An
select * from SinhVien where QueQuan in (N'Hà Nội',N'Hà Tây',N'Nghệ An')
--vd, đưa ra các sinh viên không có quê ở Hà Nội, Thái Bình
select * from SinhVien where QueQuan  not in (N'Hà Nội',N'Thái Bình')
--vd, đưa ra các giáo viên chưa dạy lớp nào
select MaGV, Hoten from GiaoVien 
where MaGV not in(select distinct MaGV from Lop)

--9, Một số hàm ngày tháng đơn giản
-- day(ColumnTypeDate), month(ColumnTypeDate), year(ColumnTypeDate), getdate() -> ngày tháng năm hiện tại
-- vd, đưa ra các sinh viên và tuổi các sinh viên lớn hơn 20
select MaSV,Hoten,QueQuan, year(getdate()) - year(Ngaysinh) as N'Tuổi'
from SinhVien
where year(getdate()) - year(Ngaysinh) > 20

--10, Between ... and ...
-- đưa ra cacs sinh viên nữ có tuổi từ 18 đến 20
select * from SinhVien
where GioiTinh = N'Nữ' and year(getdate()) - year(Ngaysinh) between 18 and 20

--11, Một số hàm thống kê:
-- count(*)/count(ColumnName); max(ColumnName),min(ColumnName),sum(ColumnName),avg(ColumnName)
-- vd, đếm xem có bao nhiêu sinh viên quê Hà Nội
select count(*) as N'Tổng SV' from SinhVien where QueQuan = N'Hà Nội'
-- vd, đưa ra tuổi của lớn nhất của các sinh viên
select max(year(getdate()) - year(Ngaysinh)) as N'Tuổi lớn nhất' from SinhVien
-- vd, đưa ra Thông tin sinh viên có tuổi lớn nhất
select MaSV,Hoten,Ngaysinh from SinhVien
where year(getdate()) - year(Ngaysinh) = (select max(year(getdate()) - year(Ngaysinh)) from SinhVien)
-- group by - having: nhóm dữ liệu
--vd, đưa ra số lượng sinh viên nam, nữ của lớp HTTT02
select GioiTinh, count(*) as N'Số lượng'
from SinhVien inner join Lop on SinhVien.MaLop = Lop.MaLop
where TenLop = N'Hệ thống thông tin 02'
group by GioiTinh

-- do có 2 giói tính nam và nữ thì phải nhóm theo nam và nữ
--vd, đưa ra các lớp và thống kê số lượng sinh viên nữ của mỗi lớp
select TenLop,count(*) as N'Tổng SV'
from Lop inner join SinhVien on Lop.MaLop = SinhVien.MaLop
where GioiTinh = N'Nữ'
group by TenLop

-- 13, having: điều kiện nhóm
-- chú ý: where là điều kiện lọc dữ liệu, còn having là điều kiện lọc nhóm
-- vd, đưa ra các lớp có số lượng sinh viên nữ lớn hơn hoặc bằng 2
select TenLop,count(*) as N'SL Sinh viên'
from Lop inner join SinhVien on Lop.MaLop = SinhVien.MaLop
where GioiTinh = N'Nữ'
group by TenLop
having count(*) >= 2

--quy trinh truy vấn
-- select *, ColumnNameSelect
-- from TableName1 inner join TableName2 on ... : 
-- group by ColumnNameGroup ... : Gom nhóm dữ liệu sau lọc thành các nhóm
-- having
-- select

--1, Thêm dữ liệu vào bảng
-- bảng 1 trước,  nhiều sau
-- insert into TableName value()

--2, Xóa dữ liệu
-- xóa nhiều trước, một sau
-- delete from TableName where ĐKien
-- vd, xóa Giáo viên không chủ nhiệm lớp nào
delete from GiaoVien where MaGV not in (select MaGV from Lop)

--3, Cập nhật dữ liệu:
-- update TableName set ColumnConvert = Convert where ColumnName = DKConvert

--vd, sửa đổi sinh viên có mã là  SV03 thành Giới tính nữ và Quê thành Hà tĩnh
update SinhVien set GioiTinh = N'Nam',QueQuan = N'Hà Tĩnh' where MaSV = 'SV03'


-- vd, tạo view đưa ra danh sách các sinh viên học lớp HTTT02

create view vw_DSSinhVien
as
	select MaSV, Hoten, QueQuan
	from SinhVien inner join Lop on SinhVien.MaLop = Lop.MaLop;
	--> gọi view
	select MaSV, Hoten from vw_DSSinhVien
	select * from vw_DSSinhVien
	select * from vw_DSSinhVien where QueQuan = N'Hà Nội'

--vd2,
create view vw_DSSinhVien1
as 
	select MaSV,Hoten, QueQuan, MaGV
	from SinhVien inner join Lop on SinhVien.MaLop = Lop.MaLop
	where TenLop = N'Hệ thống thông tin 02';
--đưa ra tên gv,họ tên ,số điện thoại dạy lớp Hệ thống thông tin 02
	select distinct GiaoVien.Hoten, SoDT
	from GiaoVien inner join vw_DSSinhVien1 on GiaoVien.MaGV = vw_DSSinhVien1.MaGV

-- vd. Tạo view đưa ra MaSV,Hoten,GioiTinh,QueQuan,Tuoi của các sinh vien

create view vw_VD31
as
	select MaSV, Hoten, GioiTinh, QueQuan, year(getdate()) - year(Ngaysinh) as Tuoi
	from SinhVien;

--> Gọi view
	select * from vw_VD3
	select max(tuoi) as N'Tuổi lớn nhất' from vw_VD3

--> Tạo Hàm
--> vd: Tạo hàm tìm Họ Tên SV khi biết Mã sinh viên
create function fn_VD1 (@MaSV nchar(10))
returns nvarchar(20)
as
begin
	declare @TenSV nvarchar(20)
	set @TenSV = (select Hoten from SinhVien where MaSV = @MaSV)
	return @TenSV
end

--> Gọi Hàm

select dbo.fn_VD1('SV01')
select dbo.fn_VD1('SV06')

-->  In ra số lượng sinh viên thuộc tuổi trong khoảng x,y thuộc lớp z nhập từ bàn phím

create function fn_VD2(@TuoiBD int,@TuoiKT int,@Lop nchar(10))
returns int
as
begin
	declare @Dem int
	set @Dem = (select count(*) from SinhVien where year(getdate()) - year(Ngaysinh) between @TuoiBD and @TuoiKT and MaLop = @Lop)
	return @Dem
end
select dbo.fn_VD2(18,20,'IT08')

--> VD3: Đếm số sinh viên học Giáo viên x dạy lớp y

alter function fn_VD3(@TenGV nvarchar(30),@TenLop nvarchar(30))
returns int
as
begin
	declare @Dem int
	set @Dem = (select count(*) from SinhVien inner join Lop on SinhVien.MaLop = Lop.MaLop
		inner join GiaoVien on Lop.MaGV = GiaoVien.MaGV
		where GiaoVien.Hoten = @TenGV and TenLop = @TenLop)
	return @Dem 
end

select dbo.fn_VD3(N'Nguyễn Văn An',N'Hệ thống thông tin 02') as N'Số SV'

--> Đưa ra MaSV, Hoten, QueQuan, Tuoi, TenLop, Phong thuộc Tên lớp x, Giới tính y và GVCN z nhập từ bàn phím

alter function fn_VD4(@x nvarchar(30),@y nchar(10),@z nvarchar(30))
returns @table1 table(
		MaSV nchar(10),
		Hoten nvarchar(30),
		QueQuan nvarchar(30),
		Tuoi int,
		TenLop nvarchar(30),
		Phong int
)
as
begin
	insert into @table1
		select MaSV,SinhVien.Hoten,QueQuan,year(getdate()) - year(Ngaysinh),TenLop,Phong
			from SinhVien inner join Lop on SinhVien.MaLop = Lop.MaLop
		inner join GiaoVien on Lop.MaGV = GiaoVien.MaGV
		where TenLop = @x and GioiTinh = @y and GiaoVien.Hoten = @z
	
	return
end

select * from fn_VD4(N'Hệ thống thông tin 02',N'Nam',N'Nguyễn Văn An')

--> đưa ra Tên lớp và số lượng sinh viên Giới tính x của các lớp

create function fn_VD5(@x nchar(10))
returns @table2 table(
	TenLop nvarchar(30),
	SoLuong int
)
as
begin
	insert into @table2
		select TenLop,count(*) from Lop inner join SinhVien on Lop.MaLop = SinhVien.MaLop
		where GioiTinh = @x
		group by TenLop
	return
end

select * from fn_VD5(N'Nữ')

-->

create proc sp_VD6(@MaSV nchar(10),@Hoten nvarchar(30),@Quequan nvarchar(30),@GioiTinh nchar(10),@Ngaysinh date,@Malop nchar(10))
as
begin
	if(not exists (select *from Lop where MaLop = @Malop))
		print('Unavailable')
	else if(exists(select *from SinhVien where MaSV = @MaSV))
		print('Was available')
	else
		begin 
			insert into SinhVien values(@MaSV,@Hoten,@Quequan,@GioiTinh,@Ngaysinh,@Malop)
			print('Available')
		end
end

exec sp_VD6 'SV090', N'Trịnh Trần Phương Quý', N'Nghệ An',N'Nam','05-12-2005','IT08'

--> VD7: Viết 1 thủ tục thêm mới 1 lớp, với các tham biến là: MaLop, TenLop, Phong, MaGV
--> kiểm tra nếu Mã giáo viên có trong bảng giáo viên, hãy thông báo 'Unavailable'
--> Nếu Tên lớp đã tồn tại thông báo 'Was available', ngược lại thêm vào bảng

create proc sp_VD7(@MaLop nchar(10),@TenLop nvarchar(30),@Phong int,@MaGV nchar(10))
as
begin
	if(not exists (select *from GiaoVien where MaGV = @MaGV))
		print('Unavailable')
	else if(exists (select *from Lop where TenLop = @TenLop))
		print('Was available')
	else
		begin
			insert into Lop values(@MaLop,@TenLop,@Phong,@MaGV)
			print('Avalable')
		end
end

select *from Lop
exec sp_VD7 'IT09', N'Công nghệ đa phương tiện', 19, GV01

create proc sp_VD8 (@MaSV nchar(10))
as
begin
	if(not exists(select *from SinhVien where MaSV = @MaSV))
		print('Cant Delete')
	else
		begin
		delete from SinhVien where MaSV = @MaSV
		print('Finish Delete')
		end
end

select* from SinhVien
exec sp_VD8 'SV090'

create proc sp_VD9(@MaSV nchar(10),@Hoten nvarchar(30),@Quequan nvarchar(30),@GioiTinh nchar(10),@Ngaysinh date,@TenLop nvarchar(30))
as
begin 
	if(not exists (select *from Lop where TenLop = @TenLop))
		print('chua fan jack')
	else 
	if(exists(select *from SinhVien where MaSV = @MaSV))
		print('da fan jack nhung chua lau')
	else
		begin 
			declare @MaLop nchar(10)
			set @MaLop = (select MaLop from Lop where TenLop = @TenLop)
			insert into SinhVien values(@MaSV,@Hoten,@Quequan,@GioiTinh,@Ngaysinh,@MaLop)
			print('fan jack 30 nam')
		end
end
select *from Lop
delete from sinhvien

