/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Nguyễn Nhật Linh
   MSSV: 2115229
   Lớp: CTK45B
   Ngày bắt đầu: 23/02/2023
   Ngày kết thúc: ?????
*/	

CREATE DATABASE Lab02_QLSX
go
use Lab02_QLSX
go

create table ToSanXuat 
(MaTSX char(5) primary key,
TenTSX nvarchar(10)
)
go
create table CongNhan
(MaCN char(5) primary key,
Ho nvarchar(30),
Ten nvarchar(15),
Phai nvarchar(10),
NgaySinh datetime,
MaTSX char(5) references ToSanXuat(MaTSX)
)
go
create table SanPham
(MaSP char(5) primary key,
TenSP nvarchar(15),
DVT nvarchar(7),
TienCong int
)

alter table ThanhPham alter column SoLuong int
go
create table ThanhPham 
(
MaCN char(5) references CongNhan(MaCN),
MaSP char(5) references SanPham(MaSP),
Ngay datetime,
SoLuong int
)
go

insert into ToSanXuat values('TS01',N'Tổ 1')
insert into ToSanXuat values('TS02',N'Tổ 2')
select * from ToSanXuat

set dateformat dmy
go

insert into CongNhan values('CN001',N'Nguyễn Trường',N'An','Nam','12/05/1981','TS01')
insert into CongNhan values('CN002',N'Lê Thị Hồng',N'Gấm',N'Nữ','04/06/1980','TS01')
insert into CongNhan values('CN003',N'Nguyễn Công',N'Thành','Nam','04/05/1981','TS02')
insert into CongNhan values('CN004',N'Võ Hữu',N'Hạnh','Nam','15/02/1980','TS02')
insert into CongNhan values('CN005',N'Lý Thanh',N'Hân',N'Nữ','03/12/1981','TS01')
select * from CongNhan


insert into SanPham values('SP001',N'Nồi đất',N'cái',10000)
insert into SanPham values('SP002',N'Chén',N'cái',2000)
insert into SanPham values('SP003',N'Bình gốm nhỏ',N'cái',20000)
insert into SanPham values('SP004',N'Bình gốm lớn',N'cái',25000)
select * from SanPham

insert into ThanhPham values('CN001','SP001','01/02/2007',10)
insert into ThanhPham values('CN002','SP001','01/02/2007',5)
insert into ThanhPham values('CN003','SP002','10/01/2007',50)
insert into ThanhPham values('CN004','SP003','12/01/2007',10)
insert into ThanhPham values('CN005','SP002','12/01/2007',100)
insert into ThanhPham values('CN002','SP004','13/02/2007',10)
insert into ThanhPham values('CN001','SP003','14/02/2007',15)
insert into ThanhPham values('CN003','SP001','15/01/2007',20)
insert into ThanhPham values('CN003','SP004','14/02/2007',15)
insert into ThanhPham values('CN004','SP002','30/01/2007',100)
insert into ThanhPham values('CN005','SP003','01/02/2007',50)
insert into ThanhPham values('CN001','SP001','20/02/2007',30)
select * from ThanhPham


select * from ToSanXuat
select * from CongNhan
select * from SanPham
select * from ThanhPham

--1)
select TenTSX, Ho+ ' '+Ten as HoTen, NgaySinh,Phai
from ToSanXuat, CongNhan
where ToSanXuat.MaTSX = CongNhan.MaTSX
order by TenTSX, Ten
--2)
select TenSP, Ngay, SoLuong, TienCong as ThanhTien
from SanPham, ThanhPham, CongNhan
where CongNhan.Ho+' '+CongNhan.Ten = N'Nguyễn Trường An' and ThanhPham.MaSP = SanPham.MaSP and ThanhPham.MaCN = CongNhan.MaCN
--3)
select *
from CongNhan
where CongNhan.MaCN not in 
(select MaCN from ThanhPham, SanPham where ThanhPham.MaSP = SanPham.MaSP and SanPham.TenSP = N'Bình gốm lớn')
--4)
select CongNhan.MaCN,Ho,Ten,Phai,NgaySinh,MaTSX
from CongNhan, ThanhPham, SanPham 
where CongNhan.MaCN = ThanhPham.MaCN and ThanhPham.MaSP = SanPham.MaSP and SanPham.TenSP = N'Bình gốm nhỏ' and CongNhan.MaCN in
(select ThanhPham.MaCN from ThanhPham, SanPham where ThanhPham.MaSP = SanPham.MaSP and SanPham.TenSP = N'Nồi đất')
 --5)
 select TenTSX, count(MaCN) as SoNhanVien
 from  CongNhan, ToSanXuat
 where CongNhan.MaTSX = ToSanXuat.MaTSX
 group by TenTSX
 --6)
 select  C.TenSP, count(B.MaSP) as TongSoLuongThanhPham
 from CongNhan A, ThanhPham B, SanPham C
 where A.MaCN = B.MaCN and B.MaSP = C.MaSP 
 group by TenSP
 --7)
 select A.MaCN, sum(C.TienCong * B.SoLuong) as TongSoTienDaTra
 from CongNhan A, ThanhPham B, SanPham C
 where A.MaCN = B.MaCN and B.MaSP = C.MaSP and B.Ngay between '01/01/2007' and '31/01/2007'
 group by A.MaCN
 --8)
 select B.MaSP, sum(A.SoLuong) as TongSoLuongSanPham
 from ThanhPham A, SanPham B
 where A.MaSP = B.MaSP and A.Ngay between '01/02/2007' and '28/02/2007'
 group by B.MaSP
 having sum(A.SoLuong) >= all
 (select sum(A.SoLuong) 
 from ThanhPham A, SanPham B 
 where A.MaSP = B.MaSP and A.Ngay between '01/02/2007' and '28/02/2007'
 group by B.MaSP)
 --9)
 select A.MaCN, Ho, Ten, NgaySinh, MaTSX
 from CongNhan A, ThanhPham B, SanPham C
 where A.MaCN = B.MaCN and B.MaSP = C.MaSP and C.TenSP =N'Chén' and B.SoLuong = 
 (select  max(B.SoLuong) 
 from CongNhan A, ThanhPham B, SanPham C 
 where A.MaCN = B.MaCN and B.MaSP = C.MaSP and C.TenSP = N'Chén') 
