use master
go
create database QLyBanHang
go
use QLyBanHang

create table CongTy(
	MaCT nchar(15) not null primary key,
	TenCT nvarchar(35) not null,
	TrangThai nvarchar(20),
	ThanhPho nvarchar(30)
)
create table SanPham(
	MaSP nchar(15) not null primary key,
	TenSP nvarchar(35) not null unique,
	MauSac nchar(15) default N'Đỏ',
	Gia money,
	SoLuongCo int,
)
create table CungUng(
	MaCT nchar(15) not null,
	MaSP nchar(15) not null,
	SoLuongBan int check (SoLuongBan > 0),
)

alter table CungUng add constraint pk_CungUng primary key(MaCT,MaSP)
alter table CungUng add constraint fk_C_CT foreign key(MaCT)
	references CongTy(MaCT)
alter table CungUng add constraint fk_C_SP foreign key(MaSP)
	references SanPham(MaSP)

insert into CongTy values('CT001', N'TNHH Hoa Quỳnh', N'Đang hoạt động',N'Hà Nội')
insert into CongTy values('CT002', N'AC MPP Quang Thành', N'Dừng hoạt động',N'Vinh-Nghệ An')
insert into CongTy values('CT003', N'MSM Hoàng Hà', N'Đang hoạt động',N'Đà Nẵng')
select * from CongTy

insert into SanPham values('SP191', N'Nước hoa ASPP', N'Trắng',100000,3000)
insert into SanPham values('SP192', N'Máy hút mụn',default, 500000,3000)
insert into SanPham values('SP188', N'Kem chống nắng',N'Đen',90000,10000)
select *from SanPham

insert into CungUng values('CT001','SP188',1200)
insert into CungUng values('CT001','SP191',600)
insert into CungUng values('CT001','SP192',800)
insert into CungUng values('CT002','SP188',7000)
insert into CungUng values('CT002','SP191',1100)
insert into CungUng values('CT002','SP192',800)
insert into CungUng values('CT003','SP188',1000)
insert into CungUng values('CT003','SP191',900)
insert into CungUng values('CT003','SP192',100)
delete from CungUng
select *from CungUng


