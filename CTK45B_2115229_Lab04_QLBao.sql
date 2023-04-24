/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Nguyễn Nhật Linh
   MSSV: 2115229
   Lớp: CTK45B
   Ngày bắt đầu: 23/02/2023
   Ngày kết thúc: ?????
*/	

create database Lab04_QLBao
go
use Lab04_QLBao
go


create table Bao_Tchi
(MaBaoTC char(4) primary key,
Ten nvarchar(20),
DinhKy nvarchar(20),
SoLuong int,
GiaBan int
)
go

create table PhatHanh
(MaBaoTC char(4) references Bao_Tchi(MaBaoTC),
SoBaoTC smallint,
NgayPH datetime,
)
go
 
create table KhachHang
(MaKH char(4) primary key,
TenKH nvarchar(4),
DiaChi nvarchar(7),
)
go

create table DatBao
(MaKH char(4) references KhachHang(MaKH),
MaBaoTC char(4) references Bao_Tchi(MaBaoTC),
SLMua smallint,
NgayDM datetime,
)
go

set dateformat dmy 
go

insert into Bao_Tchi values ('TT01',N'Tuổi trẻ',N'Nhật báo',1000,1500)
insert into Bao_Tchi values ('KT01',N'Kiến thức ngày nay',N'Bán nguyệt san',3000,6000)
insert into Bao_Tchi values ('TN01',N'Thanh niên',N'Nhật báo',1000,2000)
insert into Bao_Tchi values ('PN01',N'Phụ nữ',N'Tuần báo',2000,4000)
insert into Bao_Tchi values ('PN02',N'Phụ nữ',N'Nhật báo',1000,2000)
select * from Bao_Tchi

insert into PhatHanh values ('TT01',123,'15/12/2005')
insert into PhatHanh values ('KT01',70,'15/12/2005')
insert into PhatHanh values ('TT01',124,'16/12/2005')
insert into PhatHanh values ('TN01',256,'17/12/2005')
insert into PhatHanh values ('PN01',45,'23/12/2005')
insert into PhatHanh values ('PN02',111,'18/12/2005')
insert into PhatHanh values ('PN02',112,'19/12/2005')
insert into PhatHanh values ('TT01',125,'17/12/2005')
insert into PhatHanh values ('PN01',46,'30/12/2005')
select * from PhatHanh



insert into KhachHang values ('KH01',N'LAN',N'2 NCT')
insert into KhachHang values ('KH02',N'NAM',N'32 THĐ')
insert into KhachHang values ('KH03',N'NGỌC',N'16 LHP')
select * from KhachHang

insert into DatBao values ('KH01','TT01',100,'12/01/2000')
insert into DatBao values ('KH02','TN01',150,'01/05/2001')
insert into DatBao values ('KH01','PN01',200,'25/06/2001')
insert into DatBao values ('KH03','KT01',50,'17/03/2002')
insert into DatBao values ('KH03','PN02',200,'26/08/2003')
insert into DatBao values ('KH02','TT01',250,'15/01/2004')
insert into DatBao values ('KH01','KT01',300,'14/10/2004')
select * from DatBao

select * from Bao_Tchi
select * from PhatHanh
select * from KhachHang
select * from DatBao

