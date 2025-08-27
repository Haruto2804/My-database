use QuanLyChuyenBay
go
-- TRUY VAN DON GIAN

--1. Cho biết mã số, tên phi công, địa chỉ, điện thoại của các phi công đã
--từng lái máy bay loại B747.
SELECT nv.MANV, nv.TEN,nv.DCHI,nv.DTHOAI, kn.MALOAI
FROM NHANVIEN AS nv JOIN KHANANG AS kn ON nv.MANV = kn.MANV
WHERE kn.MALOAI LIKE 'B747'

--2. Cho biết mã số và ngày đi của các chuyến bay xuất phát từ sân bay
--DCA trong khoảng thời gian từ 14 giờ đến 18 giờ.
SELECT lb.MACB, lb.NGAYDI, cb.GIODI, cb.SBDI
FROM LICHBAY AS lb JOIN CHUYENBAY AS cb On lb.MACB = cb.MACB
WHERE cb.SBDI = 'DCA' AND DATEPART(hour, cb.GIODI) >=14 AND DATEPART(hour, cb.GIODI)<=18
--3. Cho biết tên những nhân viên được phân công trên chuyến bay có mã
--số 100 xuất phát tại sân bay SLC. Các dòng dữ liệu xuất ra không được
--phép trùng lắp.
SELECT DISTINCT nv.TEN, cb.SBDI,cb.MACB
FROM PHANCONG AS pc JOIN NHANVIEN AS nv ON pc.MANV = nv.MANV
                    JOIN LICHBAY AS lb ON lb.MACB = pc.MACB 
					JOIN CHUYENBAY AS cb ON lb.MACB = cb.MACB
WHERE pc.MACB = '100' AND cb.SBDI = 'SLC'
--4. Cho biết mã loại và số hiệu máy bay đã từng xuất phát tại sân bay MIA.
--Các dòng dữ liệu xuất ra không được phép trùng lắp.
SELECT DISTINCT *
FROM CHUYENBAY AS cb JOIN LICHBAY AS lb ON cb.MACB = lb.MACB
                     JOIN MAYBAY AS mb ON mb.MALOAI = lb.MALOAI AND mb.SOHIEU = lb.SOHIEU
WHERE cb.SBDI = 'MIA'
--5. Cho biết mã chuyến bay, ngày đi, cùng với tên, địa chỉ, điện thoại của
--tất cả các hành khách đi trên chuyến bay đó. Sắp xếp theo thứ tự tăng
--dần của mã chuyến bay và theo ngày đi giảm dần.
SELECT dc.MACB,dc.NGAYDI,kh.TEN,kh.DCHI,kh.DTHOAI
FROM KHACHHANG AS kh JOIN DATCHO AS dc ON kh.MAKH = dc.MAKH
ORDER BY dc.MACB DESC, dc.NGAYDI DESC

--6. Cho biết mã chuyến bay, ngày đi, cùng với tên, địa chỉ, điện thoại của
--tất cả những nhân viên được phân công trong chuyến bay đó. Sắp xếp
--theo thứ tự tăng dần của mã chuyến bay và theo ngày đi giảm dần.
SELECT pc.MACB,pc.NGAYDI,nv.TEN,nv.DCHI,nv.DTHOAI
FROM NHANVIEN AS nv JOIN PHANCONG AS pc ON nv.MANV = pc.MANV
ORDER BY pc.MACB ASC, pc.NGAYDI ASC

--7. Cho biết mã chuyến bay, ngày đi, mã số và tên của những phi công
--được phân công vào chuyến bay hạ cánh xuống sân bay ORD.
SELECT cb.MACB,lb.NGAYDI,nv.MANV,nv.TEN,kn.MALOAI
FROM CHUYENBAY AS cb JOIN LICHBAY AS lb ON cb.MACB = lb.MACB
                     JOIN PHANCONG AS pc ON pc.MACB = lb.MACB AND pc. NGAYDI = lb.NGAYDI
					 JOIN NHANVIEN AS nv ON nv.MANV = pc.MANV
					 LEFT JOIN KHANANG AS kn ON nv.MANV = kn.MANV
