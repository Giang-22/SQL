use master
go
	create database QLSV
go
go
	use QLSV
		create table SinhVien(
			MaSV nchar(10) not null primary key,
			HoTen nvarchar(30) not null,
			QueQuan nvarchar(30),
			MaLop nchar(10)
		)
		create table Lop(
			MaLop nchar(10) not null primary key,
			TenLop nvarchar(30) not null,
			SiSo int
		)
go
go
	alter table SinhVien add constraint fk_SV_Lop foreign key (MaLop)
		references Lop(MaLop)
go
	insert into Lop values('IT01',N'Công Nghệ Thông Tin 01',50)
	insert into Lop values('IT05',N'Khoa Học Máy Tính 03',68)
	insert into Lop values('IT07',N'Công Nghệ Đa Phương Tiện',75)

	insert into SinhVien values('SV01',N'Trịnh Trần Phương Quý',N'Bến Tre','IT01')
	insert into SinhVien values('SV04',N'Trịnh Trần Phương Quý',N'Bến Tre','IT01')
	insert into SinhVien values('SV05',N'Trịnh Trần Phương Quý',N'Bến Tre','IT01')

	delete from SinhVien where MaSV = 'SV01'
	update SinhVien set MaLop = 'IT05' where MaSV = 'SV04'
go

select *from Lop
select *from SinhVien

go
go
	alter trigger trg_Cau1
	on SinhVien
	for insert
	as
	begin
		declare @MaLop nchar(10)
		set @MaLop = (select MaLop from inserted)
		if(not exists(select *from Lop where MaLop = @MaLop))
			begin
				raiserror(N'Không tồn tại mã lớp đó',16,1)
				rollback transaction
			end
		else
			begin
				declare @SiSo int
				set @SiSo = (select SiSo from Lop where MaLop = @MaLop)
				if(@SiSo > 70)
					begin
						raiserror(N'Sĩ số quá 70',16,1)
						rollback transaction
					end
				else
					update Lop set SiSo = SiSo + 1 where MaLop = @MaLop
			end
	end
go

go
	create trigger trg_Cau2
	on SinhVien
	for delete 
	as
	begin
		declare @MaLop nchar(10)
		set @MaLop = (select MaLop from deleted)
		declare @SiSo int
		set @SiSo = (select SiSo from Lop where MaLop = @MaLop)
		update Lop set SiSo = SiSo - 1 where MaLop = @MaLop
	end	
go

go
	create trigger trg_Cau3
	on SinhVien
	for update
	as
	begin
		declare @MaLopCu nchar(10)
		set @MaLopCu = (select MaLop from deleted)
		declare @MaLopMoi nchar(10)
		set @MaLopMoi = (select MaLop from inserted)
		declare @SiSo int
		set @SiSo = (select SiSo from Lop where MaLop = @MaLopMoi)
		if(@SiSo +1 >70)
			begin
				raiserror(N'Sĩ số quá 70',16,1)
				rollback transaction
			end
		else
			begin
				update Lop set SiSo = SiSo - 1 where MaLop =@MaLopCu
				update Lop set SiSo = SiSo + 1 where MaLop =@MaLopMoi
			end
	end
go