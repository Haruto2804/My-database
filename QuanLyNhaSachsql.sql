CREATE DATABASE QuanLyNhaSach
go
use QuanLyNhaSach
CREATE TABLE TACGIA 
(
	MaTacGia char(10) PRIMARY KEY NOT NULL,
	TenTacGia nvarchar(50),
	NgaySinh date,
	QuocTich nvarchar(20)
)
CREATE TABLE THELOAI
(
	MaTheLoai char(10) PRIMARY KEY NOT NULL,
	TenTheLoai nvarchar(20) NOT NULL
)
CREATE TABLE SACH 
(
	MaSach char(10) PRIMARY KEY NOT NULL,
	TieuDe nvarchar(30) NOT NULL,
	MaTacGia char(10),
	MaTheLoai char(10),
	NamXuatBan char(4),
	Gia money NOT NULL,
	SoLuongTon int NOT NULL,
	CONSTRAINT ck1_SACH CHECK (NamXuatBan >=1900 AND NamXuatBan >=0),
	CONSTRAINT ck2_Gia CHECK (Gia >=0),
	CONSTRAINT FK_SACH_TACGIA  FOREIGN KEY (MaTacGia) REFERENCES TACGIA(MaTacGia),
	CONSTRAINT FK_SACH_THELOAI FOREIGN KEY (MaTheLoai) REFERENCES THELOAI(MaTheLoai)
)
CREATE TABLE KHACHHANG
(
	MaKhachHang char(10) PRIMARY KEY NOT NULL,
	TenKhachHang nvarchar(30) NOT NULL,
	Email char(55) UNIQUE,
	SDT char(11)
)
CREATE TABLE DONHANG
(
	MaDonHang char(10) PRIMARY KEY NOT NULL,
	MaKhachHang char(10),
	NgayDatHang date NOT NULL DEFAULT getDate (),
	CONSTRAINT FK_DONHANG_KHACHHANG FOREIGN KEY (MaKhachHang) REFERENCES KHACHHANG(MaKhachHang),
	TongTien money,
	CONSTRAINT ck1_DONHANG CHECK (TongTien >=0)
)
CREATE TABLE CHITIETDONHANG
(
	MaDonHang char(10),
	MaSach char(10),
	SoLuong int NOT NULL,
	GiaBan money NOT NULL,
	PRIMARY KEY (MaDonHang,MaSach),
	CONSTRAINT ck_GiaBan_CHITIETDONHANG CHECK (GiaBan >=0),
	CONSTRAINT FK_CHITIETDONHANG_DONHANG FOREIGN KEY (MaDonHang) REFERENCES DONHANG(MaDonHang),
	CONSTRAINT FK_CHITIETDONHANG_SACH FOREIGN KEY (MaSach) REFERENCES SACH(MaSach)
)

-- đổ dữ liệu vào 
-- Chèn dữ liệu vào bảng TACGIA (Authors)
INSERT INTO TACGIA (MaTacGia, TenTacGia, NgaySinh, QuocTich) VALUES
('TG001', N'Nguyễn Nhật Ánh', '1955-05-07', N'Việt Nam'),
('TG002', N'J.K. Rowling', '1965-07-31', N'Anh'),
('TG003', N'Haruki Murakami', '1949-01-12', N'Nhật Bản'),
('TG004', N'Nguyễn Du', '1765-01-01', N'Việt Nam'),
('TG005', N'Stephen King', '1947-09-21', N'Mỹ'),
('TG006', N'Agatha Christie', '1890-09-15', N'Anh'),
('TG007', N'Lê Lựu', '1942-10-10', N'Việt Nam'),
('TG008', N'Dan Brown', '1964-06-22', N'Mỹ'),
('TG009', N'Tô Hoài', '1920-09-27', N'Việt Nam'),
('TG010', N'Paulo Coelho', '1947-08-24', N'Brazil');

-- Chèn dữ liệu vào bảng THELOAI (Categories)
INSERT INTO THELOAI (MaTheLoai, TenTheLoai) VALUES
('TL001', N'Tiểu thuyết'),
('TL002', N'Khoa học viễn tưởng'),
('TL003', N'Trinh thám'),
('TL004', N'Truyện thiếu nhi'),
('TL005', N'Kinh dị'),
('TL006', N'Lịch sử'),
('TL007', N'Tâm lý'),
('TL008', N'Phiêu lưu'),
('TL009', N'Văn học kinh điển'),
('TL010', N'Tự truyện');