WHERE kn.MANV IS NOT NULL AND cb.SBDEN LIKE 'ORD'

--8. Cho biết các chuyến bay (mã số chuyến bay, ngày đi và tên của phi
--công) trong đó phi công có mã 1001 được phân công lái.
SELECT *
FROM NHANVIEN AS nv JOIN PHANCONG AS pc ON nv.MANV = pc.MANV
WHERE nv.MANV IN (
                    SELECT kn.MANV
					FROM KHANANG AS kn
                 )
--9. Cho biết thông tin (mã chuyến bay, sân bay đi, giờ đi, giờ đến,
--ngày đi) của những chuyến bay hạ cánh xuống DEN. Các chuyến bay
--được liệt kê theo ngày đi giảm dần và sân bay xuất phát (SBDI) tăng
--dần .
SELECT cb.MACB,cb.SBDI,cb.GIODI,cb.GIODEN,lb.NGAYDI
FROM CHUYENBAY AS cb JOIN LICHBAY AS lb ON cb.MACB =lb.MACB
WHERE cb.SBDEN = 'DEN'
ORDER BY lb.NGAYDI DESC, cb.SBDI ASC

--10. Với mỗi phi công, cho biết hãng sản xuất và mã loại máy bay mà phi
--công này có khả năng bay được. Xuất ra tên phi công, hãng sản xuất
--và mã loại máy bay.
SELECT nv.TEN,LOAIMB.HANGSX,LOAIMB.MALOAI
FROM NHANVIEN AS NV LEFT JOIN KHANANG AS kn ON nv.MANV = kn.MANV
                    JOIN LOAIMB ON LOAIMB.MALOAI = kn.MALOAI
WHERE kn.MANV IS NOT NULL 

--11. Cho biết mã phi công, tên phi công đã lái máy bay trong chuyến bay
--mã số 100 vào ngày 11/01/2000.
SELECT nv.MANV AS MaPhiCong ,nv.TEN AS TenPhiCong,pc.MACB,pc.NGAYDI
FROM NHANVIEN AS nv JOIN PHANCONG AS pc ON nv.MANV = pc.MANV
WHERE nv.MANV IN (
					SELECT kn.MANV
					FROM KHANANG AS kn 
				)
	  AND pc.MACB = '100' AND pc.NGAYDI = '2000-11-01'
       
--12. Cho biết mã chuyến bay, mã nhân viên, tên nhân viên được phân công
--vào chuyến bay xuất phát ngày 10/31/2000 tại sân bay MIA vào lúc
--20:30
SELECT cb.MACB, nv.MANV,nv.TEN
FROM CHUYENBAY AS cb JOIN LICHBAY AS lb ON cb.MACB = lb.macb
					 JOIN PHANCONG AS pc ON lb.MACB = pc.MACB AND lb.NGAYDI = pc.NGAYDI
					 JOIN NHANVIEN AS nv ON nv.MANV = pc.MANV
WHERE pc.NGAYDI = '2000-10-31' AND cb.SBDI ='MIA'
--13. Cho biết thông tin về chuyến bay (mã chuyến bay, số hiệu, mã loại,
--hãng sản xuất) mà phi công "Quang" đã lái.
SELECT pc.MACB, mb.SOHIEU,mb.MALOAI,lmb.HANGSX,nv.TEN
FROM NHANVIEN AS nv JOIN KHANANG AS kn ON nv.MANV = kn.MANV
                    JOIN LOAIMB AS lmb ON lmb.MALOAI = kn.MALOAI
					JOIN MAYBAY AS mb ON mb.MALOAI = lmb.MALOAI
					JOIN PHANCONG AS pc ON pc.MANV = nv.MANV
WHERE nv.TEN LIKE 'Quang'
--14. Cho biết tên của những phi công chưa được phân công lái chuyến bay
--nào.
SELECT *
FROM NHANVIEN AS nv LEFT JOIN PHANCONG AS pc ON nv.MANV = pc.MANV
WHERE nv.MANV IN (
					SELECT kn.MANV
					FROM KHANANG AS kn
				 )
