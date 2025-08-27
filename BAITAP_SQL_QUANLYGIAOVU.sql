--	1/	Tổng số cán bộ của khoa ‘Công nghệ thông tin’.
--2/	Số tín chỉ, số tiết lý thuyết và số tiết thực hành của môn 
--có tên là ‘Cơ sở dữ liệu’.
SELECT mh.sotinchi, mh.sotietLT,mh.sotietTH
FROM monhoc as mh
WHERE mh.tenmh = N'Cơ sở dữ liệu'
--3/	Danh sách mã số của giảng viên được phân công giảng dạy lý 
--thuyết ở học kỳ 1 hay học kỳ 2 năm học ‘2014-2015’.
SELECT giangvien.magv
FROM giangvien JOIN giangday ON giangvien.magv = giangday.magv
--4/	Danh sách mã số và họ tên của những sinh viên nữ 
--hay sinh viên thuộc tỉnh có mã là ‘56’.
SELECT sv.masv, sv.hosv +' '+sv.tensv AS HoTenSV
FROM sinhvien as sv
WHERE sv.phai = 1 OR sv.matinhtp = '56'
--5/	Danh sách những sinh viên thuộc khoa có mã số là ‘VL’ 
--và nhận học bổng hơn 100 000.
SELECT *
FROM SINHVIEN AS sv
WHERE sv.makhoa = 'VL' AND sv.hocbong > 100000
--6/	Danh sách mã số và tên của những môn học do giảng viên 
--có tên ‘Nguyễn Ngọc Thúy’ phụ trách giảng dạy lý thuyết.
SELECT gv.magv,gv.hoten
FROM monhoc as mh JOIN giangday AS gd ON mh.mamh =  gd.mamh
JOIN GIANGVIEN AS gv ON gv.magv = gd.magv
WHERE gv.hoten = N'Nguyễn Ngọc Thúy' AND gd.phutrach = 'LT'
--7/	Danh sách mã số và họ tên của những sinh viên nam có 
--điểm thi lần 1 môn ‘Cơ sở dữ liệu’ là 8 điểm.
SELECT *
FROM KETQUA AS kq JOIN MONHOC AS mh ON kq.mamh = mh.mamh
JOIN SINHVIEN AS sv ON sv.masv = kq.masv
WHERE mh.tenmh = N'Cơ sở dữ liệu' AND kq.diem = 8 AND kq.lanthi = 1
--8/	Danh sách mã số, họ tên sinh viên và tên những môn học 
--mà những sinh viên có đăng ký học và có kết quả thi.
SELECT *
FROM SINHVIEN AS sv
WHERE sv.masv IN  
				(
					SELECT dk.masv
					FROM DANGKY AS dk
				)
			  AND sv.masv  IN 
								(
									SELECT KETQUA.masv
									FROM KETQUA
								)



--9/	Danh sách tên những môn học được tổ chức cùng ngày thi 
--và cùng giờ thi trong học kỳ 1 năm ‘2014-2015’.
--> KHÔNG Có bảng này để làm câu truy vấn

--10/	Danh sách mã số và tên của những giảng viên vừa phụ trách dạy 
--lý thuyết vừa phụ trách dạy thực hành cho cùng một môn học.
SELECT *
FROM GIANGVIEN AS gv
WHERE gv.magv IN 
				(
				SELECT gd.magv
				FROM GIANGDAY AS gd
				GROUP BY gd.magv
				HAVING COUNT (gd.phutrach) >=2
				)

--11/	Danh sách tên của những môn học có số tín chỉ lớn hơn số tín chỉ của môn ‘Cơ sở dữ liệu’.
SELECT *
FROM MONHOC AS m
WHERE m.sotinchi > 
						(
							SELECT monhoc.sotinchi
							FROM monhoc
							WHERE monhoc.tenmh = N'Cơ sở dữ liệu'
						)

--12/	Danh sách họ tên sinh viên, điểm thi lý thuyết và thực hành lần 1 
--của môn ‘Cơ sở dữ liệu’ được sắp theo thứ tự điểm lý thuyết giảm dần, nếu trùng 
--điểm lý thuyết thì sắp theo điểm thực hành tăng dần.
SELECT sv.hosv++' '+sv.tensv AS HotenSV, kq.diem
FROM SINHVIEN AS sv JOIN KETQUA AS kq ON sv.masv = kq.masv
JOIN MONHOC AS mh ON mh.mamh = kq.mamh
WHERE kq.lanthi = 1 AND mh.tenmh = N'Cơ sở dữ liệu'
--13/	Danh sách tên của tất cả các môn học và tên giảng viên phụ trách lý 
--thuyết tương ứng, nếu có.
SELECT *
FROM MONHOC AS mh JOIN GIANGDAY AS gd ON mh.mamh = gd.mamh
JOIN GIANGVIEN AS gv On gv.magv = gd.magv
WHERE  mh.mamh IN 
					(
						SELECT gd.mamh
						FROM GIANGDAY AS gd
						WHERE gd.phutrach = 'LT'
					)

