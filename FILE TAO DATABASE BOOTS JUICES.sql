CREATE DATABASE QuanLyBanHangBOOTSJUICE
go
use QuanLyBanHangBOOTSJUICE
CREATE TABLE NHANVIEN 
(
	MaNV char(10) PRIMARY KEY NOT NULL,
	HoTenNV nvarchar(50),
	DiaChi nvarchar(50),
	NgaySinh DATE,
	SDT char(10),
	MaNQL char(10)
)
CREATE TABLE PHIEUXUAT 
(
	MaPX char (10) PRIMARY KEY NOT NULL,
	TenPX nvarchar(50) NOT NULL,
	SoLuong int,
	NgaySX DATE,
	HanSuDung DATE,
	XuatXu nvarchar(50),
	MaNV char(10)
)
CREATE TABLE PHIEUNHAP 
(
	MaPN char(10) PRIMARY KEY NOT NULL,
	MaNV char(10),
	TenNV nvarchar(50),
	TenHangHoa nvarchar(50),
	SoLuong int,
	tinhTrangHangHoa nvarchar(50),
	TenNguoiGiao nvarchar(50),
	DonGia money,
	ThanhTien money
)
CREATE TABLE KHACHHANG 
(
	MaKH char(10) PRIMARY KEY NOT NULL,
	TenKH nvarchar(50),
	DiaChi nvarchar(50),
	SDT char(10)
)
go
CREATE TABLE HOADON
(
	MaHD char(10) PRIMARY KEY NOT NULL,
	MaKH char(10),
	MaNV char(10),
	TenNV nvarchar(50),
	TenKH nvarchar(50),
	NgayThanhToan DATE,
	TenSP nvarchar(50),
	SoLuong int,
	GiaCa money,
	TongTien money,
	SoTienKhachTra money,
	SoTienThuaLai money
)
CREATE TABLE DONHANG_ONLINE
(
	MaDH char(10) PRIMARY KEY NOT NULL,
	MaNV char(10),
	MaKH char(10),
	TenNV nvarchar(50),
	TenKH nvarchar(50),
	TenSP nvarchar(50),
	SoLuong int,
	GiaCa money,
	TongTien money,
	TenDonViVanChuyen nvarchar(50),
	TrangThaiDonHang nvarchar(15)
)
CREATE TABLE HANGHOA 
(
	 MaHH char(10) PRIMARY KEY NOT NULL,
	 TenHangHoa nvarchar(50),
	 NgaySX DATE,
	 HanSD DATE,
	 XuatXu nvarchar(50)
)
CREATE TABLE MUA 
(
	MaKH char(10) NOT NULL,
	MaHH char(10) NOT NULL,
	PRIMARY KEY (MaKH,MaHH)
)
CREATE TABLE CHUONGTRINHKM 
(
	MaKM char(10) PRIMARY KEY NOT NULL,
	TenChuongTrinh nvarchar(50),
	MucGiamGia DECIMAL (3,2),
	ThoiGianBatDau TIME,
	ThoiGianKetThuc TIME
)
CREATE TABLE APDUNG 
(
	MaKM char(10) NOT NULL,
	MaHD char(10) NOT NULL,
	PRIMARY KEY (MaKM, MaHD)
)
CREATE TABLE BANBAOCAO 
(
	MaBC char(10) PRIMARY KEY NOT NULL,
	MaNV char(10),
	TenBaoCao nvarchar(50),
	ThoiGian DATE,
	TenCa nvarchar(50),
	TongTienLyThuyet money,
	TongTienThucTe money,
	DoChenhLech money
)
CREATE TABLE TONGKETCUOINGAY 
(
	MaBC char(10),
	TotalCash money,
	TotalCreditCard money,
	TotalEWallet money
)
CREATE TABLE LAM
(
	MaNV char(10) NOT NULL,
	MaCa char(10) NOT NULL,
	NgayLam DATE,
	PRIMARY KEY (MaNV,MaCa),
)
CREATE TABLE BANGLUONG 
(
	MaBL char(10) PRIMARY KEY NOT NULL,
	MaNV char(10),
	NgayNhanLuong DATE,
	TongSoCaThucHien smallint,
	TongTienHoaHong money,
	TongTienPhat money,
	LuongThucLanh money,
	LuongTrachNhiem money,
)
CREATE TABLE CA 
(
	MaCa char(10) PRIMARY KEY NOT NULL,
	ThoiGianBatDau DATE,
	ThoiGianKetThuc DATE,
	TienLuong money,
	TienPhuCap money,
)




