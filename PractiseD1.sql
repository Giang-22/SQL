use master
go
	create database QLSach
go
go
	use QLSach	
		create table NhaXuatBan(
			MaNXB nchar(10) not null primary key,
			TenNXB nvarchar(30) not null,
			SoLuongXB int
		)
		create table TacGia(
			MaTG nchar(10) not null primary key,
			TenTG nvarchar(30) not null
		)
		create table Sach(
			MaSach nchar(10) not null primary key,
			TenSach nvarchar(30) not null,
			NamXB int,
			SoLuong int,
			DonGia money,
			MaTG nchar(10),
			MaNXB nchar(10),
		)
go
go
	alter table Sach add constraint fk_S_TG foreign key (MaTG)
		references TacGia(MaTG)
	alter table Sach add constraint fk_S_NXB foreign key (MaNXB)
		references NhaXuatBan(MaNXB)
go
go
	insert into NhaXuatBan values('NXB1',N'Hồng Hà',10000)
	insert into NhaXuatBan values('NXB2',N'Thăng Long',20000)

	insert into TacGia values('TG01',N'Nguyễn Văn Việt')
	insert into TacGia values('TG02',N'Hoàng Duy Khánh')

	insert into Sach values('S01',N'Sóng Gió',1990,1000,30000,'TG02','NXB1')
	insert into Sach values('S02',N'Bạc Phận',1980,2000,20000,'TG01','NXB1')
	insert into Sach values('S03',N'LightStick Quý 03',1991,500,150000,'TG01','NXB2')
	insert into Sach values('S04',N'Hồng Nhan',1990,2000,30000,'TG02','NXB2')
	insert into Sach values('S05',N'Hoa Hải Đường',1980,4000,30000,'TG01','NXB1')
	insert into Sach values('S06',N'Về Bên Quý',1990,1000,30000,'TG02','NXB1')
go
delete from Sach
select *from TacGia
select *from NhaXuatBan
select *from Sach

--Cau3
go
	create function fn_Cau3(@TenNXB nvarchar(30),@x int,@y int)
	returns @TableCau3 table(
		MaSach nchar(10),
		TenSach nvarchar(30),
		TenTG nvarchar(30),
		DonGia money
	)
	as
	begin
		insert into @TableCau3
			select MaSach, TenSach, TenTG, DonGia from Sach 
			inner join TacGia on Sach.MaTG = TacGia.MaTG
			inner join NhaXuatBan on Sach.MaNXB = NhaXuatBan.MaNXB
			where TenNXB = @TenNXB and NamXB between @x and @y
		return
	end
go
select *from fn_Cau3 (N'Hồng Hà',1985,1992)

--Cau4
go
	create proc sp_Cau4(@MaSach nchar(10),@Returned int output)
	as
	begin
		if(not exists(select *from Sach where MaSach = @MaSach))
			set @Returned = 1
		else
			begin
				Delete from Sach where MaSach = @MaSach
				set @Returned = 0;
			end
	end
go
go
declare @x int
exec sp_Cau4 'S08',@x output
select @x as 'Return'
go
go
declare @x int
exec sp_Cau4 'S05',@x output
select @x as 'Return'
go
select *from Sach

--Cau31
go
	create function fn_Cau31(@TenTG nvarchar(30))
	returns money
	as
	begin
		declare @TienBan money
		set @TienBan = (select sum(SoLuong*DonGia) as 'TienBan' from Sach 
			inner join TacGia on Sach.MaTG = TacGia.MaTG
		where TenTG = @TenTG
		)
		return @TienBan
	end
go

select dbo.fn_Cau31 (N'Hoàng Duy Khánh') as 'Tổng tiền'

go
	create proc sp_Cau21(@TenNXB nvarchar(30),@Returned int output)
	as
	begin
		if(not exists(select *from NhaXuatBan where TenNXB = @TenNXB))
			set @Returned = 1
		else
			begin
				select NhaXuatBan.MaNXB,TenNXB, sum(SoLuong * DonGia) from Sach
				inner join NhaXuatBan on Sach.MaNXB = NhaXuatBan.MaNXB
				where TenNXB = @TenNXB
				group by NhaXuatBan.MaNXB,TenNXB
				set @Returned = 0
			end
	end
go

declare @y int
exec sp_Cau21 N'Hồng Hà',@y output
select @y

go
	create trigger trg_Cau4
	on Sach
	for insert
	as
	begin
		declare @MaNXB nchar(10)
		set @MaNXB = (select MaNXB from inserted)
		if(not exists(select *from NhaXuatBan where MaNXB = @MaNXB))
			begin
				raiserror(N'Không có nhà xuất bản đó',16,1)
				rollback transaction
			end
		else
			begin
				declare @SoLuongXB int
				set @SoLuongXB = (select SoLuong from Sach where MaNXB = @MaNXB)
				declare @SoLuongCo int
				set @SoLuongCo = (select SoLuongXB from NhaXuatBan where MaNXB = @MaNXB)
				if(@SoLuongCo < @SoLuongXB)
					begin
						raiserror(N'Không đủ số lượng để xuất bản',16,1)
						rollback transaction
					end
				else
					update NhaXuatBan set SoLuongXB = @SoLuongCo - @SoLuongXB where MaNXB = @MaNXB
			end
	end
go