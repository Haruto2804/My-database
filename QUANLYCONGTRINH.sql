-- 1. Cho biết danh sách các nhân viên của công ty.
SELECT *
FROM NHANVIEN
--2. Cho biết manv, họ tên, mức lương của các nhân viên. (Với thông tin cột họ tên được
--ghép từ 2 cột honv và tennv)
SELECT nv.manv, nv.honv+' '+nv.tennv AS HoTenNV,nv.mucluong 
FROM NHANVIEN AS nv

--	3. Cho biêt các mức lương hiện có của công ty. (Lưu ý loại bỏ các giá trị trùng nhau)
SELECT DISTINCT nv.mucluong
FROM NHANVIEN AS nv

-- 4. Cho biết danh sách các nhân viên có mức lương từ 5.000.000 đến 7.000.000. Sắp xếp
--giảm dần theo mức lương.
SELECT *
FROM NHANVIEN AS nv
WHERE nv.mucluong BETWEEN 5000000 AND 7000000
ORDER BY nv.mucluong DESC

-- 5. Cho biết danh sách các chi nhánh chưa có trưởng phòng, chi nhánh chưa có trưởng phòng
-- có nghĩa là giá trị tại cột manvptr của bảng CHINHANH có giá trị = NULL.
SELECT *
FROM CHINHANH
WHERE matruongcn IS NULL

-- 6. Cho biết danh sách các nhân viên có họ Lý và sinh năm 1988.
SELECT *
FROM NHANVIEN AS nv
WHERE nv.honv = N'Lý%' AND YEAR(ngaysinh) <1988

-- 7. Cho biết danh sách các công trình kết thúc vào năm 2010 của thành phố có mã 02.
SELECT *
FROM CONGTRINH AS ct JOIN THANHPHO AS tp ON tp.matp = ct.matp
WHERE YEAR(ct.ngaykt) = 2010 AND tp.matp = '02'

--8. Cho biết danh sách các nhân viên là phái nữ và làm việc trong chi nhánh có 
--mãcn là C01 hoặc C03.
SELECT *
FROM NHANVIEN AS nv JOIN CHINHANH AS cn ON nv.macn = cn.macn
WHERE nv.phai = N'Nữ' AND cn.macn IN ('C01','C03')

--9. Cho biết manv, họ tên và tuổi của 3 nhân viên làm trong chi nhánh có mã C03. Sắp xếp
--tăng dần theo tuổi.
SELECT TOP 3 nv.manv, nv.honv+' '+nv.tennv AS HoTenNV, DATEDIFF(yyyy,nv.ngaysinh,getDate()) AS Tuoi
FROM NHANVIEN AS nv JOIN CHINHANH AS cn ON nv.macn = cn.macn
WHERE cn.macn = 'C03'
ORDER BY  DATEDIFF(yyyy,nv.ngaysinh,getDate()) ASC

-- 10. Cho biết danh sách các nhân viên có mức lương cao nhất trong công ty.
SELECT TOP 1 with ties *
FROM NHANVIEN AS nv
ORDER BY mucluong DESC

--11. Cho biết danh sách mact, ngày bắt đầu, ngày kết thúc, 
-- số tháng thực hiện (= ngayktngaybd) có thời gian kết thúc - thời gian bắt đầu lớn hơn 12 tháng, 
--sắp xếp giảm dần theo số tháng
SELECT ct.mact, ct.ngaybd,ct.ngaykt, DATEDIFF(mm,ct.ngaybd,ct.ngaykt) AS SoThangThucHien
FROM CONGTRINH AS ct
WHERE DATEDIFF(mm,ct.ngaybd,ct.ngaykt) >12
ORDER BY SoThangThucHien DESC

--12. Cho biết danh sách tên những công trình, tên thành phố của các công trình do chi nhánh
--có mã ‘C03’ đã thực hiện.
SELECT ct.tenct,tp.tentp, cn.macn
FROM CONGTRINH AS ct 
JOIN THANHPHO AS tp ON ct.matp = tp.matp
JOIN CHINHANH AS cn ON cn.macn = ct.macn
WHERE cn.macn ='C03'

--13. Cho biết danh sách mã số, họ tên và ngày nhậm chức của người phụ trách của từng chi
SELECT cn.tencn, nv.manv,nv.honv+' '+nv.tennv AS HoTenNV, cn.ngaynhamchuc
FROM NHANVIEN AS nv JOIN CHINHANH AS cn ON nv.manv = cn.matruongcn


--14. Cho biết danh sách nhân viên của các chi nhánh có mã cn là ‘C01’ hoặc ‘C02’ và có
--mức lương trên 4.500.000. Thông tin hiển thị bao gồm tên cn, tennv, manv, mức lương.
SELECT  cn.tencn,nv.tennv,nv.manv,nv.mucluong
FROM NHANVIEN AS nv JOIN CHINHANH AS cn ON nv.macn = cn.macn
WHERE cn.macn IN('C01','C02') AND nv.mucluong >4500000

-- 15. Cho biết danh sách mã số, họ tên nhân viên, mã công trình và tên công trình mà trong
--đó nhân viên tham gia công trình với thời gian làm việc hơn 25 giờ/tuần.
SELECT nv.manv,nv.tennv,ct.mact,ct.tenct, pc.sogiotuan
FROM NHANVIEN AS nv JOIN PHANCONG AS pc ON nv.manv = pc.manv
JOIN CONGTRINH AS ct ON ct.mact = pc.mact
WHERE pc.sogiotuan >25

--16. Cho biết danh sách các nhân viên được phân công làm việc tại các công trình ở các
--thành phố ‘Hà Nội’, ‘Đà Nẵng’ và ‘Tp.HCM’, thông tin hiển thị bao gồm: tên công trình,
--tên nhân viên, tên thành phố, ngày bd, ngày kt.
SELECT ct.tenct,nv.tennv,tp.tentp,ct.ngaybd,ct.ngaykt
FROM NHANVIEN AS nv JOIN PHANCONG AS pc ON nv.manv = pc.manv
JOIN CONGTRINH AS ct ON pc.mact = ct.mact
JOIN THANHPHO AS tp ON ct.matp = tp.matp
WHERE tp.tentp IN (N'Hà Nội',N'Đà Nẵng','Tp HCM')

--17. Cho biết danh sách tên công trình, tên chi nhánh quản lý công trình cùng với họ tên
--trưởng chi nhánh đối với những công trình đang được thực hiện ở thành phố có mã số là ‘01’.
SELECT ct.tenct, cn.tencn, nv.tennv, tp.matp
FROM NHANVIEN AS nv JOIN CHINHANH AS cn ON nv.manv = cn.matruongcn
JOIN CONGTRINH AS ct ON cn.macn = ct.macn
JOIN THANHPHO AS tp ON ct.matp = tp.matp
WHERE tp.matp = '01'


--18. Cho biết danh sách tên chi nhánh đang quản lý những công trình được thực hiện ở Hà
--Nội và bắt đầu sau năm 2007
SELECT cn.tencn, ct.ngaybd
FROM CHINHANH AS cn JOIN CONGTRINH AS ct ON cn.macn = ct.macn
JOIN THANHPHO AS tp ON ct.matp = tp.matp
WHERE tp.tentp = N'Hà Nội' AND YEAR(ct.ngaybd)>2007