ALTER TABLE PHIEUXUAT ADD CONSTRAINT FK_PhieuXuat_NhanVien FOREIGN KEY (MaNV) REFERENCES NHANVIEN (MaNV)
ALTER TABLE PHIEUNHAP ADD CONSTRAINT FK_PhieuNhap_Nhanvien FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV)
ALTER TABLE NHANVIEN ADD CONSTRAINT FK_NhanVien_NhanVienQL FOREIGN KEY (MaNQL) REFERENCES NHANVIEN(MaNV)
ALTER TABLE HOADON ADD CONSTRAINT FK_HOADON_KHACHHANG FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH)
ALTER TABLE HOADON ADD CONSTRAINT FK_HOADON_NHANVIEN FOREIGN KEY (MaNV) REFERENCES NHANVIEN (MaNV)
ALTER TABLE DONHANG_ONLINE ADD CONSTRAINT FK_DONHANGONLINE_KHACHHANG FOREIGN KEY (MaKH) REFERENCES KHACHHANG (MaKH)
ALTER TABLE DONHANG_ONLINE ADD CONSTRAINT FK_DONHANGONLINE_NHANVIEN FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV)
ALTER TABLE MUA ADD CONSTRAINT FK_MUA_KHACHHANG FOREIGN KEY (MaKH) REFERENCES KHACHHANG (MaKH)
ALTER TABLE MUA ADD CONSTRAINT FK_MUA_HANGHOA FOREIGN KEY (MaHH) REFERENCES HANGHOA(MaHH)
ALTER TABLE APDUNG ADD CONSTRAINT FK_APDUNG_CHUONGTRINHKM FOREIGN KEY (MaKM) REFERENCES CHUONGTRINHKM (MaKM)
ALTER TABLE APDUNG ADD CONSTRAINT FK_APDUNG_DONHANG FOREIGN KEY (MaHD) REFERENCES HOADON (MaHD)
ALTER TABLE TONGKETCUOINGAY ADD CONSTRAINT FK_TONGKETCUOINGAY_BANBAOCAO FOREIGN KEY (MaBC) REFERENCES BANBAOCAO(MaBC)
ALTER TABLE LAM ADD CONSTRAINT FK_LAM_NHANVIEN FOREIGN KEY (MaNV) REFERENCES NHANVIEN (MaNV)
ALTER TABLE LAM ADD CONSTRAINT FK_LAM_CA FOREIGN KEY (MaCa) REFERENCES CA (MaCa)
ALTER TABLE BANGLUONG ADD CONSTRAINT FK_BANGLUONG_NHANVIEN FOREIGN KEY (MaNV) REFERENCES NHANVIEN (MaNV) 
ALTER TABLE BANBAOCAO ADD CONSTRAINT FK_BANBAOCAO_NHANVIEN FOREIGN KEY (MaNV) REFERENCES NHANVIEN (MaNV)

--ĐỔ DỮ LIỆU VÀO
-- Sử dụng database
USE QuanLyBanHangBOOTSJUICE;
GO

