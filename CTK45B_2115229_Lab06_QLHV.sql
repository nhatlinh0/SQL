/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Nguyễn Nhật Linh
   MSSV: 2115229
   Lớp: CTK45B
   Ngày bắt đầu: 23/02/2023
   Ngày kết thúc: ?????
*/	

create database Lab06_QLHV
go
use Lab06_QLHV
go

create table CaHoc
(Ca tinyint primary key,
GioBatDau datetime,
GioKetThuc datetime
)
go

create table GiaoVien
(MSGV char(4) primary key,
HoGV nvarchar(20),
TenGV nvarchar(10),
DienThoai char(10)
)
go

create table Lop
(MaLop char(4) primary key,
TenLop char(20),
NgayKG datetime,
HocPhi int,
Ca tinyint references CaHoc(Ca),
SoTiet int,
SoHV int,
MSGV char(4) references GiaoVien(MSGV)
)
go

create table HocVien 
(MSHV char(6) primary key,
Ho nvarchar(20),
Ten nvarchar(10),
NgaySinh datetime,
Phai nvarchar(7),
MaLop char(4) references Lop(MaLop)
)
go

create table HocPhi
(SoBL char(4) primary key,
MSHV char(6) references HocVien(MSHV),
NgayThu date,
SoTien int,
NoiDung char(20),
NguoiThu nvarchar(5)
)
go

insert into CaHoc values (1,'7:30','10:45')
insert into CaHoc values (2,'13:30','16:45')
insert into CaHoc values (3,'17:30','20:45')
select * from CaHoc

insert into GiaoVien values ('G001',N'Lê Hoàng',N'Anh','858936')
insert into GiaoVien values ('G002',N'Nguyễn Ngọc',N'Lan','845623')
insert into GiaoVien values ('G003',N'Trần Minh',N'Hùng','823456')
insert into GiaoVien values ('G004',N'Võ Thanh',N'Trung','841256')
select * from GiaoVien

set dateformat dmy

insert into Lop values ('E114','Excel 3-5-7','02/01/2008',120000,1,45,3,'G003')
insert into Lop values ('E115','Excel 2-4-6','22/01/2008',120000,3,45,0,'G001')
insert into Lop values ('W123','Word 2-4-6','18/02/2008',100000,3,30,1,'G001')
insert into Lop values ('W124','Word 3-5-7','01/03/2008',100000,1,30,0,'G002')
insert into Lop values ('A075','Access 2-4-6','18/02/2008',150000,3,60,3,'G003')
select * from Lop

insert into HocVien values ('A07501',N'Lê Văn',N'Minh','10/06/1998','Nam','A075')
insert into HocVien values ('A07502',N'Nguyễn Thị',N'Mai','20/04/1998','Nữ','A075')
insert into HocVien values ('A07503',N'Lê Ngọc',N'Tuấn','10/06/1994','Nam','A075')
insert into HocVien values ('E11401',N'Vương Tuấn',N'Vũ','25/03/1999','Nam','E114')
insert into HocVien values ('E11402',N'Lý Ngọc',N'Hân','01/12/1995','Nữ','E114')
insert into HocVien values ('E11403',N'Trần Mai',N'Linh','04/06/1990','Nữ','E114')
insert into HocVien values ('W12301',N'Nguyễn Ngọc',N'Tuyết','12/05/1996','Nữ','W123')
select * from HocVien

insert into HocPhi values ('0001','E11401','02/01/2008',120000,'HP Excel 3-5-7',N'Vân')
insert into HocPhi values ('0002','E11402','02/01/2008',120000,'HP Excel 3-5-7',N'Vân')
insert into HocPhi values ('0003','E11403','02/01/2008',80000,'HP Excel 3-5-7',N'Vân')
insert into HocPhi values ('0004','W12301','18/02/2008',100000,'HP Word 2-4-6',N'Lan')
insert into HocPhi values ('0005','A07501','16/12/2008',150000,'HP Access 2-4-6',N'Lan')
insert into HocPhi values ('0006','A07502','16/12/2008',100000,'HP Access 2-4-6',N'Lan')
insert into HocPhi values ('0007','A07503','18/12/2008',150000,'HP Access 2-4-6',N'Vân')
insert into HocPhi values ('0008','A07502','15/01/2009',50000,'HP Access 2-4-6',N'Vân')
select * from HocPhi

select * from CaHoc
select * from GiaoVien
select * from Lop
select * from HocVien
select * from HocPhi

-------------------Hàm & thủ tục----------------------
--4)
a)
Create trigger tr_CaHoc_ins_upd_GioBD_GioKT
On CaHoc  for insert, update
As
if  update(GioBatDau) or update (GioKetThuc)
	     if exists(select * from inserted i where i.GioKetThuc<i.GioBatDau)	
	      begin
	    	 raiserror (N'Giờ kết thúc ca học không thể nhỏ hơn giờ bắt đầu',15,1)
		     rollback tran
	      end