--1)
select * 
from Bao_Tchi
where Bao_Tchi.DinhKy = N'Tuần báo'
--2)
select * 
from Bao_Tchi
where left(Bao_Tchi.MaBaoTC, 2) ='PN' 
--3)
select C.TenKH
from Bao_Tchi A, DatBao B, KhachHang C
where A.MaBaoTC = B.MaBaoTC and B.MaKH = C.MaKH and B.MaBaoTC like 'PN%'
--4)
select C.TenKH
from Bao_Tchi A, DatBao B, KhachHang C
where A.MaBaoTC = B.MaBaoTC and B.MaKH = C.MaKH and B.MaBaoTC = 'PN01' and C.MaKH in
(select C.MaKH
from Bao_Tchi A, DatBao B, KhachHang C
where A.MaBaoTC = B.MaBaoTC and B.MaKH = C.MaKH and B.MaBaoTC = 'PN02')
--5)
select *
from KhachHang
where KhachHang.MaKH not in
(select A.MaKH
from KhachHang A, DatBao B, Bao_Tchi C
where A.MaKH = B.MaKH and B.MaBaoTC = C.MaBaoTC and C.Ten = N'Thanh niên')
--6)
select A.MaKH, sum(SLMua) as SoToBaoDaMua
from DatBao A
group by A.MaKH
--7)
select count(A.MaKH) as SoKhachHangDatMua
from DatBao A
where year(A.NgayDM) = 2004 
--8)
select C.TenKH, A.Ten, A.DinhKy, A.SoLuong, (A.SoLuong * A.GiaBan) as SoTien
from Bao_Tchi A, DatBao B, KhachHang C
where A.MaBaoTC = B.MaBaoTC and B.MaKH = C.MaKH
--9)
select A.Ten, A.DinhKy, sum(B.SLMua) as TongSoLuongDatMua
from Bao_Tchi A, DatBao B
where A.MaBaoTC= B.MaBaoTC 
group by A.Ten, A.DinhKy
--10)
select *
from Bao_Tchi A
where left(A.MaBaoTC,2) = 'HS'
--11)
select *
from Bao_Tchi
where Bao_Tchi.MaBaoTC not in
(select MaBaoTC
from DatBao A)
--12)
select Bao_Tchi.Ten, Bao_Tchi.DinhKy, sum(DatBao.SLMua) as TongSoLuongMua
from Bao_TChi, DatBao
where Bao_Tchi.MaBaoTC = DatBao.MaBaoTC 
group by Bao_Tchi.Ten, Bao_Tchi.DinhKy
having sum(DatBao.SLMua) >= all
(select sum(SLMua)   
from DatBao A
group by A.MaBaoTC) 
--13)
select A.MaKH, A.TenKH, A.DiaChi
from KhachHang A, DatBao B
where A.MaKH = B.MaKH
group by  A.MaKH, A.TenKH, A.DiaChi
having sum(B.SLMua) > = all
(select sum(SLMua) 
from DatBao A
group by MaKH)
--14)
select  A.MaBaoTC, A.Ten, A.DinhKy, A.SoLuong, A.GiaBan
from Bao_Tchi A, PhatHanh B
where A.MaBaoTC = B.MaBaoTC and B.NgayPH in
(select dateadd(mm,2,NgayPH) 
from PhatHanh )
--15)
select B.MaBaoTC, B.Ten, B.DinhKy, B.SoLuong, B.GiaBan, count(B.MaBaoTC) as SoLanDuocMua
from DatBao A, Bao_Tchi B
where A.MaBaoTC = B.MaBaoTC
group by B.MaBaoTC, B.Ten, B.DinhKy, B.SoLuong, B.GiaBan
having count(B.MaBaoTC) >= 3

-------------------Hàm & thủ tục-------------------
--A)
a) 
create function fn_TongTienMuaBao(@MaKH char(5))
returns int
as 
begin
declare @Tong int
	if exists(select * from KhachHang where MaKH = @MaKH)
		begin
			select @Tong = sum(GiaBan * SLMua)
			from KhachHang A, DatBao B, Bao_Tchi C	 
			where A.MaKH = B.MaKH and B.MaBaoTC = C.MaBaoTC and A.MaKH = 'KH01'
			
		end
	else
		set @Tong =0
	return @Tong
end

print dbo.fn_TongTienMuaBao('KH01')

b)
create function fn_TongTienThuDuocCua1Bao(@MaBao char(4))
returns int
as
begin
declare @Tong int
	if exists(select * from Bao_Tchi where MaBaoTC = @MaBao)
		begin
			select @Tong = sum(SoLuong * SLMua)
			from Bao_Tchi A, DatBao B
			where A.MaBaoTC = B.MaBaoTC and A.MaBaoTC = @MaBao
			return @Tong
		end
	else
		set @Tong = 0
	return @Tong
end

print dbo.fn_TongTienThuDuocCua1Bao('TT01')

--B)
a)
create proc usp_InDanhMucBaoTchi
@MaKH char(4)
as
begin
	if exists(select * from KhachHang where MaKH = @MaKH)
		begin
			select Ten
			from KhachHang A, DatBao B, Bao_Tchi C
			where A.MaKH = B.MaKH and B.MaBaoTC = C.MaBaoTC and A.MaKH = @MaKH
		end
end

exec usp_InDanhMucBaoTchi 'KH01'

b)
create proc usp_InDanhSachKHDatBao
as
begin
	select B.MaKH, TenKH, DiaChi
	from DatBao A, KhachHang B
	where A.MaKH = B.MaKH
	group by B.MaKH, TenKH, DiaChi
end

exec usp_InDanhSachKHDatBao