/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Nguyễn Nhật Linh
   MSSV: 2115229
   Lớp: CTK45B
   Ngày bắt đầu: 23/02/2023
   Ngày kết thúc: ?????
*/	

create database Lab03_QLHH
go
use Lab03_QLHH
go

create table HangHoa 
(MaHH char(5) primary key,
TenHH varchar(35),
DVT nvarchar(5),
SoLuongTon int
)
go

create table DoiTac
(MaDT char(5) primary key,
TenDT nvarchar(25),
DiaChi nvarchar(35),
DienThoai char(10)
)
go

create table KhaNangCC
(MaDT char(5) references DoiTac(MaDT),
MaHH char(5) references HangHoa(MaHH),
)
go

create table HoaDon
(SoHD char(5) primary key,
NgayLapHD datetime,
MaDT char(5) references DoiTac(MaDT),
)
go

create table CT_HoaDon
(SoHD char(5) references HoaDon(SoHD),
MaHH char(5) references HangHoa(MaHH),
DonGia int,
SoLuong int,
)
go 
alter table CT_HoaDon alter column DonGia int
insert into HangHoa values ('CPU01','CPU INTEL,CELERON 600 BOX',N'cái',5)
insert into HangHoa values ('CPU02','CPU INTEL,PIII 700',N'cái',10)
insert into HangHoa values ('CPU03','CPU AMD K7 ATHL,ON 600',N'cái',8)
insert into HangHoa values ('HDD01','HDD 10.2 GB QUANTUM',N'cái',10)
insert into HangHoa values ('HDD02','HDD 13.6 GB SEAGATE',N'cái',15)
insert into HangHoa values ('HDD03','HDD 20 GB QUANTUM',N'cái',6)
insert into HangHoa values ('KB01','KB GENIUS',N'cái',12)
insert into HangHoa values ('KB02','KB MITSUMIMI',N'cái',5)
insert into HangHoa values ('MB01','GIGABYTE CHIPSET INTEL',N'cái',10)
insert into HangHoa values ('MB02','ACOPR BS CHIPSET VIA',N'cái',10)
insert into HangHoa values ('MB03','INTEL PHI CHIPSET INTEL',N'cái',10)
insert into HangHoa values ('MB04','ECS CHIPSET SIS',N'cái',10)
insert into HangHoa values ('MB05','ECS CHIPSET VIA',N'cái',10)
insert into HangHoa values ('MNT01','SAMSUNG 14" SYNCMASTER',N'cái',5)
insert into HangHoa values ('MNT02','LG 14"',N'cái',5)
insert into HangHoa values ('MNT03','ACER 14"',N'cái',8)
insert into HangHoa values ('MNT04','PHILIPS 14"',N'cái',6)
insert into HangHoa values ('MNT05','VIEWSONIC 14"',N'cái',7)
select * from HangHoa

insert into DoiTac values ('CC001',N'Cty TNC',N'176 BTX Q1 - TPHCM','088250259')
insert into DoiTac values ('CC002',N'Cty Hoàng Long',N'15A TTT Q1 - TPHCM','088250898')
insert into DoiTac values ('CC003',N'Cty Hợp Nhất',N'152 BTX Q1 - TPHCM','088252376')
insert into DoiTac values ('K0001',N'Nguyễn Minh Hải',N'91 Nguyễn Văn Trỗi TP Đà Lạt','063831129')
insert into DoiTac values ('K0002',N'Như Quỳnh',N'21 Điện Biên Phủ N.Trang','058590270')
insert into DoiTac values ('K0003',N'Trần Nhật Duật',N'Lê Lợi TP Huế','054848376')
insert into DoiTac values ('K0004',N'Phan Nguyễn Hùng Anh',N'11 Nam Kỳ Khởi Nghĩa TP Đà Lạt','073923409')
select * from DoiTac

set dateformat dmy
go

insert into HoaDon values ('N0001','25/01/2006','CC001')
insert into HoaDon values ('N0002','1/05/2006','CC002')
insert into HoaDon values ('X0001','12/05/2006','K0001')
insert into HoaDon values ('X0002','16/06/2006','K0002')
insert into HoaDon values ('X0003','20/04/2006','K0001')
select * from HoaDon