AND pc.MACB IS NULL
--15. Cho biết tên khách hàng đã đi chuyến bay trên máy bay của hãng
--"Boeing"
SELECT *
FROM KHACHHANG AS kh JOIN DATCHO AS dc ON kh.MAKH = dc.MAKH
					 JOIN LICHBAY AS lb ON lb.MACB = dc.MACB AND lb.NGAYDI =dc.NGAYDI
					 JOIN MAYBAY AS mb ON lb.MALOAI = mb.MALOAI AND lb.SOHIEU =mb.SOHIEU
					 JOIN LOAIMB AS lmb ON lmb.MALOAI = mb.MALOAI
WHERE lmb.HANGSX = 'BOEING'
--16. Cho biết mã các chuyến bay chỉ bay với máy bay số hiệu 10 và mã loại
--B747.
SELECT *
FROM LICHBAY AS lb
WHERE lb.SOHIEU ='10' AND lb.MALOAI = 'B747'


-- GOM NHOM + HAM
--17. Với mỗi sân bay (SBDEN), cho biết số lượng chuyến bay hạ cánh xuống
--sân bay đó. Kết quả được sắp xếp theo thứ tự tăng dần của sân bay
--đến.
SELECT cb.SBDEN,COUNT (cb.MACB) AS SoLuongChuyenBayHaCanh
FROM CHUYENBAY AS cb
GROUP BY cb.SBDEN
ORDER BY cb.SBDEN ASC

--18. Với mỗi sân bay (SBDI), cho biết số lượng chuyến bay xuất phát từ sân
--bay đó, sắp xếp theo thứ tự tăng dần của sân bay xuất phát.
SELECT cb.SBDI, COUNT (cb.MACB) AS SoLuongChuyenBayXuatPhat
FROM CHUYENBAY AS cb
GROUP BY cb.SBDI
ORDER BY cb.SBDI ASC

--19. Với mỗi sân bay (SBDI), cho biết số lượng chuyến bay xuất phát theo
--từng ngày. Xuất ra mã sân bay đi, ngày và số lượng.
SELECT cb.SBDI, lb.NGAYDI, COUNT (cb.MACB)
FROM CHUYENBAY AS cb JOIN LICHBAY AS lb On cb.MACB = lb.MACB
GROUP BY cb.SBDI, lb.NGAYDI

--20. Với mỗi sân bay (SBDEN), cho biết số lượng chuyến bay hạ cánh theo
--từng ngày. Xuất ra mã sân bay đến, ngày và số lượng. Với mỗi lịch bay, cho biết mã chuyến bay, ngày đi cùng với số lượng
--nhân viên không phải là phi công của chuyến bay đó.
SELECT cb.SBDEN, lb.NGAYDI, COUNT (cb.MACB) AS SoLuongChuyenBay
FROM CHUYENBAY AS cb JOIN LICHBAY AS lb On cb.MACB = lb.MACB
                     JOIN PHANCONG AS pc ON pc.MACB = lb.MACB AND pc.NGAYDI = lb.NGAYDI
					 JOIN NHANVIEN AS nv ON pc.MANV = nv.MANV
WHERE nv.MANV NOT IN 
				(
				    SELECT kn.MANV
					FROM KHANANG AS kn 
				)
GROUP BY cb.SBDEN, lb.NGAYDI

--22. Số lượng chuyến bay xuất phát từ sân bay MIA vào ngày 11/01/2000.
SELECT cb.SBDI, lb.NGAYDI,COUNT (*) AS SoLuongChuyenBayXuatPhatTuSanBayMIA
FROM CHUYENBAY AS cb JOIN LICHBAY AS lb ON cb.MACB = lb.MACB
WHERE cb.SBDI = 'MIA' AND lb.NGAYDI = '2000-11-1'
GROUP BY cb.SBDI, lb.NGAYDI


