use master
go
create database QLSinhVien
go
use QLSinhVien

create table GiaoVien(
	MaGV nchar(10) not null primary key,
	HoTen nvarchar(30) not null,
	SoDT nchar(10)
)
create table Lop(
	MaLop nchar(10) not null primary key,
	TenLop nvarchar(30) not null,
	Phong nvarchar(30),
	MaGV nchar(10)
)
create table SinhVien(
	MaSV nchar(10) NOT NULL primary key,
	HoTen nvarchar(30) not null,
	QueQuan nvarchar(30) not null,
	GioiTinh nchar(10),
	NgaySinh date,
	MaLop nchar(10)
)

alter table Lop add constraint fk_Lop_GiaoVien foreign key (MaGV)
	references GiaoVien(MaGV)
alter table SinhVien add constraint fk_SinhVien_Lop foreign key (MaLop)
	references Lop(MaLop)

insert into GiaoVien values('GV01',N'Trần Mai Linh','0976556459')
insert into GiaoVien values('GV02',N'Phạm Thanh Hùng','0347223910')
insert into GiaoVien values('GV03',N'Nguyễn Chiến Thăng','0806556459')
insert into GiaoVien values('GV04',N'Đỗ Huyền Trang','0941772342')
insert into GiaoVien values('GV05',N'Hoàng Duy Khánh','0576556459')
select *from GiaoVien

insert into Lop values('CP01',N'Kế Toán 02','402','GV02')
insert into Lop values('MK04',N'Marketing 03','909','GV05')
insert into Lop values('IT07',N'Hệ Thống Thông Tin 02','708','GV01')
insert into Lop values('LP02',N'Logistics 05','502','GV03')
insert into Lop values('CP04',N'Kế Toán 01','403','GV02')
delete from Lop
select*from Lop

insert into SinhVien values('SV01',N'Nguyễn Văn Anh',N'Hà Tĩnh',N'Nam','12-21-2006','IT07')
insert into SinhVien values('SV06',N'Trần Đình An',N'Hà Nội',N'Nam','09-25-2004','IT07')
insert into SinhVien values('SV011',N'Nguyễn Thị Bình',N'Nghệ An',N'Nữ','08-15-2002','IT07')
insert into SinhVien values('SV016',N'Hoàng Hải Đăng',N'Thái Bình',N'Nam','12-19-2005','IT07')
insert into SinhVien values('SV021',N'Hoàng Kim Dung',N'Nghệ An',N'Nữ','08-08-2003','IT07')
insert into SinhVien values('SV02',N'Phạm Minh Phương',N'Nam Định',N'Nữ','03-22-2005','LP02')
insert into SinhVien values('SV07',N'Tống Văn Toàn',N'Thái Bình',N'Nam','09-30-2001','LP02')
insert into SinhVien values('SV012',N'Hồ Thị Quỳnh Trang',N'Hà Nam',N'Nữ','01-31-2005','LP02')
insert into SinhVien values('SV017',N'Trần Lan Anh',N'Ninh Bình',N'Nữ','02-27-2006','LP02')
insert into SinhVien values('SV022',N'Hà Thị Lan',N'Hòa Bình',N'Nữ','01-09-2001','LP02')
insert into SinhVien values('SV027',N'Quán Thế Văn',N'Thanh Hóa',N'Nam','08-09-2006','LP02')
insert into SinhVien values('SV03',N'Hoàng Tiến An',N'Thái Bình',N'Nam','09-09-2005','MK04')
insert into SinhVien values('SV08',N'Phan Vân Anh',N'Nghệ An',N'Nữ','12-31-2005','MK04')
insert into SinhVien values('SV013',N'Vũ Hồng Nhung',N'Cao Bằng',N'Nữ','09-11-2006','MK04')
insert into SinhVien values('SV018',N'Đỗ Huyền Trang',N'Quảng Nam',N'Nữ','09-28-2005','MK04')
insert into SinhVien values('SV023',N'Triệu Quang Anh',N'Hải Phòng',N'Nam','07-06-2006','MK04')
insert into SinhVien values('SV04',N'Đỗ Tiến Dũng',N'Nam Định',N'Nam','09-12-2004','CP01')
insert into SinhVien values('SV09',N'Doãn Văn Việt',N'Nam Định',N'Nam','08-15-2001','CP01')
insert into SinhVien values('SV014',N'Đặng Thị Lan Anh',N'Nghệ An',N'Nữ','07-31-2005','CP01')
insert into SinhVien values('SV019',N'Quán Thị Thu Phương',N'Hà Nội',N'Nữ','06-08-2005','CP01')
insert into SinhVien values('SV05',N'Nguyễn Ngọc Diệp',N'Ninh Bình',N'Nữ','09-12-2002','CP04')
insert into SinhVien values('SV010',N'Nguyễn Thị Khánh Hòa',N'Nghệ An',N'Nữ','02-05-2004','CP04')
insert into SinhVien values('SV015',N'Phạm Huyền Trang',N'Quảng Trị',N'Nữ','12-11-2003','CP04')
insert into SinhVien values('SV020',N'Phạm Văn Đồng',N'Bắc Giang',N'Nam','12-23-2001','CP04')