insert into KhaNangCC values ('CC001','CPU01')
insert into KhaNangCC values ('CC001','HDD03')
insert into KhaNangCC values ('CC001','KB01')
insert into KhaNangCC values ('CC001','MB02')
insert into KhaNangCC values ('CC001','MB04')
insert into KhaNangCC values ('CC001','MNT01')
insert into KhaNangCC values ('CC002','CPU01')
insert into KhaNangCC values ('CC002','CPU02')
insert into KhaNangCC values ('CC002','CPU03')
insert into KhaNangCC values ('CC002','KB02')
insert into KhaNangCC values ('CC002','MB01')
insert into KhaNangCC values ('CC002','MB05')
insert into KhaNangCC values ('CC002','MNT03')
insert into KhaNangCC values ('CC003','HDD01')
insert into KhaNangCC values ('CC003','HDD02')
insert into KhaNangCC values ('CC003','HDD03')
insert into KhaNangCC values ('CC003','MB03')
select * from KhaNangCC

insert into CT_HoaDon values ('N0001','CPU01',63,10)
insert into CT_HoaDon values ('N0001','HDD03',97,7)
insert into CT_HoaDon values ('N0001','KB01',3,5)
insert into CT_HoaDon values ('N0001','MB02',57,5)
insert into CT_HoaDon values ('N0001','MNT01',112,3)
insert into CT_HoaDon values ('N0002','CPU02',115,3)
insert into CT_HoaDon values ('N0002','KB02',5,7)
insert into CT_HoaDon values ('N0002','MNT03',111,5)
insert into CT_HoaDon values ('X0001','CPU01',67,2)
insert into CT_HoaDon values ('X0001','HDD03',100,2)
insert into CT_HoaDon values ('X0001','KB01',5,2)
insert into CT_HoaDon values ('X0001','MB02',62,1)
insert into CT_HoaDon values ('X0002','CPU01',67,1)
insert into CT_HoaDon values ('X0002','KB02',7,3)
insert into CT_HoaDon values ('X0002','MNT01',115,2)
insert into CT_HoaDon values ('X0003','CPU01',67,1)
insert into CT_HoaDon values ('X0003','MNT03',115,2)
select * from CT_HoaDon

select * from HangHoa
select * from DoiTac
select * from KhaNangCC
select * from HoaDon
select * from CT_HoaDon

--1)
select *
from HangHoa
where HangHoa.MaHH like '%HDD%'
--2)
select *
from HangHoa
where HangHoa.SoLuongTon > 10
--3)
select *
from DoiTac
where (Right(DoiTac.DiaChi, 3) = 'HCM')
--4)
select A.SoHD, A.NgayLapHD, B.TenDT, B.DiaChi, B.DienThoai, sum(C.SoLuong) as SoMatHang
from HoaDon A, DoiTac B, CT_HoaDon C
where A.MaDT = B.MaDT and A.SoHD = C.SoHD and A.NgayLapHD between '01/05/2006' and '31/05/2006'
group by A.SoHD, A.NgayLapHD, B.TenDT, B.DiaChi, B.DienThoai
--5)
select A.MaDT, A.TenDT, A.DiaChi, A.DienThoai
from DoiTac A, KhaNangCC B
where A.MaDT = B.MaDT and left(B.MaHH,3) ='HDD'
group by A.MaDT, A.TenDT, A.DiaChi, A.DienThoai
--6)
select A.MaDT, A.TenDT, A.DiaChi, A.DienThoai
from DoiTac A, KhaNangCC B
where A.MaDT = B.MaDT and B.MaHH = 'HDD01' and B.MaDT in 
 (select B.MaDT
 from KhaNangCC A, DoiTac B
 where A.MaDT = B.MaDT and MaHH = 'HDD02' and B.MaDT in  
  (select B.MaDT
  from KhaNangCC A, DoiTac B
  where A.MaDT = B.MaDT and MaHH = 'HDD03'))
--7)
select A.MaDT, A.TenDT, A.DiaChi, A.DienThoai
from DoiTac A, KhaNangCC B
where A.MaDT = B.MaDT and A.MaDT not in 
 (select A.MaDT
  from DoiTac A, KhaNangCC B 
  where A.MaDT = B.MaDT and B.MaHH like 'HDD%')