-- Thêm dữ liệu vào bảng NHANVIEN
INSERT INTO NHANVIEN (MaNV, HoTenNV, DiaChi, NgaySinh, SDT, MaNQL)
VALUES
    ('NV01', N'Nguyễn Văn A', N'123 Đường Trần Phú, Hà Nội', '1990-05-15', '0912345678', NULL),
    ('NV02', N'Trần Thị B', N'456 Đường Lê Lợi, Đà Nẵng', '1992-08-20', '0987654321', 'NV01'),
    ('NV03', N'Phạm Văn C', N'789 Đường Nguyễn Du, TP.HCM', '1995-03-10', '0933221100', 'NV01'),
    ('NV04', N'Hoàng Thị D', N'234 Đường Lê Thánh Tông, Hà Nội', '1991-11-25', '0977889900', 'NV02'),
    ('NV05', N'Vũ Ngọc E', N'567 Đường Trần Hưng Đạo, Đà Nẵng', '1993-07-01', '0922334455', 'NV02'),
    ('NV06', N'Lê Thị G', N'890 Đường Nguyễn Trãi, TP.HCM', '1996-02-18', '0966554433', 'NV03'),
    ('NV07', N'Đỗ Văn H', N'111 Đường Bà Triệu, Hà Nội', '1994-09-05', '0944332211', 'NV03'),
    ('NV08', N'Mai Thị K', N'321 Đường Lê Duẩn, Đà Nẵng', '1997-04-12', '0988776655', 'NV04'),
    ('NV09', N'Cao Văn L', N'654 Đường Cách Mạng Tháng 8, TP.HCM', '1989-12-08', '0911223344', 'NV04'),
    ('NV10', N'Trịnh Thị M', N'987 Đường Hai Bà Trưng, Hà Nội', '1998-06-22', '0955443322', 'NV05');
GO

-- Thêm dữ liệu vào bảng PHIEUXUAT
INSERT INTO PHIEUXUAT (MaPX, TenPX, SoLuong, NgaySX, HanSuDung, XuatXu, MaNV)
VALUES
    ('PX01', N'Xuất hàng A', 100, '2024-01-01', '2024-03-01', N'Việt Nam', 'NV01'),
    ('PX02', N'Xuất hàng B', 50, '2024-01-15', '2024-03-15', N'Trung Quốc', 'NV02'),
    ('PX03', N'Xuất hàng C', 200, '2024-02-01', '2024-04-01', N'Việt Nam', 'NV03'),
    ('PX04', N'Xuất hàng D', 75, '2024-02-15', '2024-04-15', N'Hàn Quốc', 'NV04'),
    ('PX05', N'Xuất hàng E', 120, '2024-03-01', '2024-05-01', N'Nhật Bản', 'NV05'),
    ('PX06', N'Xuất hàng F', 60, '2024-03-15', '2024-05-15', N'Việt Nam', 'NV06'),
    ('PX07', N'Xuất hàng G', 150, '2024-04-01', '2024-06-01', N'Trung Quốc', 'NV07'),
    ('PX08', N'Xuất hàng H', 90, '2024-04-15', '2024-06-15', N'Hàn Quốc', 'NV08'),
    ('PX09', N'Xuất hàng I', 180, '2024-05-01', '2024-07-01', N'Nhật Bản', 'NV09'),
    ('PX10', N'Xuất hàng K', 110, '2024-05-15', '2024-07-15', N'Việt Nam', 'NV10');
GO

-- Thêm dữ liệu vào bảng PHIEUNHAP
INSERT INTO PHIEUNHAP (MaPN, MaNV, TenNV, TenHangHoa, SoLuong, tinhTrangHangHoa, TenNguoiGiao, DonGia, ThanhTien)
VALUES
    ('PN01', 'NV01', N'Nguyễn Văn A', N'Hàng hóa 1', 50, N'Mới', N'Người giao X', 100000, 5000000),
    ('PN02', 'NV02', N'Trần Thị B', N'Hàng hóa 2', 30, N'Mới', N'Người giao Y', 200000, 6000000),
    ('PN03', 'NV03', N'Phạm Văn C', N'Hàng hóa 3', 100, N'Mới', N'Người giao Z', 150000, 15000000),
    ('PN04', 'NV04', N'Hoàng Thị D', N'Hàng hóa 4', 20, N'Cũ', N'Người giao X', 50000, 1000000),
    ('PN05', 'NV05', N'Vũ Ngọc E', N'Hàng hóa 5', 60, N'Mới', N'Người giao Y', 120000, 7200000),
    ('PN06', 'NV06', N'Lê Thị G', N'Hàng hóa 6', 40, N'Cũ', N'Người giao Z', 80000, 3200000),
    ('PN07', 'NV07', N'Đỗ Văn H', N'Hàng hóa 7', 80, N'Mới', N'Người giao X', 180000, 14400000),
    ('PN08', 'NV08', N'Mai Thị K', N'Hàng hóa 8', 15, N'Cũ', N'Người giao Y', 60000, 900000),
    ('PN09', 'NV09', N'Cao Văn L', N'Hàng hóa 9', 70, N'Mới', N'Người giao Z', 250000, 17500000),
    ('PN10', 'NV10', N'Trịnh Thị M', N'Hàng hóa 10', 25, N'Cũ', N'Người giao X', 100000, 2500000);