delete from SinhVien
select *from SinhVien

--> Cú pháp lệnh sửa Thuộc tinh của đối tượng
-->  Update TableName set Attributes =... where Condition = ...

--> vd: Sửa Thông tin của sinh viên có mã là 'SV04' Quê quán thành 'Nghệ An' và Mã lớp thành 'CP04'
update SinhVien set MaLop = 'CP04', QueQuan = N'Nghệ An' where MaSV = 'SV09'

--> Cú pháp lệnh xóa đối tượng
--> Delete from TableName where Condition = ...

--> vd: Xóa sinh viên có mã là 'SV02' ra khỏi danh sách
delete from SinhVien where MaSV = 'SV02'

-->vd: Xóa lớp có Ten lớp là 'Kế toán 02' 
--> Ta phải xóa Toàn bộ sinh viên thuộc lớp có mã lớp thuộc tên lớp tương ứng trước
delete from SinhVien where MaLop = (select MaLop from Lop where TenLop = N'Kế Toán 02')
delete from Lop where TenLop = N'Kế Toán 02'

-->Cú pháp view
--> create view ViewName as select ...
-->Gọi View
--> select Attributes from ViewName where Condition

-->vd: Tạo View đưa ra MaSV, QueQuan, TenLop, MaGV của các sinh viên học lớp Hệ Thống Thông Tin 02
go
create view vw_VD2
as 
	Select MaSV, QueQuan, TenLop, MaGV from SinhVien
	inner join Lop on SinhVien.MaLop = Lop.MaLop
	where TenLop = N'Hệ Thống Thông Tin 02'
go
	--> Đưa ra thông tin giáo viên dạy lớp Hệ thống Thông Tin 02
	select distinct GiaoVien.MaGV, HoTen, SoDT from GiaoVien
	inner join vw_VD2 on GiaoVien.MaGV = vw_VD2.MaGV
--> Tạo view đưa ra MaSV, HoTen, Tuổi của các sinh viên
go
create view vw_VD4
as
	select MaSV, HoTen, year(getdate()) - year(NgaySinh) as N'Tuoi'
	from SinhVien
go
 --> đưa ra danh sách các sinh viên lớn tuổi nhất
go
	select *from vw_VD4
	select max(Tuoi) as 'Tuoi Lon Nhat' from vw_VD4
go


-->Cú Pháp hàm trả về một gía trị cụ thể
-->create function FunctionName(@Addtr1 DataType1,@Addtr2 DataType2 ...)
-->returns DataTypeReturn
-->as 
-->begin 
-->declare @AddtrReturn DataTypeReturn
-->.....
-->return @AddtrReturn
-->end

--> Gọi hàm trả về một giá trị cụ thể
-->select dbo.FunctionName(Addtr1, Addtr2, ... )

-->1, returns: Kiểu trả về của một hàm
-->2, return: Giá trị trả về
-->3, declare: khai báo biến
-->4, begin..end: bắt đầu và kết thúc một khối lệnh
-->5, @: biến bắt đầu một khối lệnh
-->6, set: Gán giá trị cho một biến cục bộ (có sẵn)

--> vd1: Tạo hàm đưa ra HoTen của sinh viên khi biết MaSV Nhập từ bàn phím
go 
create Function fn_VD1(@MaSV nchar(10))
returns nvarchar(30)
as
begin
	declare @HoTen nvarchar(30)
	set @HoTen = (select HoTen from SinhVien where MaSV = @MaSV)
	return @HoTen
