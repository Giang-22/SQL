use master

go
create database QuanLySinhVien
go
use QuanLySinhVien
create table GiaoVien(
	MaGV char(10) not null primary key,
	HoTen nvarchar(20) not null,
	SoDT char(15)
)
create table Lop(
	MaLop char(10) not null primary key,
	TenLop nvarchar(20) not null,
	Phong nvarchar(20) not null,
	MaGV char(10)
)
create table SinhVien(
	MaSV char(10)  not null primary key,
	HoTen nvarchar(20) not null,
	QueQuan nvarchar(20),
	GioiTinh nchar(10),
	NgaySinh date,
	MaLop char(10)
)

alter table Lop add constraint fk_Lop_GV foreign key (MaGV)
	references GiaoVien(MaGV)
alter table SinhVien add constraint fk_SV_Lop foreign key(MaLop)
	references Lop(MaLop)

insert into GiaoVien values('GV01',N'Nguyễn Văn An','0988726222')
insert into GiaoVien values('GV02',N'Võ Thị Hà','0822845338')
insert into GiaoVien values('GV03',N'Trần Văn Bình','0768888729')
insert into GiaoVien values('GV04',N'Trần Mai Linh','0976884332')
insert into GiaoVien values('GV05',N'Nguyễn Chiến Thắng','087784332')
delete from GiaoVien
select *from GiaoVien

insert into Lop values('IT05',N'IT 05',10,'GV03')
insert into Lop values('IT08',N'IS 02',9,'GV01')
insert into Lop values('AF03',N'Kế Toán 02',35,'GV02')
insert into Lop values('MK01',N'Marketing 01',25,'GV02')
insert into Lop values('LM04',N'Logistics 03',12,'GV05')
delete from Lop
select *from Lop

insert into SinhVien values('SV01',N'Nguyễn Văn Sang',N'Hà Nội',N'Nam','2002-12-04','IT08')
insert into SinhVien values('SV02',N'Nguyễn Thị Thủy',N'Thái Bình',N'Nữ','2001-02-08','AF03')
insert into SinhVien values('SV03',N'Hà Văn An',N'Nghệ An',N'Nam','2005-09-07','IT05')
insert into SinhVien values('SV04',N'Trần Thị Lan Anh',N'Hà Nam',N'Nữ','2004-11-10','AF03')
insert into SinhVien values('SV05',N'Lý Mạc Sầu',N'Hà Nội',N'Nữ','2005-01-09','IT08')
insert into SinhVien values('SV06',N'Đào Anh Tú',N'Hà Nam',N'Nữ','2004-03-03','IT05')
insert into SinhVien values('SV07',N'Trịnh Hồ Phương Quý',N'Nghệ An',N'Nam','2005-05-12','LM04')
insert into SinhVien values('SV08',N'Vũ Thị Lan Anh',N'Hà Nội',N'Nữ','2005-01-10','MK01')
insert into SinhVien values('SV09',N'Hà Văn Nam',N'Bắc Giang',N'Nam','2005-01-01','LM04')
insert into SinhVien values('SV10',N'Hà Phương Quý',N'Hà Tĩnh',N'Nam','2005-05-06','AF03')
delete from SinhVien
select *from SinhVien

--> Tạo View đưa ra danh sách sinh viên quê Hà Nội
go
create view vw_DSSV
as
	select *from SinhVien where QueQuan = N'Hà Nội'
go
	select *from vw_DSSV

--> Tạo hàm trả về Tên Sinh viên khi biết Mã sinh viên nhập từ bàn phím
go
create function fn_VD1 (@MaSV char(10))
returns nvarchar(20)
as
begin
	declare @HoTen nvarchar(20)
	set @HoTen = (select HoTen from SinhVien where MaSV = @MaSV)
	return @HoTen
end
go
select dbo.fn_VD1('SV07') as N'Họ và Tên'

--> Viết Hàm đếm xem có bao nhiêu sinh viên tuổi từ x đến y học lớp z

go
create function fn_VD2(@Start int,@Finish int,@TenLop nvarchar(20))
returns int
as
begin
	declare @SoSV int
	set @SoSV = (select count(*) from SinhVien inner join Lop on SinhVien.MaLop = Lop.MaLop 
	where year(getdate()) - year(NgaySinh) between @Start and @Finish and TenLop = @TenLop)
	return @SoSV
end
go

select dbo.fn_VD2(18,22,N'Kế Toán 02') as N'Số SV'

--> Đưa ra tổng số sinh viên mà Giáo viên x chủ nhiệm lớp học y

go
create function fn_VD3 (@TenGV nvarchar(20),@TenLop nvarchar(20))
returns int
as
begin
	declare @SoSV int
	set @SoSV = (select count(*) from SinhVien inner join Lop on SinhVien.MaLop = Lop.MaLop
				inner join GiaoVien on Lop.MaGV = GiaoVien.MaGV
				where GiaoVien.HoTen = @TenGV and TenLop = @TenLop)
	return @SoSV
end
go

select dbo.fn_VD3(N'Nguyễn Chiến Thắng',N'Logistics 03') as N'Số SV'

--> Hàm đưa ra MaSV, HoTen, QueQuan, Tuoi, TenLop, Phong các sinh viên lớp x, giới tính y, Giáo viên chủ nhiệm z