GO

-- Thêm dữ liệu vào bảng KHACHHANG
INSERT INTO KHACHHANG (MaKH, TenKH, DiaChi, SDT)
VALUES
    ('KH01', N'Nguyễn Thị A', N'999 Đường ABC, Hà Nội', '0901234567'),
    ('KH02', N'Trần Văn B', N'888 Đường XYZ, Đà Nẵng', '0988765432'),
    ('KH03', N'Lê Thị C', N'777 Đường DEF, TP.HCM', '0933456789'),
    ('KH04', N'Phạm Văn D', N'666 Đường GHI, Hà Nội', '0977123456'),
    ('KH05', N'Hoàng Thị E', N'555 Đường JKL, Đà Nẵng', '0922654321'),
    ('KH06', N'Vũ Ngọc G', N'444 Đường MNO, TP.HCM', '0966987654'),
    ('KH07', N'Đỗ Thị H', N'333 Đường PQR, Hà Nội', '0944234567'),
    ('KH08', N'Mai Văn K', N'222 Đường STU, Đà Nẵng', '0988543210'),
    ('KH09', N'Cao Thị L', N'111 Đường VWX, TP.HCM', '0911876543'),
    ('KH10', N'Trịnh Văn M', N'101 Đường YZ, Hà Nội', '0955123456');
GO

-- Thêm dữ liệu vào bảng HOADON
INSERT INTO HOADON (MaHD, MaKH, MaNV, TenNV, TenKH, NgayThanhToan, TenSP, SoLuong, GiaCa, TongTien, SoTienKhachTra, SoTienThuaLai)
VALUES
    ('HD01', 'KH01', 'NV01', N'Nguyễn Văn A', N'Nguyễn Thị A', '2024-02-01', N'Sản phẩm X', 2, 200000, 400000, 500000, 100000),
    ('HD02', 'KH02', 'NV02', N'Trần Thị B', N'Trần Văn B', '2024-02-05', N'Sản phẩm Y', 1, 300000, 300000, 300000, 0),
    ('HD03', 'KH03', 'NV03', N'Phạm Văn C', N'Lê Thị C', '2024-02-10', N'Sản phẩm Z', 3, 150000, 450000, 500000, 50000),
    ('HD04', 'KH04', 'NV04', N'Hoàng Thị D', N'Phạm Văn D', '2024-02-15', N'Sản phẩm X', 1, 200000, 200000, 250000, 50000),
    ('HD05', 'KH05', 'NV05', N'Vũ Ngọc E', N'Hoàng Thị E', '2024-02-20', N'Sản phẩm Y', 2, 300000, 600000, 600000, 0),
    ('HD06', 'KH06', 'NV06', N'Lê Thị G', N'Vũ Ngọc G', '2024-02-25', N'Sản phẩm Z', 1, 150000, 150000, 200000, 50000),
    ('HD07', 'KH07', 'NV07', N'Đỗ Văn H', N'Đỗ Thị H', '2024-03-01', N'Sản phẩm X', 3, 200000, 600000, 650000, 50000),
    ('HD08', 'KH08', 'NV08', N'Mai Thị K', N'Mai Văn K', '2024-03-05', N'Sản phẩm Y', 1, 300000, 300000, 350000, 50000),
    ('HD09', 'KH09', 'NV09', N'Cao Văn L', N'Cao Thị L', '2024-03-10', N'Sản phẩm Z', 2, 150000, 300000, 300000, 0),
    ('HD10', 'KH10', 'NV10', N'Trịnh Thị M', N'Trịnh Văn M', '2024-03-15', N'Sản phẩm X', 1, 200000, 200000, 200000, 0);
