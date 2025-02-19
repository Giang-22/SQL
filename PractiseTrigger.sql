use master
go
create database QLHoaDon
go
go
use QLHoaDon
	create table SanPham(
		MaSP nchar(10) not null primary key,
		TenSP nvarchar(30) not null,
		MauSac nchar(10),
		SoLuong int,
		GiaBan money
	)
	create table HoaDon(
		SoSH nchar(10) not null,
		MaSP nchar(10) not null,
		SoLuongBan int,
		NgayBan date
	)
go
go
	alter table HoaDon add constraint pk_HD primary key (SoSH,MaSP)
	alter table HoaDon add constraint fk_HD_SP foreign key (MaSP) references SanPham(MaSP)
go

insert into SanPham values('SP01',N'Cookies','Red',900,10000)
insert into SanPham values('SP02',N'Cakes','Blue',1200,50000)
insert into SanPham values('SP03',N'Juices','Red',200,160000)
insert into SanPham values('SP04',N'Sodas','Yellow',400,40000)

insert into HoaDon values('HD1','SP01',1000,'01-02-2025') --> KN2
insert into HoaDon values('HD1','SP04',400,'01-02-2025') --> KN3
insert into HoaDon values('HD2','SP010',100,'02-02-2025') --> KN1
insert into HoaDon values('HD3','SP02',10,'01-02-2025')
insert into HoaDon values('HD4','SP01',100,'02-02-2025')
insert into HoaDon values('HD4','SP02',300,'01-02-2025')
delete from HoaDon
select *from SanPham
select *from HoaDon
delete from HoaDon where SoSH = 'HD3'
update HoaDon set SoLuongBan = 300 where MaSP = 'SP04'
update HoaDon set SoLuongBan = 100 where MaSP = 'SP02'
go
create trigger trg_VD1
on HoaDon
for insert
as
begin
	declare @MaSP nchar(10)
	set @MaSP = (select MaSP from inserted)
	if(not exists(Select *from SanPham where MaSP = @MaSP))
	begin
		raiserror(N'Không có sản phẩm đó',16,1)
		rollback transaction
	end
	else
		begin 
			declare @SoLuongCo int
			declare @SoLuongMua int
			set @SoLuongMua = (select SoLuongBan from inserted)
			set @SoLuongCo = (select SoLuong from SanPham where MaSP = @MaSP)
		if(@SoLuongCo < @SoLuongMua)
			begin
				raiserror(N'Không có đủ Hàng',16,1)
				rollback transaction
			end
		else
			update SanPham set SoLuong = @SoLuongCo - @SoLuongMua where MaSP = @MaSP
		end
end
go
go
create trigger trg_VD2
on HoaDon
for delete 
as
begin
	declare @MaSP nchar(10)
	set @MaSP = (select MaSP from deleted)
	if(not exists(select *from SanPham where MaSP = @MaSP))
	begin
		raiserror(N'Không có sản phẩm cần xoa',16,1)
		rollback transaction
	end
	else
		begin
			declare @SoLuongMua int
			set @SoLuongMua = (Select SoLuongBan from deleted)
			update SanPham set SoLuong = SoLuong + @SoLuongMua where MaSP = @MaSP
		end
end
go

go
alter trigger trg_VD3
on HoaDon
for update 
as
begin
	declare @MaSP nchar(10)
	set @MaSP = (select MaSP from inserted)
	declare @SoLuongTruoc int
	set @SoLuongTruoc = (select SoLuongBan from deleted)
	declare @SoLuongSau int
	set @SoLuongSau = (select SoLuongBan from inserted)
	update SanPham set SoLuong = SoLuong - (@SoLuongSau - @SoLuongTruoc) where MaSP = @MaSP
end
go