end
go

select dbo.fn_VD1 ('SV019') as N'Họ Tên'

-->vd2: Tạo Hàm đếm xem có bao nhiêu sinh viên có độ tuổi từ Start đến Finish học lớp Class

go
create Function fn_VD2(@Start int,@Finish int,@Class nvarchar(30))
returns int
as
begin
	declare @SoSV int
	set @SoSV = (select count(*) from SinhVien inner join Lop on SinhVien.MaLop = Lop.MaLop where (year(getdate()) - year(NgaySinh) between @Start and @Finish) and TenLop = @Class)
	return @SoSV
end
go
select dbo.fn_VD2(18,20,N'Hệ thống Thông Tin 02') as N'Số SV'

-->vd3: gọi hàm đưa ra số Sinh viên mà Giáo Viên x chủ nhiệm lớp học y

go
create Function fn_VD3(@TenGV nvarchar(30),@TenLop nvarchar(30))
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

select dbo.fn_VD3 (N'Nguyễn Chiến Thăng',N'Logistics 05') as N'Số SV'


--> Cú pháp hàm trả về một list Kết quả
--> create Function FunctionName(@Addtr1 DataType1,@Addtr2 DataType2, ... )
--> returns @TableName table(
-->						column1 Datatype1,
-->						column2 Datatype2,
-->						...     ...)
-->as
-->begin
-->		insert into @TableName
-->			select column1, column2, ... from
-->			where
-->		return
-->end

--> Cú pháp hàm trả về một list Kết quả
-->select *from FunctionName(Addtr1, Addtr2, ... )
-->vd4: Viết hàm đưa ra MaSV, HoTen, QueQuan, Tuoi, TenLop, Phong của các sinh viên học lớp x, giới tính y, giáo viên chủ nhiệm z

go
create Function fn_VD4(@TenLop nvarchar(30),@GioiTinh nchar(10),@TenGV nvarchar(30))
returns @Table1 table(
		MaSV nchar(10),
		HoTen nvarchar(30),
		QueQuan nvarchar(30),
		Tuoi int,
		TenLop nvarchar(30),
		Phong nvarchar(30)
)
as
begin
	insert into @Table1
		select MaSV, SinhVien.HoTen, QueQuan, year(getdate())-year(NgaySinh), TenLop, Phong 
		from SinhVien inner join Lop on SinhVien.MaLop = Lop.MaLop
		inner join GiaoVien on Lop.MaGV = GiaoVien.MaGV
		where TenLop = @TenLop and GioiTinh = @GioiTinh and GiaoVien.HoTen = @TenGV
	return
end
go

select *from fn_VD4 (N'Logistics 05', N'Nam', N'Nguyễn Chiến Thăng')

-->vd5: Đưa ra tên lớp, Số lượng sinh viên giới tính x của từng lơp
go
create Function fn_VD5(@GioiTinh nchar(10))
returns @Table2 table(
		TenLop nvarchar(30),
		SoSV int
)
as
begin
	insert into @Table2
		select TenLop,count(*) from Lop inner join SinhVien on Lop.MaLop = SinhVien.MaLop
		where GioiTinh = @GioiTinh
		group by TenLop
	return
end
go

select *from fn_VD5(N'Nam')

--> Thủ tục không output
-->Cú pháp: 
--> create proc ProcedureName(@Addtr1 Datatype1,@Addtr2 Datatype2, .... )
--> as
--> begin
--> ...
--> end

--> Cách gọi thủ tục
--> exec ProceduceName Addtr1,Addtr2, ... 


-->vd1. viết 1 thủ tục thêm mới 1 sinh viên, với các tham biến
-->masv,hoten,quequan,gioitinh,ngaysinh,malop nhập từ bàn phím.
-->hãy kiểm tra xem malop có trong bảng Lớp hay không? Nếu không thì đưa ra
-->thông báo. Hãy kiểm tra xem masv đã tồn tại trong bảng sv chưa?
-->Nếu rồi thì đưa ra TB trùng.
go
create proc sp_VD6(@MaSV nchar(10),@HoTen nvarchar(30),@QueQuan nvarchar(30),@GioiTinh nchar(10),@NgaySinh date,@MaLop nchar(10))
as
begin
	if(not exists(select *from Lop where MaLop = @MaLop))
		print(N'Không tìm thấy mã lớp này')
	else if(exists(select *from SinhVien where MaSV = @MaSV))
		print(N'Đã tồn tại sinh viên này')
	else
		begin
			insert into SinhVien values(@MaSV,@HoTen,@GioiTinh,@QueQuan,@NgaySinh,@MaLop)
			print(N'Thêm một sinh viên thành công')
		end