GO

-- Thêm dữ liệu vào bảng DONHANG_ONLINE
INSERT INTO DONHANG_ONLINE (MaDH, MaKH, TenNV, TenKH, TenSP, SoLuong, GiaCa, TongTien, TenDonViVanChuyen, TrangThaiDonHang)
VALUES
    ('DH01', 'KH01', N'Nguyễn Văn A', N'Nguyễn Thị A', N'Sản phẩm A', 2, 250000, 500000, N'Giao hàng nhanh', N'Đang xử lý'),
    ('DH02', 'KH02', N'Trần Thị B', N'Trần Văn B', N'Sản phẩm B', 1, 350000, 350000, N'Viettel Post', N'Đang giao'),
    ('DH03', 'KH03', N'Phạm Văn C', N'Lê Thị C', N'Sản phẩm C', 3, 180000, 540000, N'VNPost', N'Đã giao'),
    ('DH04', 'KH04', N'Hoàng Thị D', N'Phạm Văn D', N'Sản phẩm A', 1, 250000, 250000, N'Giao hàng nhanh', N'Đang xử lý'),
    ('DH05', 'KH05', N'Vũ Ngọc E', N'Hoàng Thị E', N'Sản phẩm B', 2, 350000, 700000, N'Viettel Post', N'Đang giao'),
    ('DH06', 'KH06', N'Lê Thị G', N'Vũ Ngọc G', N'Sản phẩm C', 1, 180000, 180000, N'VNPost', N'Đã giao'),
    ('DH07', 'KH07', N'Đỗ Văn H', N'Đỗ Thị H', N'Sản phẩm A', 3, 250000, 750000, N'Giao hàng nhanh', N'Đang xử lý'),
    ('DH08', 'KH08', N'Mai Thị K', N'Mai Văn K', N'Sản phẩm B', 1, 350000, 350000, N'Viettel Post', N'Đang giao'),
    ('DH09', 'KH09', N'Cao Văn L', N'Cao Thị L', N'Sản phẩm C', 2, 180000, 360000, N'VNPost', N'Đã giao'),
    ('DH10', 'KH10', N'Trịnh Thị M', N'Trịnh Văn M', N'Sản phẩm A', 1, 250000, 250000, N'Giao hàng nhanh', N'Đang xử lý');
GO

-- Thêm dữ liệu vào bảng HANGHOA
INSERT INTO HANGHOA (MaHH, TenHangHoa, NgaySX, HanSD, XuatXu)
VALUES
    ('HH01', N'Hàng hóa X', '2024-01-01', '2024-03-01', N'Việt Nam'),
    ('HH02', N'Hàng hóa Y', '2024-01-15', '2024-03-15', N'Trung Quốc'),
    ('HH03', N'Hàng hóa Z', '2024-02-01', '2024-04-01', N'Nhật Bản'),
    ('HH04', N'Hàng hóa A', '2024-02-15', '2024-04-15', N'Hàn Quốc'),
    ('HH05', N'Hàng hóa B', '2024-03-01', '2024-05-01', N'Việt Nam'),
    ('HH06', N'Hàng hóa C', '2024-03-15', '2024-05-15', N'Trung Quốc'),
    ('HH07', N'Hàng hóa D', '2024-04-01', '2024-06-01', N'Nhật Bản'),
    ('HH08', N'Hàng hóa E', '2024-04-15', '2024-06-15', N'Hàn Quốc'),
    ('HH09', N'Hàng hóa F', '2024-05-01', '2024-07-01', N'Việt Nam'),
    ('HH10', N'Hàng hóa G', '2024-05-15', '2024-07-15', N'Trung Quốc');