--23. Với mỗi chuyến bay, cho biết mã chuyến bay, ngày đi, số lượng nhân
--viên được phân công trên chuyến bay đó, sắp theo thứ tự giảm dần
--của số lượng.
SELECT cb.MACB, lb.NGAYDI, COUNT (pc.MANV) AS SoLuongChuyenBay
FROM CHUYENBAY AS cb JOIN LICHBAY AS lb On cb.MACB = lb.MACB
                     JOIN PHANCONG AS pc ON pc.MACB = lb.MACB AND pc.NGAYDI = lb.NGAYDI
					 JOIN NHANVIEN AS nv ON nv.MANV = pc.MANV
GROUP BY cb.MACB, lb.NGAYDI
ORDER BY COUNT (pc.MANV) DESC

--24. Với mỗi chuyến bay, cho biết mã chuyến bay, ngày đi, cùng với số
--lượng hành khách đã đặt chỗ của chuyến bay đó, sắp theo thứ tự giảm
--dần của số lượng.
SELECT cb.MACB, lb.NGAYDI, COUNT (kh.MAKH) AS SoLuongKhachHang
FROM CHUYENBAY AS cb JOIN LICHBAY AS lb ON cb.MACB = lb.MACB
                     JOIN DATCHO AS dc ON dc.NGAYDI = lb.NGAYDI AND dc.MACB = lb.MACB
					 JOIN KHACHHANG AS kh ON kh.MAKH = dc.MAKH
GROUP BY cb.MACB, lb.NGAYDI
ORDER BY SoLuongKhachHang DESC

--25. Với mỗi chuyến bay, cho biết mã chuyến bay, ngày đi, tổng lương của
--phi hành đoàn (các nhân viên được phân công trong chuyến bay), sắp
--xếp theo thứ tự tăng dần của tổng lương.
SELECT cb.MACB, lb.NGAYDI, SUM (nv.LUONG) AS TongLuong
FROM CHUYENBAY AS cb JOIN LICHBAY AS lb ON cb.MACB = lb.MACB
				     JOIN PHANCONG AS pc ON pc.MACB = lb.MACB AND pc.NGAYDI = lb.NGAYDI
					 JOIN NHANVIEN AS nv ON nv.MANV = pc.MANV
GROUP BY cb.MACB, lb.NGAYDI
ORDER BY TongLuong ASC

--26. Cho biết lương trung bình của các nhân viên không phải là phi công.
SELECT AVG(nv.LUONG) AS LuongTrungBinhCuaPhiCong
FROM NHANVIEN AS nv
WHERE nv.MANV NOT IN (
					SELECT kn.MANV
					FROM KHANANG AS kn
				)

--27. Cho biết mức lương trung bình của các phi công
SELECT AVG(nv.LUONG) AS LuongTrungBinhCuaPhiCong
FROM NHANVIEN AS nv
WHERE nv.MANV IN (
					SELECT kn.MANV
					FROM KHANANG AS kn
				)

--28. Với mỗi loại máy bay, cho biết số lượng chuyến bay đã bay trên loại
--máy bay đó hạ cánh xuống sân bay ORD. Xuất ra mã loại máy bay, số
--lượng chuyến bay.
SELECT  mb.MALOAI, COUNT (lb.MALOAI) AS SoLuongChuyenBay
FROM CHUYENBAY AS cb JOIN LICHBAY AS lb ON cb.MACB = lb.MACB
					 JOIN MAYBAY AS mb ON mb.SOHIEU = lb.SOHIEU AND mb.MALOAI = lb.MALOAI
WHERE cb.SBDEN = 'ORD'
GROUP BY mb.MALOAI


--29. Cho biết sân bay (SBDI) và số lượng chuyến bay có nhiều hơn 2
--chuyến bay xuất phát trong khoảng 10 giờ đến 22 giờ.
SELECT cb.SBDI,COUNT (cb.MACB) AS SoLuongChuyenBay
FROM CHUYENBAY AS cb JOIN LICHBAY AS lb ON cb.MACB = lb.MACB
WHERE DATEPART (hour, cb.GIODI) >=10 AND DATEPART(hour,cb.GIODI) <=22
GROUP BY cb.SBDI
--30. Cho biết tên phi công được phân công vào ít nhất 2 chuyến bay trong
--cùng một ngày.
SELECT nv.TEN, lb.NGAYDI, COUNT (pc.MANV) AS SoLuongPhanCong
FROM NHANVIEN AS nv JOIN PHANCONG AS pc ON nv.MANV = pc.MANV
                    JOIN LICHBAY AS lb ON lb.MACB = pc.MACB AND lb.NGAYDI = pc.NGAYDI