go	

b)
create trigger trg_Lop_ins_upd
on Lop for insert,update
AS
if Update(MaLop) or Update(SoHV)
Begin
	if exists(select * from inserted i where i.SOHV>30) 
	begin
		raiserror (N'Số học viên của một lớp không quá 30',15,1)--Thông báo lỗi cho người dùng
		rollback tran --hủy bỏ thao tác thêm lớp học
	end
	if exists (select * from inserted l 
	              where l.SOHV <> (select count(MSHV) 
									from HocVien 
									where HocVien.Malop = l.Malop))
	begin
		raiserror (N'Số học viên của một lớp không bằng số lượng học viên tại lớp đó',15,1)--Thông báo lỗi cho người dùng
		rollback tran --hủy bỏ thao tác thêm lớp học
	end
End
	
Go

c)
alter trigger tr_TongSoTienThu_ins_usd
on HocPhi for insert, update
as 
begin 
	if update(SoTien) 
	begin
		if exists(select * from inserted i where i.SoTien > 
		(select HocPhi from Lop A, HocVien B where A.MaLop = B.MaLop and B.MSHV = i.MSHV))
			begin
				raiserror(N'Học phí của học viên không được vượt quá học phí của lớp',15,1)
				rollback tran
			end
	end
end

update HocPhi set SoTien = 200000 where MSHV = 'E11401'


--5)
--a) Đã xong
--b)
create proc usp_CapNhatThongTinHV
@MaHV char(7)
as
begin 
	if exists(select * from HocVien where MSHV = @MaHV)
		update HocVien set Ten=N'Linh' where MSHV = @MaHV
	else
		print N'Không tìm thấy học viên'
end

exec usp_CapNhatThongTinHV 'E11401'
--c)
create proc usp_XoaHV
@MaHV char(7) 
as
begin
	if exists (select * from HocVien where MSHV = @MaHV)
		delete HocVien where MSHV = @MaHV
	else
		print N'Không tìm thấy học viên'
end

exec usp_XoaHV 'E11401'
--d)
create proc usp_CapNhatLop
@MaLop char(4)
as
begin
	if exists (select * from Lop where MaLop = @MaLop)
		update Lop set TenLop = 'ABC' where MaLop = @MaLop
	else
		print N'Không tìm thấy lớp'
end

exec usp_CapNhatLop 'E114'
--e)
create proc usp_XoaLopKhongCoHV
as
begin
	delete Lop where SoHV = 0
end

exec usp_XoaLopKhongCoHV
--f)
create proc usp_LapDSHV
@MaLop char(4)
as
begin	
	if exists(select * from Lop where MaLop = @MaLop)
		begin
			select B.MSHV, Ho, Ten, NgaySinh, Phai, B.MaLop
			from Lop A, HocVien B
			where A.MaLop = B.MaLop and A.MaLop = @MaLop
		end
	else 
		print N'Không tìm thấy lớp'
end

exec usp_LapDSHV 'E114' 

--g)
create proc usp_LapDSHVChuaDongHocPhi
as
begin
	select * 
	from HocVien
	where MSHV not in (select MSHV from HocPhi)
end

exec usp_LapDSHVChuaDongHocPhi

--6)
--a)
create function fn_TongHocPhi(@MaLop char(4))
returns int
as
begin
declare @Tong int
	if exists (select * from Lop where MaLop = @MaLop)
		begin
			select @Tong = sum(SoTien)
			from Lop A, HocVien B, HocPhi C
			where A.MaLop = B.MaLop and B.MSHV = C.MSHV and A.MaLop = @MaLop
		end
	else 
		set @Tong = 0 
	return @Tong
end

print dbo.fn_TongHocPhi('E114')

--b)
create function fn_TongHocPhiTrongKhoangThoiGian(@Ngay1 datetime, @Ngay2 datetime)
returns int
as
begin
	declare @Tong int
	select @Tong = sum(SoTien)
	from HocPhi C
	where C.NgayThu between @Ngay1 and @Ngay2
	return @Tong
end

print dbo.fn_TongHocPhiTrongKhoangThoiGian('01/01/2008','02/01/2008')

--c)
create function fn_ChoBietHVDongHocPhiChua(@MaHV char(7))
returns int
as
begin
	declare @bool int 
	set @bool = 0
	if exists (select * from HocPhi where MSHV = @MaHV)
		begin
			set @bool = 1
		end
	return @bool
end

print dbo.fn_ChoBietHVDongHocPhiChua('E11401')

