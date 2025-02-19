use master
go
	create database BanHang
go
go
	use BanHang
		create table MatHang(
			MaHang nchar(10) not null primary key,
			TenHang nvarchar(30)  not null,
			SoLuong int
		)
		create table NhatKyBanHang(
			STT int,
			Ngay date,
			NguoiMua nvarchar(30),
			MaHang nchar(10),
			SoLuong int,
			GiaBan money
		)
go
	alter table NhatKyBanHang add constraint fk_NK_MH foreign key (MaHang)
		references MatHang(MaHang)
go
go
	insert into MatHang values('H001',N'Kẹo',1000)
	insert into MatHang values('H002',N'Bánh',2000)
	insert into MatHang values('H003',N'Nước',4000)
	delete from MatHang
	insert into NhatKyBanHang values(1,'02-10-2025',N'Trịnh Cảnh Quý','H002',400,5000)
	insert into NhatKyBanHang values(2,'02-13-2025',N'Trịnh Hồ Quý','H001',200,10000)
	insert into NhatKyBanHang values(3,'02-14-2025',N'Trịnh Trần Quý','H003',500,9000)
	insert into NhatKyBanHang values(4,'02-09-2025',N'Trịnh Phương Quý','H003',1000,9000)
	update NhatKyBanHang set SoLuong = 900 where MaHang = 'H002'
	delete from NhatKyBanHang where MaHang = 'H002'
go

select *from NhatKyBanHang
select *from MatHang

go
	create trigger trg_nhatkybanhang_insert
	on NhatKyBanHang
	for insert
	as
	begin
		declare @MaHang nchar(10)
		set @MaHang = (select MaHang from inserted)
		if(not exists(select * from MatHang where MaHang = @MaHang))
			begin
				raiserror(N'Không tồn tại mã hàng đó',16,1)
				rollback transaction
			end
		else
			begin
				declare @SoLuongCo int
				set @SoLuongCo = (select SoLuong from MatHang where MaHang = @MaHang)
				declare @SoLuongMua int
				set @SoLuongMua = (select SoLuong from inserted)
				if(@SoLuongCo<@SoLuongMua)
					begin
						raiserror(N'Không đủ hàng ',16,1)
						rollback transaction
					end
				else
					update MatHang set SoLuong = @SoLuongCo - @SoLuongMua where MaHang = @MaHang
			end
	end
go

go
	create trigger trg_NhatKy_update
	on NhatKyBanHang
	for update
	as
	begin
		declare @MaHang nchar(10)
		set @MaHang = (select MaHang from inserted)
		declare @SoLuongTruoc int
		set @SoLuongTruoc = (select SoLuong from deleted)
		declare @SoLuongSau int
		set @SoLuongSau = (select SoLuong from inserted)
		update MatHang set SoLuong = SoLuong - (@SoLuongSau - @SoLuongTruoc) where MaHang = @MaHang
	end
go

go
	create trigger trg_Cau3
	on NhatKyBanHang
	for delete
	as
	begin
		declare @MaHang nchar(10)
		set @MaHang = (select MaHang from deleted)
		if(not exists(select *from MatHang where MaHang = @MaHang))
			begin
				raiserror(N'Không có mặt hàng cần xóa',16,1)
				rollback transaction
			end
		else
			begin
				declare @SoLuongMua int
				set @SoLuongMua = (select SoLuong from deleted)
				update MatHang set SoLuong = SoLuong + @SoLuongMua where MaHang = @MaHang
			end
	end
go
go
	create proc sp_Caug(@MaHang nchar(10),@Returned int output)
	as
	begin
		if(not exists(select *from MatHang where MaHang = @MaHang))
			set @Returned = 0
		else
			begin
				delete from NhatKyBanHang where MaHang = @MaHang
				delete from MatHang where MaHang = @MaHang
				set @Returned = 1
			end
	end
go
go
select *from NhatKyBanHang
select *from MatHang
declare @x int
exec sp_Caug 'H003',@x output
select @x
go
declare @x int
exec sp_Caug 'H0010',@x output
select @x
go
go
	create function fn_Cauh(@TenHang nvarchar(30))
	returns money
	as
	begin 
		declare @TongTien money
		set @TongTien = (select sum(NhatKyBanHang.SoLuong * GiaBan) from NhatKyBanHang inner join MatHang on
		NhatKyBanHang.MaHang = MatHang.MaHang
		where TenHang = @TenHang
		group by TenHang
		)
		return @TongTien
	end
go

select dbo.fn_Cauh (N'Nước') as N'Tổng Tiền'