GO

-- Thêm dữ liệu vào bảng MUA
INSERT INTO MUA (MaKH, MaHH)
VALUES
    ('KH01', 'HH01'),
    ('KH02', 'HH02'),
    ('KH03', 'HH03'),
    ('KH04', 'HH04'),
    ('KH05', 'HH05'),
    ('KH06', 'HH06'),
    ('KH07', 'HH07'),
    ('KH08', 'HH08'),
    ('KH09', 'HH09'),
    ('KH10', 'HH10');
GO

-- Thêm dữ liệu vào bảng CHUONGTRINHKM
INSERT INTO CHUONGTRINHKM (MaKM, TenChuongTrinh, MucGiamGia, ThoiGianBatDau, ThoiGianKetThuc)
VALUES
    ('KM01', N'Khuyến mãi 1', 0.10, '08:00:00', '17:00:00'),
    ('KM02', N'Khuyến mãi 2', 0.05, '08:00:00', '17:00:00'),
    ('KM03', N'Khuyến mãi 3', 0.15, '08:00:00', '17:00:00'),
    ('KM04', N'Khuyến mãi 4', 0.20, '08:00:00', '17:00:00'),
    ('KM05', N'Khuyến mãi 5', 0.08, '08:00:00', '17:00:00'),
    ('KM06', N'Khuyến mãi 6', 0.12, '08:00:00', '17:00:00'),
    ('KM07', N'Khuyến mãi 7', 0.03, '08:00:00', '17:00:00'),
    ('KM08', N'Khuyến mãi 8', 0.18, '08:00:00', '17:00:00'),
    ('KM09', N'Khuyến mãi 9', 0.25, '08:00:00', '17:00:00'),
    ('KM10', N'Khuyến mãi 10', 0.07, '08:00:00', '17:00:00');
GO

-- Thêm dữ liệu vào bảng APDUNG
INSERT INTO APDUNG (MaKM, MaHD)
VALUES
    ('KM01', 'HD01'),
    ('KM02', 'HD02'),
    ('KM03', 'HD03'),
    ('KM04', 'HD04'),
    ('KM05', 'HD05'),
    ('KM06', 'HD06'),
    ('KM07', 'HD07'),
    ('KM08', 'HD08'),
    ('KM09', 'HD09'),
    ('KM10', 'HD10');
GO

-- Thêm dữ liệu vào bảng BANBAOCAO
INSERT INTO BANBAOCAO (MaBC, MaNV, TenBaoCao, ThoiGian, TenCa, TongTienLyThuyet, TongTienThucTe, DoChenhLech)
VALUES
    ('BC01', 'NV01', N'Báo cáo ngày 1', '2024-02-01', N'Ca sáng', 10000000, 10500000, 500000),
    ('BC02', 'NV02', N'Báo cáo ngày 2', '2024-02-02', N'Ca chiều', 8000000, 7800000, -200000),
    ('BC03', 'NV03', N'Báo cáo ngày 3', '2024-02-03', N'Ca tối', 12000000, 12200000, 200000),
    ('BC04', 'NV04', N'Báo cáo ngày 4', '2024-02-04', N'Ca sáng', 9000000, 9300000, 300000),
    ('BC05', 'NV05', N'Báo cáo ngày 5', '2024-02-05', N'Ca chiều', 7000000, 7100000, 100000),
    ('BC06', 'NV06', N'Báo cáo ngày 6', '2024-02-06', N'Ca tối', 11000000, 11000000, 0),
    ('BC07', 'NV07', N'Báo cáo ngày 7', '2024-02-07', N'Ca sáng', 10500000, 10800000, 300000),
    ('BC08', 'NV08', N'Báo cáo ngày 8', '2024-02-08', N'Ca chiều', 8500000, 8200000, -300000),
    ('BC09', 'NV09', N'Báo cáo ngày 9', '2024-02-09', N'Ca tối', 13000000, 13500000, 500000),
    ('BC10', 'NV10', N'Báo cáo ngày 10', '2024-02-10', N'Ca sáng', 9500000, 9600000, 100000);