group by A.MaDT, A.TenDT, A.DiaChi, A.DienThoai
--8)
select  A.MaHH, A.TenHH, A.DVT, A.SoLuongTon
from HangHoa A
where A.MaHH not in 
 (select A.MaHH
 from HangHoa A, CT_HoaDon B
 where A.MaHH = B.MaHH)
 --9)
 select A.TenHH, sum(B.SoLuong) as TongSoLuong
 from HangHoa A, CT_HoaDon B
 where A.MaHH = B.MaHH 
 group by A.TenHH
 having sum(B.SoLuong) >= all
 (select sum(B.SoLuong)
 from HangHoa A, CT_HoaDon B
 where A.MaHH = B.MaHH 
 group by A.TenHH)
 --10)
  select A.TenHH, sum(B.SoLuong) as TongSoLuong
 from HangHoa A, CT_HoaDon B
 where A.MaHH = B.MaHH 
 group by A.TenHH
 having sum(B.SoLuong) <= all
 (select sum(B.SoLuong)
 from HangHoa A, CT_HoaDon B
 where A.MaHH = B.MaHH 
 group by A.TenHH)
 --11)
 select A.SoHD, A.NgayLapHD, A.MaDT
 from HoaDon A, CT_HoaDon B
 where A.SoHD = B.SoHD 
 group by A.SoHD, A.NgayLapHD, A.MaDT
 having sum(B.SoLuong) >= all
 (select sum(B.SoLuong)
 from HoaDon A, CT_HoaDon B
 where A.SoHD = B.SoHD 
 group by A.SoHD)
 --12)
 select *
 from HangHoa A
 where A.MaHH not in
 (select A.MaHH
 from HangHoa A, HoaDon B, CT_HoaDon C
 where A.MaHH = C.MaHH and B.SoHD = C.SoHD and B.NgayLapHD between '01/01/2006' and '31/01/2006')
 --13)
  select A.TenHH
 from HangHoa A
 where A.MaHH not in
 (select A.MaHH
 from HangHoa A, HoaDon B, CT_HoaDon C
 where A.MaHH = C.MaHH and B.SoHD = C.SoHD and B.NgayLapHD between '01/06/2006' and '30/06/2006')
 --14)
 select count(A.MaHH) as MatHangDaBan
 from CT_HoaDon A
 --15)
 select A.MaDT, count(A.MaHH) as MatHangCoTheCungCap
 from KhaNangCC A
 group by A.MaDT
 --16)
 select A.MaDT, A.TenDT, A.DiaChi, A.DienThoai
 from DoiTac A, HoaDon B
 where A.MaDT = B.MaDT
 group by A.MaDT, A.TenDT, A.DiaChi, A.DienThoai
 having count(B.MaDT) >= all
 (select count(B.MaDT)
 from DoiTac A, HoaDon B
 where A.MaDT = B.MaDT 
 group by A.MaDT)
 --17)
 select sum((A.DonGia * A.SoLuong)) as TongDoanhThu
 from CT_HoaDon A
 --18)
 select A.MaHH, A.TenHH, A.DVT, A.SoLuongTon
 from HangHoa A, CT_HoaDon B
 where A.MaHH = B.MaHH
 group by A.MaHH, A.TenHH, A.DVT, A.SoLuongTon
 having sum(B.SoLuong) >=all
 (select sum(B.SoLuong)
 from CT_HoaDon B
 group by B.MaHH)
 --19)
 select A.MaHH, TenHH, DVT, sum(B.SoLuong) as TongSoLuong, sum(B.SoLuong*B.DonGia) as TongGiaTien
 from HangHoa A, CT_HoaDon B, HoaDon C
 where A.MaHH = B.MaHH and B.SoHD = C.SoHD and C.NgayLapHD between '01/05/2006' and '31/05/2006'
 group by A.MaHH, TenHH, DVT
 --20)
 select A.MaHH, A.TenHH, A.DVT, A.SoLuongTon
 from HangHoa A, CT_HoaDon B
 where A.MaHH = B.MaHH
 group by A.MaHH, A.TenHH, A.DVT, A.SoLuongTon
 having sum(B.SoLuong) >=all
 (select sum(B.SoLuong)
 from CT_HoaDon B
 group by B.MaHH)
 --21)
 select A.SoHD,sum(A.DonGia * A.SoLuong) as TongTriGia
 from CT_HoaDon A
 group by A.SoHD

 alter table HoaDon add TongTG int
 update HoaDon set TongTG = 1945 
 where SoHD = 'N0001'
 update HoaDon set TongTG = 935 
 where SoHD = 'N0002'
 update HoaDon set TongTG = 406 
 where SoHD = 'X0001'
 update HoaDon set TongTG = 318 
 where SoHD = 'X0002'
 update HoaDon set TongTG = 297 
 where SoHD = 'X0003'

 ---------------------Hàm & thủ tục-------------------
 --A)
 a)
 create function fn_TongSoLuongNhap(@Ngay1 datetime, @Ngay2 datetime)
 returns int
 as
 begin
	declare @Tong int
	select @Tong = sum(SoLuong)
	from CT_HoaDon A, HoaDon B 
	where A.SoHD = B.SoHD and NgayLapHD between @Ngay1 and @Ngay2 and left(A.SoHD,1) = N'N'
	return @Tong
 end 