--14/	Danh sách mã số và họ tên của 3 sinh viên đứng đầu về điểm thi của 
--môn ‘Cấu trúc dữ liệu’ (yêu cầu tương tự cho đứng cuối).
SELECT TOP 3 with ties sv.masv, sv.hosv +' '+sv.tensv AS HotenSV, kq.diem
FROM SINHVIEN AS sv JOIN KETQUA AS kq oN sv.masv = kq.masv
JOIN MONHOC AS mh ON mh.mamh = kq.mamh
WHERE mh.tenmh = N'Cơ sở dữ liệu'
ORDER BY kq.diem DESC
--15/	Danh sách mã số, họ tên và số lượng thân nhân của mỗi giảng viên.
SELECT gv.MaGV, gv.HoTen, COUNT(tn.magv) AS SoLuongThanNhan
FROM GiangVien gv
LEFT JOIN ThanNhan tn ON gv.MaGV = tn.MaGV
GROUP BY gv.MaGV, gv.HoTen;
--16/	Danh sách mã số và họ tên giảng viên có trên 2 thân nhân.
SELECT gv.MaGV, gv.HoTen
FROM GiangVien gv
JOIN (SELECT MaGV, COUNT(tn.magv) AS SoLuongThanNhan
      FROM ThanNhan AS tn
      GROUP BY MaGV
      HAVING COUNT(tn.magv) > 2) AS ThongKeTN ON gv.MaGV = ThongKeTN.magv
--17/	Cho biết mã số và họ tên giảng viên không có thân nhân nào.
SELECT gv.MaGV, gv.HoTen
FROM GiangVien gv
LEFT JOIN ThanNhan tn ON gv.MaGV = tn.MaGV
WHERE tn.magv IS NULL;
--18/	Cho biết mã số và họ tên trưởng khoa có tối thiểu một thân nhân.
SELECT gv.magv, gv.hoten
FROM GIANGVIEN AS gv JOIN qlykhoa AS qlk ON gv.magv = qlk.magv
jOIN THANNHAN AS tn ON gv.magv = tn.magv
GROUP BY gv.magv, gv.hoten
HAVING COUNT (tn.magv) >1
--19/	Danh sách tên của những sinh viên chưa đăng ký học môn ‘Cấu trúc dữ liệu’ 
--trong học kỳ 1 năm ‘2014-2015’.
SELECT *
FROM SINHVIEN AS sv LEFT JOIN KETQUA AS kq ON sv.masv = kq.masv
WHERE kq.mamh <> 'CSDL'
--20/	Danh sách mã số, họ tên những sinh viên đứng đầu về điểm thi 
--lý thuyết môn ‘Cơ sở dữ liệu’ (yêu cầu tương tự cho đứng cuối).
SELECT TOP 1 with ties sv.masv, sv.hosv +' '+sv.tensv AS HotenSV, kq.diem
FROM SINHVIEN AS sv JOIN KETQUA AS kq oN sv.masv = kq.masv
JOIN MONHOC AS mh ON mh.mamh = kq.mamh
WHERE mh.tenmh = N'Cơ sở dữ liệu'
ORDER BY kq.diem DESC
--21/	Danh sách những sinh viên và tên những môn học đã đăng ký học 
--nhưng không có kết quả thi của môn học.
SELECT  sv.masv,sv.hosv+' '+sv.tensv AS HoTenSV, mh.tenmh
FROM SINHVIEN AS sv JOIN DANGKY AS dk ON sv.masv = dk.masv
LEFT JOIN KETQUA AS kq ON kq.masv = sv.masv
JOIN MONHOC AS mh ON dk.mamh = mh.mamh
WHERE kq.diem IS NULL

--22/	Danh sách tên của những môn học đã được phân công giảng dạy 
--trong học kỳ 1 năm ‘2014-2015’ nhưng không có sinh viên đăng ký.
SELECT *
FROM MONHOC AS mh JOIN GIANGDAY AS gd ON mh.mamh = gd.mamh
WHERE mh.mamh NOT IN 
					(
						SELECT dk.mamh
						FROM dangky AS dk
					)

--23/	Danh sách tên của những môn học đứng đầu về số tín chỉ trong số 
--những môn có số tiết lý thuyết bằng với số tiết thực hành (yêu cầu tương tự cho đứng cuối).
SELECT *
FROM MONHOC AS mh
WHERE mh.sotietLT = mh.sotietTH
ORDER BY mh.sotinchi DESC
--24/	Danh sách những sinh viên của khoa Công nghệ thông tin đứng 
--đầu về điểm lý thuyết trung bình (tương tự cho đứng cuối).
SELECT *
FROM sinhvien AS sv JOIN KETQUA AS kq ON sv.masv = kq.masv
WHERE sv.makhoa = 'CNTT' 
AND sv.masv IN 
				(
					SELECT TOP 1 with ties kq.masv
					FROM KETQUA AS kq
					GROUP BY kq.masv
					ORDER BY AVG (kq.diem) DESC
				)