GO

-- Thêm dữ liệu vào bảng TONGKETCUOINGAY
INSERT INTO TONGKETCUOINGAY (MaBC, TotalCash, TotalCreditCard, TotalEWallet)
VALUES
    ('BC01', 5000000, 3000000, 2500000),
    ('BC02', 4000000, 2500000, 1500000),
    ('BC03', 6000000, 4000000, 3000000),
    ('BC04', 4500000, 2800000, 2000000),
    ('BC05', 3500000, 2200000, 1400000),
    ('BC06', 5500000, 3500000, 2700000),
    ('BC07', 5200000, 3200000, 2300000),
    ('BC08', 4200000, 2600000, 1800000),
    ('BC09', 6500000, 4300000, 3200000),
    ('BC10', 4800000, 3000000, 2200000);
GO
-- Thêm dữ liệu vào bảng CA
INSERT INTO CA (MaCa, ThoiGianBatDau, ThoiGianKetThuc, TienLuong, TienPhuCap)
VALUES
    ('CA01', '2024-02-01', '2024-02-01', 300000, 50000),
    ('CA02', '2024-02-01', '2024-02-01', 350000, 60000),
    ('CA03', '2024-02-01', '2024-02-01', 400000, 70000),
    ('CA04', '2024-02-01', '2024-02-01', 320000, 55000),
    ('CA05', '2024-02-01', '2024-02-01', 370000, 65000),
    ('CA06', '2024-02-01', '2024-02-01', 420000, 75000),
    ('CA07', '2024-02-01', '2024-02-01', 340000, 58000),
    ('CA08', '2024-02-01', '2024-02-01', 390000, 68000),
    ('CA09', '2024-02-01', '2024-02-01', 440000, 80000),
    ('CA10', '2024-02-01', '2024-02-01', 310000, 52000);
GO

-- Thêm dữ liệu vào bảng LAM
INSERT INTO LAM (MaNV, MaCa, NgayLam)
VALUES 
    ('NV01', 'CA01', '2024-02-01'),
    ('NV02', 'CA02', '2024-02-02'),
    ('NV03', 'CA03', '2024-02-03'),
    ('NV04', 'CA01', '2024-02-04'),
    ('NV05', 'CA02', '2024-02-05'),
    ('NV06', 'CA03', '2024-02-06'),
    ('NV07', 'CA01', '2024-02-07'),
    ('NV08', 'CA02', '2024-02-08'),
    ('NV09', 'CA03', '2024-02-09'),
    ('NV10', 'CA01', '2024-02-10');
GO

-- Thêm dữ liệu vào bảng BANGLUONG
INSERT INTO BANGLUONG (MaBL, MaNV, NgayNhanLuong, TongSoCaThucHien, TongTienHoaHong, TongTienPhat, LuongThucLanh, LuongTrachNhiem)
VALUES
    ('BL01', 'NV01', '2024-03-01', 20, 1000000, 0, 8000000, 1000000),
    ('BL02', 'NV02', '2024-03-01', 18, 900000, 0, 7500000, 800000),
    ('BL03', 'NV03', '2024-03-01', 22, 1100000, 0, 8500000, 1200000),
    ('BL04', 'NV04', '2024-03-01', 19, 950000, 0, 7800000, 900000),
    ('BL05', 'NV05', '2024-03-01', 21, 1050000, 0, 8200000, 1100000),
    ('BL06', 'NV06', '2024-03-01', 17, 850000, 0, 7200000, 700000),
    ('BL07', 'NV07', '2024-03-01', 23, 1150000, 0, 8800000, 1300000),
    ('BL08', 'NV08', '2024-03-01', 16, 800000, 0, 7000000, 600000),
    ('BL09', 'NV09', '2024-03-01', 24, 1200000, 0, 9000000, 1400000),
    ('BL10', 'NV10', '2024-03-01', 20, 1000000, 0, 8000000, 1000000);
GO