print dbo.fn_TongSoLuongNhap('01/05/2006','31/05/2006')

b) 
create function fn_TongSoLuongXuat(@Ngay1 datetime, @Ngay2 datetime)
returns int
 as
 begin
	declare @Tong int
	select @Tong = sum(SoLuong)
	from CT_HoaDon A, HoaDon B 
	where A.SoHD = B.SoHD and NgayLapHD between @Ngay1 and @Ngay2 and left(A.SoHD,1) = N'X'
	return @Tong
end

print dbo.fn_TongSoLuongXuat('01/06/2006','30/06/2006')

c)
create function fn_TongDoanhThuTrong1Thang(@Thang int)
returns int
as
begin
	declare @TongDoanhThu int
	if exists(select * from HoaDon where month(NgayLapHD) = @Thang)
		begin
			select @TongDoanhThu = sum(SoLuong * DonGia)
			from CT_HoaDon A, HoaDon B
			where A.SoHD = B.SoHD and MONTH(NgayLapHD) = @Thang
		end
	else 
		set @TongDoanhThu = 0
	return @TongDoanhThu
end

print dbo.fn_TongDoanhThuTrong1Thang(1)

d)
alter function fn_TongDoanhThuCua1MatHang(@MaHH char(5), @Ngay1 datetime, @Ngay2 datetime)
returns int
as
begin
	declare @Tong int
	if exists(select * from HangHoa where MaHH = @MaHH)
		begin
			select @Tong = sum(SoLuong * DonGia)
			from CT_HoaDon A, HoaDon B, HangHoa C
			where C.MaHH = @MaHH and A.SoHD = B.SoHD and NgayLapHD between @Ngay1 and @Ngay2 and A.MaHH = C.MaHH
		end
	else 
		set @Tong = 0
	return @Tong
end

print dbo.fn_TongDoanhThuCua1MatHang('CPU01','1/1/2006','31/1/2006')

e)
create function fn_TongSoTienNhapHang(@Ngay1 datetime, @Ngay2 datetime)
returns int
as
begin
declare @Tong int
	select @Tong = sum(SoLuong * DonGia)
	from CT_HoaDon A, HoaDon B
	where A.SoHD = B.SoHD and NgayLapHD between @Ngay1 and @Ngay2 and left(A.SoHD,1) = 'N'
	return @Tong
end

print dbo.fn_TongSoTienNhapHang('1/1/2006','31/1/2006')

f)
create function fn_TongTienCuaHoaDon(@SoHD char(5))
returns int
as
begin
	declare @Tong int
	if exists(select * from HoaDon where SoHD = @SoHD)
		begin
			select @Tong = sum(SoLuong * DonGia)
			from CT_HoaDon A, HoaDon B
			where A.SoHD = B.SoHD and A.SoHD = @SoHD
		end
	else 
		set @Tong = 0
	return @Tong
end

print dbo.fn_TongTienCuaHoaDon('X0002')

--B)
a)
create proc usp_CapNhatSLTon
@MaHH char(5),
@SoLuong int
as
begin
	if exists(select * from HangHoa where MaHH = @MaHH)
		begin
			update HangHoa set SoLuongTon = @SoLuong
			where MaHH = @MaHH
		end
	else 
		print N'Không tìm thấy hàng hoá'
end

exec usp_CapNhatSLTon 'CPU01', 5
select * from HangHoa
b) 
create proc usp_CapNhatTongTriGia
@SoHD char(5),
@Tong int
as
begin
	if exists(select * from HoaDon where SoHD = @SoHD)
		begin 
			update HoaDon set TongTG = @Tong where SoHD = @SoHD
		end
	else 
	print N'Không tìm thấy hoá đơn'
end

exec usp_CapNhatTongTriGia 'N0001', 1945
c)
create proc usp_InThongTinHoaDon
@SoHD char(5)
as
begin
	if exists (select * from HoaDon where SoHD = @SoHD)
		begin
			select * from HoaDon A, CT_HoaDon B where A.SoHD = B.SoHD and A.SoHD = @SoHD
		end
	else 
		print N'Không tìm thấy hoá đơn'
end

exec usp_InThongTinHoaDon 'N0001'