WHERE nv.MANV IN (
					SELECT kn.MANV
					FROM KHANANG AS kn
				 )
GROUP BY nv.TEN, lb.NGAYDI
HAVING COUNT (pc.MANV) >=2

--31. Cho biết mã chuyến bay và ngày đi của những chuyến bay có ít hơn 3
--hành khách đặt chỗ.
SELECT dc.MACB, COUNT (kh.MAKH) AS SoLuongKhachHang
FROM CHUYENBAY AS cb JOIN LICHBAY AS lb ON cb.MACB = lb.MACB
				     JOIN DATCHO AS dc ON dc.MACB = lb.MACB AND dc.NGAYDI = lb.NGAYDI
					 JOIN KHACHHANG AS kh ON kh.MAKH = dc.MAKH
GROUP BY dc.MACB
HAVING COUNT (kh.MAKH) <3

--32. Cho biết số hiệu máy bay và loại máy bay mà phi công có mã 1001
--được phân công lái trên 2 lần.
SELECT lb.SOHIEU, lb.MALOAI, COUNT (lb.MALOAI) AS SoLuongDuocPhanCongLai
FROM NHANVIEN AS nv JOIN PHANCONG AS pc ON nv.MANV = pc.MANV
                    JOIN LICHBAY AS lb ON lb.MACB = pc.MACB AND lb.NGAYDI = pc.NGAYDI
WHERE nv.MANV IN ( 
				   SELECT kn.MANV
                   FROM KHANANG AS kn
				  )
GROUP BY lb.SOHIEU,lb.MALOAI
HAVING COUNT (lb.MALOAI) >2

--33. Với mỗi hãng sản xuất, cho biết số lượng loại máy bay mà hãng đó đã
--sản xuất. Xuất ra hãng sản xuất và số lượng
SELECt lmb.HANGSX, COUNT (lmb.MALOAI) AS SoLuong
FROM LOAIMB AS lmb 
GROUP BY lmb.HANGSX

--      TRUY VẤN LỒNG + HÀM
--34. Cho biết hãng sản xuất, mã loại và số hiệu của máy bay đã được sử
--dụng nhiều nhất.
SELECT lmb.HANGSX, lmb.MALOAI,mb.SOHIEU
FROM LOAIMB AS lmb JOIN MAYBAY AS mb ON lmb.MALOAI = mb.MALOAI
WHERE lmb.MALOAI IN 
					(
					SELECT TOP 1 with ties lmb.MALOAI
					FROM LOAIMB AS lmb JOIN MAYBAY AS mb ON lmb.MALOAI = mb.MALOAI
					GROUP BY lmb.MALOAI
					ORDER BY COUNT (lmb.MALOAI) DESC
					)

--35. Cho biết tên nhân viên được phân công đi nhiều chuyến bay nhất.
SELECT  *
FROM NHANVIEN AS nv
WHERE nv.MANV =	
				(
					SELECT TOP 1 with ties pc.MaNV
					FROM PHANCONG AS pc
					GROUP BY pc.MANV
					ORDER BY COUNT (pc.MACB) DESC
				)
--36. Cho biết thông tin của phi công (tên, địa chỉ, điện thoại) lái nhiều
--chuyến bay nhất.

SELECT nv.TEN,nv.DCHI,nv.DTHOAI
FROM NHANVIEN AS nv
WHERE nv.MaNv IN 
				(
					SELECT TOP 1 with ties pc.MANV
					FROM PHANCONG AS pc
					WHERE pc.MANV IN 
									(
										SELECT kn.MaNV
										FROM KHANANG AS kn
									)
					GROUP BY pc.MaNV 
					ORDER BY COUNT (pc.MACB) DESC
				)

