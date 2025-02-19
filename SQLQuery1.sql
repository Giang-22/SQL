use master
go
	create database QLSach
go
go
	use QLSach
		create table NhaXB(
			MaNXB nchar(10) not null primary key,
			TenNXB nvarchar(30) not null,
			SoLuongXB int
		)
		create table TacGia(
			MaTG nchar(10) not null primary key,
			TenTG nvarchar(30) not null,
			SoLuongXB int
		)
		create table Sach(
			MaSach nchar(10) not null primary key,
			TenSach nvarchar(30) not null,
			MaNXB nchar(10),
			MaTG nchar(10),
			NamXB date,
			SoLuong int,
			DonGia money
		)
go
go
	alter table Sach add constraint fk_Sach_TacGia foreign key(MaTG)
		references TacGia(MaTG)
	alter table Sach add constraint fk_Sach_NXB foreign key(MaNXB)
		references NhaXB(MaNXB)
go
go
	insert into NhaXB values('NXB1',N'Hồng Hà',30000)
	insert into NhaXB values('NXB2',N'Thiên Long',20000)
	insert into NhaXB values('NXB3',N'Delli',40000)

	insert into TacGia values('TG01',N'Hà Xuân Quân',1000)
	insert into TacGia values('TG02',N'Vù Hà Thành',2000)
	insert into TacGia values('TG03',N'Trần Văn Huy',1500)

	insert into Sach values('S003',N'Kiến trúc máy tính','NXB5','TG03','12-04-1991',100,40000) --> Chưa tồn tại
	insert into Sach values('S001',N'Hệ thống máy tính','NXB1','TG01','08-30-1992',300,30000) -->chèn thành công
	insert into Sach values('S004',N'An ninh mạng','NXB2','TG03','08-30-1992',600,50000)
	insert into Sach values('S002',N'Quản lý bộ nhớ','NXB3','TG02','04-10-1992',50000,20000) --> Không đủ số lượng

	

go

select *from NhaXB
select *from TacGia
select *from Sach

go
	create proc sp_VD2(@TenNXB nvarchar(30))
	as
	begin
		if(not exists(select *from NhaXB where TenNXB = @TenNXB))
			print(N'Không có tên Nhà Xuất Bản đó')
		else
			begin
				select NhaXB.MaNXB, TenNXB, sum(SoLuong * DonGia) as N'Tiền Bán'
				from NhaXB inner join Sach on Sach.MaNXB = NhaXB.MaNXB
				where TenNXB = @TenNXB
				group by NhaXB.MaNXB,TenNXB
			end
	end
go	

exec sp_VD2 N'Hồng Hà'

go
	alter function fn_VD3(@TenTG nvarchar(30))
	returns money
	as
	begin 
		declare @TienBan money
		set @TienBan = (select sum(SoLuong *DonGia) from Sach
						inner join TacGia on Sach.MaTG = TacGia.MaTG
						where TenTG = @TenTG group by TenTG)
		return @TienBan
	end
go
select dbo.fn_VD3(N'Trần Văn Huy') as N'Tiền Bán'

go
	create trigger trg_Cau4
	on Sach
	for insert
	as
	begin
		declare @MaNXB nchar(10)
		set @MaNXB = (select MaNXB from inserted)
		if(not exists(select *from NhaXB where MaNXB = @MaNXB))
			begin 
				raiserror(N'Chưa tồn tại Mã NXB',16,1)
				rollback transaction
			end
		else
			begin
				declare @SoLuongMua int
				set @SoLuongMua = (select SoLuong from inserted)
				declare @SoLuongCo int
				set @SoLuongCo  = (select SoLuongXB from NhaXB where MaNXB = @MaNXB)
				if(@SoLuongCo < @SoLuongMua)
					begin
						raiserror(N'Số lượng có không đủ',16,1)
						rollback transaction
					end
				else
				update NhaXB set SoLuongXB = @SoLuongCo - @SoLuongMua where MaNXB = @MaNXB
			end
	end
go


