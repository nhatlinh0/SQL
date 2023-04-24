/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Nguyễn Nhật Linh
   MSSV: 2115229
   Lớp: CTK45B
   Ngày bắt đầu: 23/02/2023
   Ngày kết thúc: ?????
*/	
create database Lab05_QLTour
go
use Lab05_QLTour
go

create table ThanhPho 
(MaTP char(2) primary key,
TenTP nvarchar(20)
)
go

create table Tour_TP
(MaTour char(4) references Tour(MaTour),
MaTP char(2) references ThanhPho(MaTP),
SoNgay int
)
go

create table Tour
(MaTour char(4) primary key,
TongSoNgay int
)
go

create table Lich_TourDL
(MaTour char(4) references Tour(MaTour),
NgayKH datetime,
TenHDV nvarchar(5),
SoNguoi int,
TenKH nvarchar(30),
)
go

set dateformat dmy
go

insert into ThanhPho values ('01',N'Đà Lạt')
insert into ThanhPho values ('02',N'Nha Trang')
insert into ThanhPho values ('03',N'Phan Thiết')
insert into ThanhPho values ('04',N'Huế')
insert into ThanhPho values ('05',N'Đà Nẵng')
select * from ThanhPho

insert into Tour_TP values ('T001','01',2)
insert into Tour_TP values ('T001','03',1)
insert into Tour_TP values ('T002','01',2)
insert into Tour_TP values ('T002','02',2)
insert into Tour_TP values ('T003','02',2)
insert into Tour_TP values ('T003','01',1)
insert into Tour_TP values ('T003','04',2)
insert into Tour_TP values ('T004','02',2)
insert into Tour_TP values ('T004','05',2)
insert into Tour_TP values ('T004','04',3)
select * from Tour_TP

insert into Tour values ('T001',3)
insert into Tour values ('T002',4)
insert into Tour values ('T003',5)
insert into Tour values ('T004',7)
select * from Tour

insert into Lich_TourDL values ('T001','14/02/2017',N'Vân',20,N'Nguyễn Hoàng')
insert into Lich_TourDL values ('T002','14/02/2017',N'Nam',30,N'Lê Ngọc')
insert into Lich_TourDL values ('T002','06/03/2017',N'Hùng',20,N'Lý Dũng')
insert into Lich_TourDL values ('T003','18/02/2017',N'Dũng',20,N'Lý Dũng')
insert into Lich_TourDL values ('T004','18/02/2017',N'Hùng',30,N'Dũng Nam')
insert into Lich_TourDL values ('T003','10/03/2017',N'Nam',45,N'Nguyễn An')
insert into Lich_TourDL values ('T002','28/04/2017',N'Vân',25,N'Ngọc Dung')
insert into Lich_TourDL values ('T004','29/04/2017',N'Dũng',35,N'Lê Ngọc')
insert into Lich_TourDL values ('T001','30/04/2017',N'Nam',25,N'Trần Nam')
insert into Lich_TourDL values ('T003','15/06/2017',N'Vân',20,N'Trịnh Bá')
select * from Lich_TourDL

select * from ThanhPho
select * from Tour
select * from Tour_TP
select * from Lich_TourDL
--a)
select *
from Tour
where Tour.TongSoNgay >= 3 and Tour.TongSoNgay <=5
--b)
select *
from Lich_TourDL A
where A.NgayKH between '01/02/2017' and '28/02/2017'
--c)
select A.MaTour, TongSoNgay
from Tour A, Tour_TP B, ThanhPho C
where A.MaTour = B.MaTour and B.MaTP = C.MaTP and A.MaTour not in
(select B.MaTour
from ThanhPho A, Tour_TP B
where A.MaTP = B.MaTP and A.TenTP = N'Nha Trang')
group by A.MaTour, TongSoNgay
--d)
select A.MaTour, count(A.MaTP) as SoThanhPhoDiQua
from Tour_TP A 
group by A.MaTour
--e)
select A.TenHDV, count(A.MaTour) as SoLuongTourDuLich
from Lich_TourDL A
group by A.TenHDV
--f)
select A.MaTP, A.TenTP
from ThanhPho A, Tour_TP B
where A.MaTP = B.MaTP
group by A.MaTP, A.TenTP
having count(B.MaTP) >= all
(select count(A.MaTP)
from Tour_TP A
group by A.MaTP)
--g)
select A.MaTour, A.TongSoNgay
from Tour A, Tour_TP B
where A.MaTour = B.MaTour and B.MaTP = '01' and B.MaTour in
(select A.MaTour
from Tour_TP A
where A.MaTP = '02' and A.MaTour in
 (select A.MaTour
from Tour_TP A
where A.MaTP = '03' and A.MaTour in 
(select A.MaTour
from Tour_TP A
where A.MaTP = '04' and A.MaTour in 
(select A.MaTour
from Tour_TP A
where A.MaTP = '05'))))
--h)
select A.MaTour, TongSoNgay
from Tour A, Tour_TP B, ThanhPho C
where A.MaTour = B.MaTour and B.MaTP = C.MaTP and C.TenTP = N'Đà Lạt'
--i)
select B.MaTour, B.TongSoNgay
from Lich_TourDL A, Tour B
where A.MaTour = B.MaTour 
group by B.MaTour, B.TongSoNgay
having sum(A.SoNguoi) >= all
(select sum(A.SoNguoi)
from Lich_TourDL A, Tour B
where A.MaTour = B.MaTour 
group by B.MaTour)
--j)
select B.TenTP
from Tour_TP A, ThanhPho B
where A.MaTP = B.MaTP and A.MaTour = 'T001' and A.MaTP in 
(select A.MaTP
from Tour_TP A
where A.MaTour = 'T002' and A.MaTP in 
(select A.MaTP
from Tour_TP A
where A.MaTour = 'T003' and A.MaTP in 
(select A.MaTP
from Tour_TP A
where A.MaTour = 'T004' and A.MaTP in 
(select A.MaTP
from Tour_TP A
where A.MaTour = 'T005'))))