--37. Cho biết sân bay (SBDEN) có số lượng chuyến bay của sân bay có ít
--chuyến bay đáp xuống nhất.
SELECT *
FROM CHUYENBAY AS cb
WHERE cb.SBDEN IN 
					(
						SELECT TOP 1 with ties cb.SBDEN
						FROM CHUYENBAY AS cb  
						GROUP BY cb.SBDEN
						ORDER BY COUNT(cb.MACB) ASC
					)

--38. Cho biết sân bay (SBDI) có số lượng chuyến bay của sân bay có nhiều
--chuyến bay xuất phát nhất.
SELECT *
FROM CHUYENBAY AS cb
WHERE cb.SBDI IN 
					(
						SELECT TOP 1 with ties cb.SBDI
						FROM CHUYENBAY AS cb  
						GROUP BY cb.SBDI
						ORDER BY COUNT(cb.MACB) DESC
					)
--39. Cho biết tên, địa chỉ, và điện thoại của khách hàng đã đi trên nhiều
--chuyến bay nhất.
SELECT kh.TEN, kh.DCHI,kh.DTHOAI
FROM KHACHHANG AS kh
WHERE kh. MAKH IN 
					(
					SELECT TOP 1 with ties dc.MAKH
					FROM DATCHO AS dc
					GROUP BY dc.MAKH
					ORDER BY COUNT (dc.MACB) DESC
					)


--40. Cho biết mã số, tên và lương của các phi công có khả năng lái nhiều
--loại máy baynhất.
SELECT *
FROM KHANANG AS kn
SELECT nv.MANV,nv.TEN,nv.LUONG
FROM NHANVIEN AS nv
WHERE nv.MANV IN 
				(
					SELECT TOP 1 with ties kn.MANV
					FROM KHANANG AS kn
					GROUP BY kn.MANV
					ORDER BY COUNT (kn.MALOAI) DESC
				)

--41. Cho biết thông tin (mã nhân viên, tên, lương) của nhân viên có mức
--lương cao nhất.
SELECT nv.MANV,nv.TEN,nv.LUONG
FROM NHANVIEN AS nv
WHERE nv.LUONG IN 
					(
						SELECT MAX(nv.LUONG)
						FROM NHANVIEN AS nv
					)

--42. Cho biết tên, địa chỉ của các nhân viên có lương cao nhất trong phi
--hành đoàn (các nhân viên được phân công trong một chuyến bay) mà
--người đó tham gia.
SELECT DISTINCT nv.TEN,nv.DCHI
FROM PHANCONG AS pc JOIN NHANVIEN AS nv ON nv.MANV = pc.MANV
WHERE nv.LUONG IN 
				(
					SELECT MAX(nv.LUONG)
					FROM NHANVIEN AS nv
				)
--43. Cho biết mã chuyến bay, giờ đi và giờ đến của chuyến bay bay sớm
--nhất trong ngày.
SELECt cb.MACB,cb.GIODI,cb.GIODEN
FROM CHUYENBAY AS cb
WHERE cb.MACB IN 
				(
				SELECT TOP 1 with ties cb.MACB
				FROM CHUYENBAY AS cb
				ORDER BY cb.GIODI ASC, cb.GIODEN ASC
				)

--44. Cho biết mã chuyến bay có thời gian bay dài nhất. Xuất ra mã chuyến
--bay và thời gian bay (tính bằng phút).
SELECT cb.MACB, DATEDIFF(HOUR,CB.GIODI,cb.GIODEN) * 60 AS ThoiGianBay
FROM CHUYENBAY AS Cb
WHERE cb.MACB IN 
				(
					SELECT TOP 1 with ties cb.MACB
					FROM CHUYENBAY AS cb
					ORDER BY DATEDIFF(HOUR,CB.GIODI,cb.GIODEN) * 60 DESC
													
				)

--45. Cho biết mã chuyến bay có thời gian bay ít nhất. Xuất ra mã chuyến
--bay và thời gian bay.
SELECT cb.MACB, DATEDIFF(HOUR,CB.GIODI,cb.GIODEN) * 60 AS ThoiGianBay
FROM CHUYENBAY AS Cb
WHERE cb.MACB IN 
				(
					SELECT TOP 1 with ties cb.MACB
					FROM CHUYENBAY AS cb
					ORDER BY DATEDIFF(HOUR,CB.GIODI,cb.GIODEN) * 60 ASC
													
				)