--10)
select A.MaCN, sum(B.SoLuong * C.TienCong) as TongTienCongThang2
from CongNhan A, ThanhPham B, SanPham C
 where A.MaCN = B.MaCN and B.MaSP = C.MaSP and A.MaCN = 'CN002' and B.Ngay between '01/02/2007' and '28/02/2007'
 group by A.MaCN
 --11)
 select A.MaCN, Ho, Ten, NgaySinh, MaTSX, count(C.MaSP) as SoSanPhamDaLam
 from CongNhan A, ThanhPham B, SanPham C
 where A.MaCN = B.MaCN and B.MaSP = C.MaSP 
 group by A.MaCN, Ho, Ten, NgaySinh, A.MaTSX
 having count(C.MaSP) >= 3
 --12)
 update SanPham set TienCong ='21000' where MaSP = 'SP003'
 update SanPham set TienCong = '26000' where MaSP = 'SP004'
 --13)
 insert into CongNhan values('CN006', N'Lê Thị', N'Lan', N'Nữ',GETDATE(), 'TS02')

-------------------Hàm & thủ tục---------------------------
--A)
a)
create function fn_TongSoCongNhan (@MaTSX char(5))
returns int 
as
begin 
	declare @SoCongNhan int 
	if exists(select * from ToSanXuat where MaTSX = @MaTSX)
		begin
			select @SoCongNhan = count(A.MaCN) from CongNhan A
			where A.MaTSX = @MaTSX  
		end
	else 
		begin
			set @SoCongNhan = 0
		end
	return @SoCongNhan
end

print dbo.fn_TongSoCongNhan('TS01')

b)
create function fn_TongSanLuongSanXuat(@MaSP char(5), @Thang int)
returns int
as
begin
	declare @TongSanPham int
	if exists(select * from SanPham where MaSP = @MaSP)
		begin
			 select @TongSanPham = sum(A.SoLuong) from ThanhPham A
			 where A.MaSP = @MaSP and Month (A.Ngay) = @Thang
		end
	else 
		set @TongSanPham = 0
	return @TongSanPham
end

print dbo.fn_TongSanLuongSanXuat('SP001',2)

c)
create function fn_TongTienCong (@MaCN char(5), @Thang int)
returns int 
as
begin
	declare @TongTienCong int
	if exists(select * from CongNhan where MaCN = @MaCN)
		begin
			select @TongTienCong = sum(A.TienCong * B.SoLuong) 
			from SanPham A, ThanhPham B 
			where A.MaSP = B.MaSP and MaCN = @MaCN and Month (Ngay) = @Thang
		end
	else 
		set @TongTienCong = 0
	return @TongTienCong
end

print dbo.fn_TongTienCong('CN001',2)

d) 
create function fn_TongThuNhapTrongNam(@MaTSX char(5), @Nam int)
returns int
as
begin
	declare @TongThuNhap int
	if exists(select * from ToSanXuat A where A.MaTSX = @MaTSX)
		begin
			select @TongThuNhap = sum(TienCong * SoLuong) 
			from SanPham A, ThanhPham B, CongNhan C
			where A.MaSP = B.MaSP and C.MaCN = B.MaCN and C.MaTSX = @MaTSX and Year(Ngay) = @Nam
		end
	else 
		set @TongThuNhap = 0
	return @TongThuNhap
end
 
 print dbo.fn_TongThuNhapTrongNam('TS01', 2007)

 e)
 create function fn_TongSanLuongTrong1Thang(@Ngay1 datetime, @Ngay2 datetime)
 returns int
 as
 begin
	declare @TongSanLuong int
	begin
		select @TongSanLuong = sum(SoLuong) 
		from ThanhPham B
		where Ngay between @Ngay1 and @Ngay2
	end
	return @TongSanLuong
 end

 print dbo.fn_TongSanLuongTrong1Thang('01/02/2007','14/02/2007')

 --B) 
 a)
 create proc usp_XuatDanhSachCongNhan
 @MaTSX char(5) 
 as
 begin
	if exists(select * from CongNhan where MaTSX = @MaTSX)
		begin 
			select * 
			from CongNhan A
			where A.MaTSX = @MaTSX
		end
	else 
		print N'Tổ sản xuất không tồn tại'
 end

 exec usp_XuatDanhSachCongNhan 'TS01'

 b)
 create proc usp_XuatBangChamCong 
@MaCN char(5)
 as
 begin
	if exists(select * from CongNhan where MaCN = @MaCN)
		begin 
			select TenSP, DVT, SoLuong, TienCong, (SoLuong * TienCong) as ThanhTien
			from SanPham A, ThanhPham B
			where A.MaSP = B.MaSP and MaCN = @MaCN
		end
	else 
		print N'Công nhân không tồn tại'
 end

 exec usp_XuatBangChamCong 'CN001' 

 