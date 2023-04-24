drop database test1
go
use test1
go

create table CuocThi 
(IDCuocThi char(2) primary key,
ChuDe nvarchar(20),
BatDauGiai datetime,
KThucGiai datetime
)

create table VongThi
(IDCuocThi char(2) references CuocThi(IDCuocThi),
SoVong int primary key,
BatDauV datetime,
KThucV datetime,
SLuongToiDa int,
)

create table ThiSinh 
(MaTS char(2) primary key,
HoTen nvarchar(20),
Gtinh nvarchar(5),
DChi nvarchar(20),
NTNS datetime
)

create table DiemThi 
(IDCuocThi char(2) references CuocThi(IDCuocThi),
SoVong int references VongThi(SoVong),
MaTS char(2) references ThiSinh(MaTS),
Diem int 
)

create table KetQua
(IDCuocThi char(2) references CuocThi(IDCuocThi),
MaTS char(2) references ThiSinh(MaTS),
VongCaoNhat int,
Hang int
)