-- Chèn dữ liệu vào bảng SACH (Books)
-- Đảm bảo NamXuatBan >= 1990 và <= năm hiện tại (2025)
-- Giá >= 0
INSERT INTO SACH (MaSach, TieuDe, MaTacGia, MaTheLoai, NamXuatBan, Gia, SoLuongTon) VALUES
('S001', N'Mắt biếc', 'TG001', 'TL001', '2000', 85000.00, 150),
('S002', N'Harry Potter', 'TG002', 'TL002', '1997', 120000.00, 200),
('S003', N'Rừng Na Uy', 'TG003', 'TL001', '1987', 105000.00, 100), -- NamXuatBan < 1990, có thể gây lỗi nếu ràng buộc chặt chẽ
('S004', N'Truyện Kiều', 'TG004', 'TL009', '1990', 90000.00, 80),  -- NamXuatBan < 1990, có thể gây lỗi
('S005', N'It', 'TG005', 'TL005', '1986', 130000.00, 70),     -- NamXuatBan < 1990, có thể gây lỗi
('S006', N'Mười người da đen nhỏ', 'TG006', 'TL003', '1939', 95000.00, 120), -- NamXuatBan < 1990, có thể gây lỗi
('S007', N'Thời xa vắng', 'TG007', 'TL001', '1986', 75000.00, 90), -- NamXuatBan < 1990, có thể gây lỗi
('S008', N'Mật mã Da Vinci', 'TG008', 'TL003', '2003', 110000.00, 180),
('S009', N'Dế Mèn phiêu lưu ký', 'TG009', 'TL004', '1941', 60000.00, 160), -- NamXuatBan < 1990, có thể gây lỗi
('S010', N'Nhà giả kim', 'TG010', 'TL007', '1988', 80000.00, 140); -- NamXuatBan < 1990, có thể gây lỗi

-- Chèn dữ liệu vào bảng KHACHHANG (Customers)
INSERT INTO KHACHHANG (MaKhachHang, TenKhachHang, Email, SDT) VALUES
('KH001', N'Trần Thị A', 'tranthia@example.com', '0901123456'),
('KH002', N'Lê Văn B', 'levanb@example.com', '0912234567'),
('KH003', N'Phạm Thị C', 'phamthic@example.com', '0983345678'),
('KH004', N'Hoàng Minh D', 'hoangminhd@example.com', '0974456789'),
('KH005', N'Nguyễn Hữu E', 'nguyenhue@example.com', '0965567890'),
('KH006', N'Đỗ Thị F', 'dothif@example.com', '0906678901'),
('KH007', N'Võ Văn G', 'vovang@example.com', '0917789012'),
('KH008', N'Bùi Thị H', 'buithih@example.com', '0988890123'),
('KH009', N'Đặng Minh I', 'dangminhi@example.com', '0979901234'),
('KH010', N'Cao Thị K', 'caothik@example.com', '0960012345');

-- Chèn dữ liệu vào bảng DONHANG (Orders)
-- NgayDatHang sẽ tự động lấy ngày hiện tại nếu không chỉ định
INSERT INTO DONHANG (MaDonHang, MaKhachHang, NgayDatHang, TongTien) VALUES
('DH001', 'KH001', '2025-05-20', 205000.00),
('DH002', 'KH002', '2025-05-21', 120000.00),
('DH003', 'KH003', '2025-05-21', 105000.00),
('DH004', 'KH004', '2025-05-22', 180000.00),
('DH005', 'KH005', '2025-05-22', 130000.00),
('DH006', 'KH001', '2025-05-23', 95000.00),
('DH007', 'KH002', '2025-05-23', 75000.00),
('DH008', 'KH006', '2025-05-24', 110000.00),
('DH009', 'KH007', '2025-05-24', 60000.00),
('DH010', 'KH008', '2025-05-25', 80000.00);

-- Chèn dữ liệu vào bảng CHITIETDONHANG (OrderDetails)
-- Đảm bảo SoLuong > 0 và GiaBan >= 0
INSERT INTO CHITIETDONHANG (MaDonHang, MaSach, SoLuong, GiaBan) VALUES
('DH001', 'S001', 1, 85000.00),
('DH001', 'S008', 1, 120000.00), -- Tổng DH001: 85000 + 120000 = 205000
('DH002', 'S002', 1, 120000.00),
('DH003', 'S003', 1, 105000.00),
('DH004', 'S001', 2, 85000.00), -- Tổng DH004: 2 * 85000 = 170000
('DH004', 'S009', 1, 60000.00), -- Sửa lại để khớp với Tổng Tiền trong DONHANG
('DH005', 'S005', 1, 130000.00),
('DH006', 'S006', 1, 95000.00),
('DH007', 'S007', 1, 75000.00),
('DH008', 'S008', 1, 110000.00),
('DH009', 'S009', 1, 60000.00),
('DH010', 'S010', 1, 80000.00);
