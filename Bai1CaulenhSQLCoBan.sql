
create database QLBanHang
use QLBanHang
create table SanPham(
	MaSP nchar(10) not null primary key,
	MaHangSX nchar(10) not null,
	TenSP nvarchar(30),
	SoLuong int,
	MauSac nchar(10),
	GiaBan money,
	DonViTinh nchar(20),
	MoTa text
)
create table HangSX(
	MaHangSX nchar(10) not null primary key,
	TenHang nvarchar(30) not null,
	DiaChi nvarchar(30),
	SoDT nchar(10),
	Email nvarchar(20)
)
create table NhanVien(
	MaNV nchar(10) not null primary key,
	TenNV nvarchar(30),
	GioiTinh nchar(10),
	DiaChi nvarchar(30),
	SoDT nchar(10),
	Email nvarchar(30),
	TenPhong text
)
create table Nhap(
	SoHDN nchar(10) not null,
	MaSP nchar(10) not null,
	SoLuongN int,
	DonGiaN money
)
create table PNhap(
	SoHDN nchar(10) not null primary key,
	NgayNhap date,
	MaNV nchar(10) not null
)
create table Xuat(
	SoHDX nchar(10) not null,
	MaSP nchar(10) not null,
	SoLuongX int
)
create table PXuat(
	SoHDX nchar(10) not null primary key,
	NgayXuat date,
	MaNV nchar(10) not null
)

alter table SanPham add constraint fk_SP_HSX foreign key(MaHangSX)
	references HangSX(MaHangSX)
alter table Nhap add constraint pk_NHAP primary key(SoHDN,MaSP)
alter table Nhap add constraint fk_N_PN foreign key(SoHDN)
	references PNhap(SoHDN)
alter table Xuat add constraint pk_XUAT primary key(SoHDX,MaSP)
alter table Xuat add constraint fk_X_PX foreign key(SoHDX)
	references PXuat(SoHDX)
alter table	Nhap add constraint fk_N_SP foreign key(MaSP)
	references SanPham(MaSP)
alter table	Xuat add constraint fk_X_SP foreign key(MaSP)
	references SanPham(MaSP)
alter table	PNhap add constraint fk_PN_NV foreign key(MaNV)
	references NhanVien(MaNV)
alter table	PXuat add constraint fk_PX_NV foreign key(MaNV)
	references NhanVien(MaNV)

insert into HangSX values('H02','iPhone',N'Hà Nội','0123456','HoCQ@onmicrosoft.com')
insert into HangSX values('H01','iPad',N'Sài Gòn','0130004','CQHo@onmicrosoft.com')
insert into HangSX values('H05','iPod',N'Đà Nẵng','0388447','AACH@onmicrosoft.com')
insert into HangSX values('H04','iMac',N'Nghệ An','0566666','CB@onmicrosoft.com')
delete from HangSX
select * from HangSX

insert into SanPham values('SP01','H02','Sản Phẩm A',10,N'Đỏ',17000,'Cái','None')
insert into SanPham values('SP02','H02','Sản Phẩm B',30,N'Vàng',72000,'Cái','None')
insert into SanPham values('SP03','H04','Sản Phẩm C',15,N'Tím',52000,'Cái','None')
delete from SanPham
select * from SanPham

insert into NhanVien values('NV01',N'Hồ Cảnh Quý','Nam',N'Xuân Phương','0344324','Hoquymail',N'Kế Toán')
insert into NhanVien values('NV02',N'Nguyen Xuan Son','Nam',N'Phương Canh','03445556','Xuansymail',N'Nhân Sự')
insert into NhanVien values('NV03',N'Vũ Duy Việt','Nam',N'Minh Khai','0456666','Viemkmail',N'Tài Chính')
delete from NhanVien
select *from NhanVien

insert into PNhap values('HDN01','2002-03-02','NV01')
INSERT INTO PNhap VALUES ('HDN02', '2002-07-22', 'NV03')
INSERT INTO PNhap VALUES ('HDN03', '2002-09-16', 'NV02')
INSERT INTO PNhap VALUES ('HDN04', '2002-12-02', 'NV01')
INSERT INTO PNhap VALUES ('HDN05', '2002-04-23', 'NV02')
select *from PNhap
select MaNV as N'Mã nhân viên',count(*) as N'Số hoạt động' from PNhap 
group by MaNV

insert into PXuat values('HDX01','2005-12-12','NV01')
INSERT INTO PXuat VALUES ('HDX02', '2012-07-12', 'NV03')
INSERT INTO PXuat VALUES ('HDX03', '2003-09-16', 'NV02')
INSERT INTO PXuat VALUES ('HDX04', '2009-12-02', 'NV01')
INSERT INTO PXuat VALUES ('HDX05', '2008-04-23', 'NV02')
delete from PXuat
select *from PXuat