end
go

exec sp_VD6 'SV01',N'Nguyễn Văn Anh',N'Nghệ An',N'Nam','09-30-2005','IT07'
exec sp_VD6 'SV030',N'Nguyễn Văn Anh',N'Nghệ An',N'Nam','09-30-2005','IT01'
exec sp_VD6 'SV030',N'Nguyễn Văn Anh',N'Nghệ An',N'Nam','09-30-2005','CP04'

--vd3. viết 1 thủ tục xoá 1 sinh viên ra khỏi bảng sv, với tham biến
--nhập vào là masv. hãy kiểm tra xem masv có trong bảng sv không?
--Nếu không thì không cho phép xoá, ngược lại cho phép xoá.

go
create proc sp_VD7(@MaSV nchar(10))
as
begin
	if(not exists(select *from SinhVien where MaSV = @MaSV))
	 print(N'Không tồn tại sinh viên này trong danh sách')
	else
		begin
			delete from SinhVien where MaSV = @MaSV	
			print(N'Xóa Thành Công')
		end
end
go

exec sp_VD7 'SV98'
exec sp_VD7 'SV030'

-->vd11. viết 1 thủ tục thêm mới 1 sinh viên, với các tham biến
-->masv,hoten,quequan,gioitinh,ngaysinh,malop nhập từ bàn phím.
-->hãy kiểm tra xem malop có trong bảng Lớp hay không? Nếu không thì đưa ra
-->thông báo Mã lỗi 1. Hãy kiểm tra xem masv đã tồn tại trong bảng sv chưa?
-->Nếu rồi thì đưa ra TB Mã lỗi 2, ngược lại đưa về mã lỗi 0.
go
create proc sp_VD11(@MaSV nchar(10),@HoTen nvarchar(30),@QueQuan nvarchar(30),@GioiTinh nchar(10),@NgaySinh date,@MaLop nchar(10),@Returned int output)
as
begin
	if(not exists(select *from Lop where MaLop = @MaLop))
		set @Returned = 1
	else if(exists(select *from SinhVien where MaSV = @MaSV))
		set @Returned = 2
	else
		begin
			insert into SinhVien values(@MaSV,@HoTen,@GioiTinh,@QueQuan,@NgaySinh,@MaLop)
		set @Returned =0
		end
	return @Returned
end
go
go
declare @x int
exec sp_VD11 'SV01',N'Nguyễn Văn Anh',N'Nghệ An',N'Nam','09-30-2005','IT01',@x output
select @x
go
go
declare @x int
exec sp_VD11 'SV07',N'Nguyễn Văn Anh',N'Nghệ An',N'Nam','09-30-2005','IT07',@x output
select @x
go
go
declare @x int
exec sp_VD11 'SV035',N'Nguyễn Văn Anh',N'Nghệ An',N'Nam','09-30-2005','CP04',@x output
select @x
go

go
create proc sp_VD12(@MaLop nchar(10),@TenLop nvarchar(30),@Phong nvarchar(30),@MaGV nchar(10),@Returned int output)
as
begin 
	if(not exists(select *from GiaoVien where MaGV = @MaGV))
		set @Returned = 1
	else if(exists(select *from Lop where TenLop = @TenLop))
		set @Returned = 2
	else
		begin
			insert into Lop values(@MaLop,@TenLop,@Phong,@MaGV)
		set @Returned =0
		end
	return @Returned
end
go

go
declare @y int -- TH2
exec sp_VD12 'MK04',N'Marketing 03','909','GV05',@y output
select @y
go
declare @y int -- TH1
exec sp_VD12 'MK04',N'Marketing 03','909','GV010',@y output
select @y
go
declare @y int -- TH3
exec sp_VD12 'MK06',N'Marketing 09','909','GV05',@y output
select @y
go