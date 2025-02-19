use master
go
create database SVUniversity
go
go
use SVUniversity
	create table GiaoVien(
		MaGV nchar(10) not null primary key,
		HoTen nvarchar(30) not null,
		SoDT nvarchar(20)
	)
	create table Lop(
		MaLop nchar(10) not null primary key,
		TenLop nvarchar(30) not null,
		Phong nvarchar(30),
		MaGV nchar(10)
	)
	create table SinhVien(
		MaSV nchar(10) not null primary key,
		HoTen nvarchar(30) not null,
		QueQuan nvarchar(30),
		GioiTinh nchar(10),
		NgaySinh date,
		MaLop nchar(10)
	)
go
go
insert into GiaoVien values('GV01',N'Trần Mai Linh','0976556459')
insert into GiaoVien values('GV02',N'Phạm Thanh Hùng','0347223910')
insert into GiaoVien values('GV03',N'Nguyễn Chiến Thăng','0806556459')
insert into GiaoVien values('GV04',N'Đỗ Huyền Trang','0941772342')
insert into GiaoVien values('GV05',N'Hoàng Duy Khánh','0576556459')
delete from GiaoVien
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
go
--> Tạo view đưa ra Quê Quán và số Sinh Vien trong từng nơi
go
	create view vw_VD1
		as
		select QueQuan,count(*) as N'Số SV' from SinhVien
		group by QueQuan
go
	select *from vw_VD1

--> vd: Sửa Thông tin của sinh viên có mã là 'SV04' Quê quán thành 'Nghệ An' và Mã lớp thành 'CP04'
update SinhVien set QueQuan = N'Nghệ An', MaLop = 'CP04' where MaSV = 'SV04'
--> vd: Sửa thông tin tên lớp Hệ Thống Thông Tin 02 có mã thành 'IT10'
update SinhVien set MaLop = 'IT10' where MaLop = (select MaLop from Lop where TenLop = N'Hệ Thống Thông Tin 02')
update Lop set MaLop = 'IT10' where TenLop = N'Hệ Thống Thông Tin 02'
select *from SinhVien where MaLop = (select MaLop from Lop where TenLop = N'Hệ Thống Thông Tin 02')

-->vd4. viết 1 thủ tục thêm mới 1 sinh viên, với các tham biến
--masv,hoten,quequan,gioitinh,ngaysinh,tenlop nhập từ bàn phím.
--hãy kiểm tra xem tenlop có trong bảng Lớp hay không? Nếu không thì đưa ra
--thông báo. Hãy kiểm tra xem masv đã tồn tại trong bảng sv chưa?
--Nếu rồi thì đưa ra TB trùng.
go
create proc sp_VD4(@MaSV nchar(10),@HoTen nvarchar(30),@QueQuan nvarchar(30),@GioiTinh nchar(10)
		,@NgaySinh date,@TenLop nvarchar(30))
as
begin
	if(not exists(select *from Lop where TenLop = @TenLop))
		print(N'Không có tên lớp trong danh sách')
	else if(exists(select *from SinhVien where MaSV = @MaSV))
		print(N'Đã tồn tại mã sinh viên trong danh sách')
	else
		begin
			declare @MaLop nchar(10)
			set @MaLop = (select MaLop from Lop where TenLop = @TenLop)
			insert into SinhVien values(@MaSV,@HoTen,@QueQuan,@GioiTinh,@NgaySinh,@MaLop)
			print(N'Đã thêm trong danh sách')
		end
end
go
exec sp_VD4 'SV090',N'Nguyễn Văn Anh',N'Nghệ An',N'Nam','09-30-2005',N'Hệ Thống Thông Tin 02'