--25/	Danh sách mã số môn học và số lượng sinh viên đăng ký theo 
--từng môn học trong năm học ‘2014-2015’.
SELECT dk.mamh, COUNT (dk.masv) AS SLSV
FROM dangky dk
WHERE dk.namhoc = '2014-2015'
GROUP BY dk.mamh
--26/	Danh sách mã số và tên giảng viên và số môn học mà giảng viên đó 
--được phân công giảng dạy lý thuyết trong học kỳ 1 năm ‘2014-2015’.
SELECT gv.magv, gv.hoten, COUNT (mh.mamh) AS SLMH
FROM GIANGVIEN AS gv JOIN giangday AS gd ON gv.magv = gd.magv
JOIN MONHOC AS mh ON mh.mamh = gd.mamh
WHERE gd.hocky = 1 AND gd.namhoc = '2014-2015'
GROUP BY gv.magv, gv.hoten
--27/	Danh sách mã số và họ tên của những sinh viên có cùng điểm thi lần 1 môn ‘Cấu trúc dữ liệu’.
SELECT kq1.masv, sv.masv, sv.hosv + ' '+sv.tensv  AS HotenSV
FROM KETQUA AS kq1, KETQUA AS kq2
JOIN SINHVIEN AS sv ON kq1.masv = sv.masv
WHERE kq1.masv <> kq2.masv AND kq1.diem = kq2.diem AND kq1.mamh = kq2.mamh
AND kq1.mamh IN 
					(
						SELECT KETQUA.mamh
						FROM KETQUA
						WHERE KETQUA.mamh = 'CTDL'
					)
--28/	Danh sách mã số và họ tên của những giảng viên đứng đầu về số lượng môn học được 
-- phân công giảng dạy lý thuyết trong học kỳ 1 năm ‘2014-2015’ (yêu cầu tương tự cho đứng cuối).
SELECT TOP 1 with ties gv.magv, gv.hoten, COUNT (gd.mamh) AS SLMH
FROM GIANGVIEN AS gv JOIN GIANGDAY AS gd On gv.magv = gd.magv
WHERE gd.hocky = 1 AND gd.namhoc = '2014-2015' AND gd.phutrach = 'LT'
GROUP BY gv.magv, gv.hoten
ORDER BY COUNT (gd.mamh) DESC
--29/	Danh sách mã số và họ tên giảng viên, tên khoa và tổng số lượng sinh viên của khoa mà giảng viên đang công tác.
SELECT sv.makhoa, gv.magv, gv.hoten, COUNT (sv.makhoa) 
FROM SINHVIEN AS sv JOIN khoa as k ON k.makhoa = sv.masv
JOIN GIANGVIEN AS gv ON gv.magv = k.makhoa
GROUP BY sv.makhoa



-- DDL
-- them moi thong tin cua 1 khoa
INSERT INTO khoa (makhoa,tenkhoa,tongsocb) VALUES ('TT','Toán tin',10)
--them moi thong tin cua 1 giang vien
INSERT INTO giangvien (magv,hoten,hocvi,makhoa) VALUES ('G010','Đinh Công Nam','TH','TT') 
--them moi thong tin than nhan cua giang vien dinh cong name
INSERT INTO thannhan (magv,hotentn,ngaysinhtn,moiquanhe) VALUES ('G010',N'Đinh Công Nữ','2026-09-26','Con')
INSERT INTO thannhan (magv,hotentn,ngaysinhtn,moiquanhe) VALUES ('G010','Mai Lan','1977-02-15','Vợ')
-- tao moi 1 bang sinh vien co hoc bong cau 4
CREATE TABLE SV_HOCBONG
(
	masv char(50) PRIMARY KEY NOT NULL,
	hosv nvarchar(20),
	tensv nvarchar(10),
	nu BIT,
	makhoa varchar(4),
	hocbong real
)
-- sao chep du lieu sinh vien co hoc bong sang SV_HOCBONG Tu bang SINHVIEN
INSERT INTO SV_HOCBONG (masv,hosv,tensv,nu,makhoa,hocbong)
SELECT masv,hosv,tensv,phai,makhoa,hocbong
FROM SINHVIEN
-- cap nhat hoc bong cua cac sinh vien khoa vat ly ma matinhtp =511
UPDATE SINHVIEN
SET hocbong = hocbong *1.3
WHERE SINHVIEN.makhoa = 'VL' AND SINHVIEN.matinhtp = 51
--cap nhat thong tin giang vien co magv = 'G001' nhu sau
UPDATE giangvien
SET giangvien.hoten = 'Nguyễn Văn Sơn', giangvien.hocham = 'PGS'
WHERE magv = 'G001'

--Cap nhat thong tin phong thi 307...
-- --> ko co bang nay trong co so du lieu nen khong the lam dc

--capp nhat thongg tin sinh vien 91045 nhu sau:
UPDATE SINHVIEN
SET SINHVIEN.phai = 1, SINHVIEN.ngaysinh ='1993-07-26'
WHERE SINHVIEN.masv = '91045'
-- xoa bang  SV_HOCBONG
DROP TABLE SV_HOCBONG