--46. Cho biết mã chuyến bay và ngày đi của những chuyến bay bay trên loại
--máy bay B747 nhiều nhất.

SELECT lb.MACB, lb.NGAYDI
FROM LICHBAY AS lb
WHERE lb.MACB IN 
				(
					SELECT TOP 1 with ties lb.MACB
					FROM LICHBAY AS lb
					GROUP BY lb.MACB
					ORDER BY COUNT(lb.MALOAI) DESC
													
				)
--47. Với mỗi chuyến bay có trên 3 hành khách, cho biết mã chuyến bay và
--số lượng nhân viên trên chuyến bay đó. Xuất ra mã chuyến bay và số
--lượng nhân viên.
SELECt pc.MACB, COUNT (pc.MANV) AS SoLuongNhanVIen
FROM PHANCONG AS pc
WHERE pc.MACB IN 
					(
						SELECT dc.MACB
						FROM DATCHO AS dc
						GROUP BY dc.MACB
						HAVING COUNT (dc.MAKH) > 3
					)
GROUP BY pc.MACB
--48. Với mỗi loại nhân viên có tổng lương trên 6000000, cho biết số lượng
--nhân viên trong từng loại nhân viên đó. Xuất ra loại nhân viên, và số
--lượng nhân viên tương ứng. (phi công - ko phải phi công) 
SELECT nv.LOAINV,COUNT (nv.MANV) As SLNV
FROM NHANVIEN AS nv
WHERE nv.MaNV IN (
							SELECT nv.MANV
							FROM NHANVIEN AS nv
							WHERE nv.LUONG > 6000000
					 )
GROUP BY nv.LOAINV

--49. Với mỗi chuyến bay có trên 3 nhân viên, cho biết mã chuyến bay và số
--lượng khách hàng đã đặt chỗ trên chuyến bay đó.
SELECt dc.MACB, COUNT (dc.MAKH) AS SoLuongHanhKhach
FROM DATCHO AS dc
WHERE dc.MACB IN 
					(
						SELECT dc.MACB
						FROM DATCHO AS dc
						GROUP BY dc.MACB
						HAVING COUNT (dc.MAKH) > 3
					)
GROUP BY dc.MACB
--50. Với mỗi loại máy bay có nhiều hơn một chiếc, cho biết số lượng chuyến
--bay đã được bố trí bay bằng loại máy bay đó. Xuất ra mã loại và số
--lượng.
SELECT mb.MALOAI, COUNT (mb.SOHIEU) AS SoLuong
FROM MAYBAY AS mb
WHERE mb.MALOAI IN 
					(
						SELECT mb.MALOAI
						FROM MAYBAY AS mb
						GROUP BY mb.MALOAI
						HAVING COUNT (mb.MALOAI) > 1
					)
GROUP BY mb.MALOAI

--51. Cho biết mã những chuyến bay đã bay tất cả các máy bay của hãng
--"Boeing".
SELECT *
FROM LICHBAY AS lb
WHERE lb.MALOAI LIKE 'B%'
GROUP BY lb.MACB
HAVING COUNT (lb.MALOAI) >= 
							(
								SELECT COUNT (lmb.MALOAI)
								FROM LOAIMB AS lmb
								WHERE lmb.HANGSX = 'BOEING'
							)








--52. Cho biết mã và tên phi công có khả năng lái tất cả các máy bay của
--hãng "Airbus".
SELECT nv.MANV, nv.TEN
FROM NHANVIEN AS nv JOIN KHANANG AS kn ON nv.MANV = kn.MANV
                   JOIN LOAIMB AS lmb ON kn.MALOAI = lmb.MALOAI
WHERE lmb.HANGSX = 'AIRBUS'
GROUP BY nv.MANV, nv.TEN
HAVING COUNT(DISTINCT kn.MALOAI) = (SELECT COUNT(MALOAI)
                                    FROM LOAIMB
                                    WHERE HANGSX = 'AIRBUS');
