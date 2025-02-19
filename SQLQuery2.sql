use master
go
create database QLYSach
go
go
	use QLYSach
		create table NhaXuatBan(
			MaNXB nchar(10) not null primary key,
			TenNXB nvarchar(30) not null,
			SoLuongXB int,
		)
		create table TacGia(
			MaTG nchar(10) not null primary key,
			TenTG nvarchar(30) not null,
		)
		create table Sach(
			MaSach nchar(10) not null primary key,
			TenSach nvarchar(30) not null,
			NamXB int,
			SoLuong int,
			DonGia money,
			MaTG nchar(10),
			MaNXB nchar(10)
		)
go
go
	alter table Sach add constraint fk_S_TG foreign key (MaTG)
		references TacGia(MaTG)
	alter table Sach add constraint fk_S_NXB foreign key (MaNXB)
		references NhaXuatBan(MaNXB)
go
go
	insert into TacGia values('TG01',N'Nguyễn Chiến Thắng')
	insert into TacGia values('TG02',N'Hồ Quỳnh Trang')

	insert into NhaXuatBan values('NXB1',N'Thăng Long',10000)
	insert into NhaXuatBan values('NXB2',N'Hồng Hà',15000)

	insert into Sach values('S001',N'Kiến trúc máy tính',1990,1000,20000,'TG01','NXB2')
	insert into Sach values('S002',N'Hệ điều hành',1989,3000,15000,'TG01','NXB1')
	insert into Sach values('S003',N'Lý thuyết sác xuất',1991,800,20000,'TG02','NXB2')
	insert into Sach values('S004',N'Ứng dụng thuật toán',1990,2000,30000,'TG02','NXB1')
	insert into Sach values('S005',N'Java căn bản',1991,1000,50000,'TG01','NXB1')
	insert into Sach values('S006',N'Cấu trúc dữ liệu',1988,900,10000,'TG02','NXB2')
go
delete from Sach
select *from TacGia
select *from NhaXuatBan
select *from Sach

--Câu 2
go
	create view vw_Cau2
	as
		select distinct Sach.MaNXB,TenNXB,sum(SoLuong) as N'SL'
		from Sach inner join NhaXuatBan on Sach.MaNXB = NhaXuatBan.MaNXB
		group by Sach.MaNXB,TenNXB
go
select *from vw_Cau2
--Câu 3
go
	create function fn_Cau3(@TenNXB nvarchar(30),@Start int,@Finish int)
	returns @Table3 table(
		MaSach nchar(10),
		TenSach nvarchar(30),
		TenTG nvarchar(30),
		DonGia money
	)
	as
	begin
		insert into @Table3
			select MaSach, TenSach, TenTG, DonGia from Sach
			inner join TacGia on Sach.MaTG = TacGia.MaTG 
			inner join NhaXuatBan on Sach.MaNXB = NhaXuatBan.MaNXB
			where TenNXB = @TenNXB and NamXB between @Start and @Finish
		return
	end
go
select *from fn_Cau3 (N'Thăng Long',1990,1991)

--Câu 4
go
	create proc sp_Cau4(@MaSach nchar(10))
	as
	begin
		if(not exists(select *from Sach where MaSach = @MaSach))
			print(N'Không tồn tại mã sách đó')
		else
			begin
				delete from Sach where MaSach = @MaSach
			end
	end
go
--Khả năng 1
exec sp_Cau4 'S009'
--Khả năng 2
exec sp_Cau4 'S002'
select *from Sach

go
alter proc sp_Cau5(@MaSach nchar(10),@TenSach nvarchar(30),@TenTG nvarchar(30))
as
begin 
	if(not exists(select *from TacGia where TenTG = @TenTG))
		print(N'Không có tác giả đó')
	else
		begin
			declare @MaTG nchar(10)
			set @MaTG = (select MaTG from TacGia where TenTG = @TenTG)
			delete from Sach where MaTG = @MaTG and MaSach = @MaSach and TenSach = @TenSach
			print(N'Xóa thành công')
		end
end
go
exec sp_Cau5 'S001',N'Kiến trúc máy tính',N'Nguyễn Chiến Thắng'