go
create function fn_VD4(@x nvarchar(20),@y nchar(10),@z nvarchar(20))
returns @Table4 table(
		MaSV char(10),
		HoTen nvarchar(20),
		QueQuan nvarchar(20),
		Tuoi int,
		TenLop nvarchar(20),
		Phong int
)
as
begin
	insert into @Table4	
		select MaSV,SinhVien.HoTen,QueQuan,year(getdate()) - year(NgaySinh),TenLop,Phong from SinhVien inner join Lop on SinhVien.MaLop = Lop.MaLop 
		inner join GiaoVien on Lop.MaGV = GiaoVien.MaGV
	where TenLop = @x and GioiTinh = @y and GiaoVien.HoTen = @z
	return
end
go

select *from fn_VD4(N'Logistics 03',N'Nam',N'Nguyễn Chiến Thắng')

--> Viết hàm đưa ra Tên Lớp, Số lượng sinh viên của giới tính x của mỗi lớp
go
create function fn_VD5(@x nchar(10))
returns @Table5 table(
		TenLop nvarchar(20)
		,SoLuong int
)
begin
	insert into @Table5 
		select TenLop,count(*) from Lop inner join SinhVien on Lop.MaLop = SinhVien.MaLop where GioiTinh = @x
		group by TenLop
	return
end
go

select *from fn_VD5 (N'Nam')

--> Thủ tục

-->viết 1 thủ tục thêm mới 1 sinh viên, với các tham biến
-->masv,hoten,quequan,gioitinh,ngaysinh,malop nhập từ bàn phím.
-->hãy kiểm tra xem malop có trong bảng Lớp hay không? Nếu không thì đưa ra
-->thông báo. Hãy kiểm tra xem masv đã tồn tại trong bảng sv chưa?
-->Nếu rồi thì đưa ra TB trùng.


go
create proc sp_VD1(@MaSV char(10),@HoTen nvarchar(20),@QueQuan nvarchar(20),@GioiTinh nchar(10),@NgaySinh date,@MaLop char(10))
as
begin 
	if(not exists(select *from Lop where MaLop = @MaLop))
		print('Not Availabe')
	else if(exists(select *from SinhVien where MaSV = @MaSV))
		print('Was Available')
	else	
		begin
		insert into SinhVien values(@MaSV,@HoTen,@QueQuan,@GioiTinh,@NgaySinh,@MaLop)
		print('Available')
		end
end
go

exec sp_VD1 'SV10',N'Trịnh Văn Toàn',N'Bến Tre',N'Nữ',N'12-12-2005','IT05'
exec sp_VD1 'SV11',N'Trịnh Văn Toàn',N'Bến Tre',N'Nữ',N'12-12-2005','IT01'
exec sp_VD1 'SV11',N'Trịnh Văn Toàn',N'Bến Tre',N'Nữ',N'12-12-2005','IT05'

-->viết 1 thủ tục thêm mới 1 lớp, với các tham biến truyền vào:
-->malop,tenlop,phong,magv. hãy kiểm tra xem magv có trong bảng gv không?
-->Nếu không thì đưa ra TB. hãy kiểm tra xem Tên lớp có bị trùng không, nếu
-->trùng thì đưa ra TB. ngược lại cho phép nhập.


go
create proc sp_VD2(@MaLop char(10),@TenLop nvarchar(20),@Phong nvarchar(20),@MaGV char(10))
as
begin
	if(not exists(select *from GiaoVien where MaGV = @MaGV))
		print('Not Available')
	else if(exists(select *from Lop where MaLop = @MaLop))
		print('Was Available')
	else
		begin
			insert into Lop values(@MaLop,@TenLop,@Phong,@MaGV)
			print('Available')
		end
end
go

exec sp_VD2 'IT02','Computer Science 01',11,'GV04'
exec sp_VD2 'IT02','Computer Science 01',11,'GV09'
exec sp_VD2 'IT05','Computer Science 01',11,'GV04'

-->viết 1 thủ tục xoá 1 sinh viên ra khỏi bảng sv, với tham biến
-->nhập vào là masv. hãy kiểm tra xem masv có trong bảng sv không?
-->Nếu không thì không cho phép xoá, ngược lại cho phép xoá.

go
create proc sp_VD3(@MaSV char(10))
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
go

exec sp_VD3 'SV99'
exec sp_VD3 'SV02'

--> viết 1 thủ tục thêm mới 1 sinh viên, với các tham biến masv,hoten,quequan,gioitinh,ngaysinh,tenlop nhập từ bàn phím.
-->hãy kiểm tra xem tenlop có trong bảng Lớp hay không? Nếu không thì đưa ra
-->thông báo. Hãy kiểm tra xem masv đã tồn tại trong bảng sv chưa?
-->Nếu rồi thì đưa ra TB trùng.

go
create proc sp_VD4(@MaSV char(10),@HoTen nvarchar(20),@QueQuan nvarchar(20),@GioiTinh nchar(10),@NgaySinh date,@TenLop nvarchar(10))
as
begin 
	if(not exists(select *from Lop where TenLop = @TenLop))
		print('Not Availabe')
	else if(exists(select *from SinhVien where MaSV = @MaSV))
		print('Was Available')
	else
		begin
			declare @MaLop char(10)
			set @MaLop = (select MaLop from Lop where TenLop = @TenLop)
			insert into SinhVien values(@MaSV,@HoTen,@QueQuan,@GioiTinh,@NgaySinh,@MaLop)
		end
end
go

exec sp_VD4 'SV111',N'Trịnh Văn Toàn',N'Bến Tre',N'Nữ',N'12-12-2005', N'Computer Science 02'
exec sp_VD4 'SV111',N'Trịnh Văn Toàn',N'Bến Tre',N'Nữ',N'12-12-2005', N'IS 02'
exec sp_VD4 'SV03',N'Trịnh Văn Toàn',N'Bến Tre',N'Nữ',N'12-12-2005', N'IT 05'