--53. Cho biết tên nhân viên (không phải là phi công) được phân công bay
--vào tất cả các chuyến bay có mã 100.
SELECT nv.TEN
FROM NHANVIEN AS nv JOIN PHANCONG AS pc ON nv.MANV = pc.MANV
WHERE nv.MANV NOT IN (SELECT MANV FROM KHANANG)
      AND pc.MACB = '100'
GROUP BY nv.TEN
HAVING COUNT(DISTINCT pc.NGAYDI) = (SELECT COUNT(DISTINCT NGAYDI)
                                      FROM LICHBAY
                                      WHERE MACB = '100');
--54. Cho biết ngày đi nào mà có tất cả các loại máy bay của hãng "Boeing"
--tham gia.55. Cho biết loại máy bay của hãng "Boeing" nào có tham gia vào tất cả
--các ngày đi.
SELECT lb.NGAYDI
FROM LICHBAY AS lb JOIN MAYBAY AS mb ON lb.MALOAI = mb.MALOAI AND lb.SOHIEU = mb.SOHIEU
                   JOIN LOAIMB AS lmb ON mb.MALOAI = lmb.MALOAI
WHERE lmb.HANGSX = 'BOEING'
GROUP BY lb.NGAYDI
HAVING COUNT(DISTINCT lb.MALOAI) = (SELECT COUNT(MALOAI)
                                    FROM LOAIMB
                                    WHERE HANGSX = 'BOEING');
-- 55. Cho biết loại máy bay của hãng "Boeing" nào có tham gia vào tất cả
-- các ngày đi.
SELECT lmb.MALOAI
FROM LOAIMB AS lmb JOIN MAYBAY AS mb ON lmb.MALOAI = mb.MALOAI
                   JOIN LICHBAY AS lb ON mb.MALOAI = lb.MALOAI AND mb.SOHIEU = lb.SOHIEU
WHERE lmb.HANGSX = 'BOEING'
GROUP BY lmb.MALOAI
HAVING COUNT(DISTINCT lb.NGAYDI) = (SELECT COUNT(DISTINCT NGAYDI) FROM LICHBAY);
--56. Cho biết mã và tên các khách hàng có đặt chổ trong tất cả các ngày từ
--31/10/2000 đến 1/1/2000
SELECT kh.MAKH, kh.TEN
FROM KHACHHANG AS kh JOIN DATCHO AS dc ON kh.MAKH = dc.MAKH
WHERE dc.NGAYDI >= '2000-10-31' AND dc.NGAYDI <= '2001-01-01'
GROUP BY kh.MAKH, kh.TEN
HAVING COUNT(DISTINCT dc.NGAYDI) = DATEDIFF(day, '2000-10-31', '2001-01-01') + 1;
--57. Cho biết mã và tên phi công không có khả năng lái được tất cả các máy
--bay của hãng "Airbus"
SELECT nv.MANV, nv.TEN
FROM NHANVIEN AS nv
WHERE nv.MANV IN (SELECT MANV FROM KHANANG)
      AND NOT EXISTS (SELECT lmb.MALOAI
                      FROM LOAIMB AS lmb
                      WHERE lmb.HANGSX = 'AIRBUS'
                      EXCEPT
                      SELECT kn.MALOAI
                      FROM KHANANG AS kn
                      WHERE kn.MANV = nv.MANV);
--58. Cho biết sân bay nào đã có tất cả các loại máy bay của hãng "Boeing"
--xuất phát.
SELECT cb.SBDI
FROM CHUYENBAY AS cb JOIN LICHBAY AS lb ON cb.MACB = lb.MACB
                   JOIN MAYBAY AS mb ON lb.MALOAI = mb.MALOAI AND lb.SOHIEU = mb.SOHIEU
                   JOIN LOAIMB AS lmb ON mb.MALOAI = lmb.MALOAI
WHERE lmb.HANGSX = 'BOEING'
GROUP BY cb.SBDI
HAVING COUNT(DISTINCT lb.MALOAI) = (SELECT COUNT(MALOAI)
                                    FROM LOAIMB
                                    WHERE HANGSX = 'BOEING');

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
