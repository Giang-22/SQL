use master
go
	create database HangBan
go
go
	use HangBan	
		create table Hang(
			MaHang nchar(10) not null primary key,
			TenHang nvarchar(30) not null,
			SoLuong int,
			GiaBan money
		)
		create table HoaDon(
			MaHD nchar(10) not null primary key,
			MaHang nchar(10) not null,
			SoLuongBan int,
			NgayBan date
		)
go
go
	alter table HoaDon add constraint fk_HD_H foreign key (MaHang)
		references Hang(MaHang)
go
go
	insert into Hang values('H001',N'Bút Chì',30000,5000)
	insert into Hang values('H002',N'Vở Kẻ Ngang',20000,10000)
	insert into Hang values('H003',N'Bút Bi',40000,6000)

	insert into HoaDon values('HD01','H005',2000,'02-13-2025') --> Không tồn tại mã hàng đó
	insert into HoaDon values('HD01','H003',1000,'01-22-2025') --> Thêm Thành Công

go

select *from Hang
select *from HoaDon

go
	create trigger trg_Cau1
	on HoaDon
	for insert 
	as
	begin
		declare @MaHang nchar(10)
		set @MaHang = (select MaHang from inserted)
		if(not exists(select *from Hang where MaHang = @MaHang))
			begin
				raiserror(N'Không tồn tại mã hàng đó',16,1)
				rollback transaction
			end
		else
			begin
				declare @SoLuongCo int
				set @SoLuongCo = (Select SoLuong from Hang where MaHang = @MaHang)
				declare @SoLuongMua int
				set @SoLuongMua = (select SoLuongBan from inserted)
				if(@SoLuongCo < @SoLuongMua)
					begin
						raiserror(N'Số lượng hàng không đủ',16,1)
						rollback transaction
					end
				else
					update Hang set SoLuong = @SoLuongCo - @SoLuongMua where MaHang = @MaHang
			end
	end
go