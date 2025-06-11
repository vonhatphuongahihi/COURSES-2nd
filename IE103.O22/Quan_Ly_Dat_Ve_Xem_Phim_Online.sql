CREATE DATABASE QUANLYDATVEXEMPHIMONLIE
-- Tạo các bảng --
USE QUANLYDATVEXEMPHIMONLIE
CREATE TABLE KHACHHANG
(
	MAKH VARCHAR(20) PRIMARY KEY,
	HOTEN NVARCHAR(50) NOT NULL,
	SDT CHAR(10) CHECK (SDT LIKE '0_________') UNIQUE,
	CCCD_CMND VARCHAR(20) NOT NULL UNIQUE,
	EMAIL VARCHAR(50) NOT NULL
)

CREATE TABLE TAIKHOAN
(
	MATK VARCHAR(20) PRIMARY KEY,
	TENTK NVARCHAR(50) NOT NULL,
	MATKHAU VARCHAR(20) NOT NULL,
	NGAYDKY SMALLDATETIME CHECK (NGAYDKY <= GETDATE()) NOT NULL,
	DIEMKM INT,
	MAKH VARCHAR(20) FOREIGN KEY REFERENCES KHACHHANG(MAKH)
)

CREATE TABLE KHUYENMAI
(
	MAKM VARCHAR(20) PRIMARY KEY,
	DKSD NVARCHAR(50) NOT NULL,
	NGAYBD SMALLDATETIME NOT NULL,
	NGAYKT SMALLDATETIME NOT NULL
)

CREATE TABLE THELOAIPHIM
(
	MATL VARCHAR(20) PRIMARY KEY,
	TENTL NVARCHAR(50) NOT NULL
)

CREATE TABLE PHIM
(
	MAPHIM VARCHAR(20) PRIMARY KEY,
	TENPHIM NVARCHAR(50) NOT NULL,
	NDPHIM NVARCHAR(2000) NOT NULL,
	DAODIEN NVARCHAR(50) NOT NULL,
	THOILUONG SMALLINT NOT NULL,
	NGAYKHOICHIEU SMALLDATETIME NOT NULL,
	NGONNGU NVARCHAR(50) NOT NULL,
	GIOIHANTUOI SMALLINT NOT NULL,
	NUOCSX NVARCHAR(50) NOT NULL,
	NAMSX SMALLDATETIME NOT NULL,
	LUOTDANHGIA SMALLINT NOT NULL,
	TRAILER NVARCHAR(20) NOT NULL,
	TRANGTHAIPHIM NVARCHAR(50) NOT NULL
)

CREATE TABLE DIENVIEN
(
	MADV VARCHAR(20) PRIMARY KEY,
	TENDV NVARCHAR(50) NOT NULL
)

CREATE TABLE RAPPHIM
(
	MARAP VARCHAR(20) PRIMARY KEY,
	TENRAP NVARCHAR(50) NOT NULL,
	DIADIEM NVARCHAR(100) NOT NULL,
	TRANGTHAIRAP NVARCHAR(50) NOT NULL
)

CREATE TABLE LOAIPHONG
(
	MALOAIPHONG VARCHAR(20) PRIMARY KEY,
	TENLOAIPHONG NVARCHAR(50) NOT NULL,
	TRANGTHAILP NVARCHAR(50) NOT NULL
)

CREATE TABLE PHONGCHIEU
(
	MAPHONG VARCHAR(20) PRIMARY KEY,
	TONGSOCHO SMALLINT CHECK (TONGSOCHO>=1) NOT NULL,
	TRANGTHAIPHONG NVARCHAR(50) NOT NULL,
	MALOAIPHONG VARCHAR(20) FOREIGN KEY REFERENCES LOAIPHONG(MALOAIPHONG),
	MARAP VARCHAR(20) FOREIGN KEY REFERENCES RAPPHIM(MARAP)
)
CREATE TABLE CACHIEU
(
	MACA VARCHAR(20) PRIMARY KEY,
	NGAYCHIEU SMALLDATETIME NOT NULL,
	THOIGIANBD SMALLDATETIME NOT NULL,
	THOIGIANKT SMALLDATETIME NOT NULL,
	TRANGTHAICA NVARCHAR(50) NOT NULL,
	MAPHONG VARCHAR(20) FOREIGN KEY REFERENCES PHONGCHIEU(MAPHONG),
	MAPHIM VARCHAR(20) FOREIGN KEY REFERENCES PHIM(MAPHIM)
)

CREATE TABLE LOAIGHE 
(
	MALOAIGHE VARCHAR(20) PRIMARY KEY,
	TENLOAIGHE NVARCHAR(50) NOT NULL
)

CREATE TABLE GHENGOI
(
	MAGHE VARCHAR(20) PRIMARY KEY,
	HANG VARCHAR(10) NOT NULL,
	COT TINYINT NOT NULL,
	TRANGTHAIGHE NVARCHAR(50) NOT NULL,
	MALOAIGHE VARCHAR(20) FOREIGN KEY REFERENCES LOAIGHE(MALOAIGHE)
)

CREATE TABLE DANHGIA 
(
	MADG VARCHAR(20) PRIMARY KEY,
	NOIDUNGDG NVARCHAR(2000) NOT NULL,
	MATK VARCHAR(20) FOREIGN KEY REFERENCES TAIKHOAN(MATK),
	MAPHIM VARCHAR(20) FOREIGN KEY REFERENCES PHIM(MAPHIM)
)

CREATE TABLE VE 
(
	MAVE VARCHAR(20) PRIMARY KEY,
	GIAVE MONEY NOT NULL,
	TENLOAIVE NVARCHAR(20) NOT NULL,
	VAT FLOAT NOT NULL,
	THANHTIEN MONEY NOT NULL,
	MACA VARCHAR(20) FOREIGN KEY REFERENCES CACHIEU(MACA),
	MAGHE VARCHAR(20) FOREIGN KEY REFERENCES GHENGOI(MAGHE),
	MAPHIM VARCHAR(20) FOREIGN KEY REFERENCES PHIM(MAPHIM)
)

CREATE TABLE DATVE
(
	MADATVE VARCHAR(20) NOT NULL,
	MAVE VARCHAR(20)  NOT NULL,
	FOREIGN KEY (MAVE) REFERENCES VE(MAVE),
	PRIMARY KEY (MADATVE,MAVE),
	NGAYDATVE SMALLDATETIME CHECK (NGAYDATVE <= GETDATE()) NOT NULL,
	SOLUONG SMALLINT CHECK (SOLUONG>=1) NOT NULL,
	THANHTIEN MONEY NOT NULL,
	TONGTIEN MONEY NOT NULL,
	MATK VARCHAR(20) FOREIGN KEY REFERENCES TAIKHOAN(MATK),
	MAKM VARCHAR(20) FOREIGN KEY REFERENCES KHUYENMAI(MAKM)
)

CREATE TABLE PHIM_THELOAIPHIM
(
	MATL VARCHAR(20) NOT NULL,
	MAPHIM VARCHAR(20) NOT NULL,
	FOREIGN KEY (MATL) REFERENCES THELOAIPHIM(MATL),
	FOREIGN KEY (MAPHIM) REFERENCES PHIM(MAPHIM),
	PRIMARY KEY (MATL,MAPHIM)
)

CREATE TABLE PHIM_DIENVIEN
(
	MADV VARCHAR(20) NOT NULL,
	MAPHIM VARCHAR(20) NOT NULL,
	FOREIGN KEY (MADV) REFERENCES DIENVIEN(MADV),
	FOREIGN KEY (MAPHIM) REFERENCES PHIM(MAPHIM),
	PRIMARY KEY (MADV,MAPHIM)
)	
-- Nhập dữ liệu --
-- Khach Hang --


INSERT INTO KHACHHANG(MAKH, HOTEN, SDT, CCCD_CMND, EMAIL)
VALUES ('KH01', N'Võ Nhất Phương', '0365486141', '056304004130', 'vonhatphuongahihi@gmail.com'),
	   ('KH02', N'Hoàng Gia Minh', '0365480153', '056304006758', 'hoanggiaminh@gmail.com'),
	   ('KHO3', N'Nguyễn Nhật Minh', '0365450178', '056304002367', 'nguyennhatminh@gmail.com'),
	   ('KH04', N'Nguyễn Minh Châu', '0974675431', '056302067453', 'nguyenminhchau@gmail.com'),
	   ('KH05', N'Lê Hoàng Hạ Uyển', '0864839204', '056301987654', 'lehoanghauyen@gmail.com')
-- Tai Khoan --
INSERT INTO TAIKHOAN (MATK, TENTK, MATKHAU, NGAYDKY, MAKH)
VALUES ('TK01', N'nhat phuong', 'Nhatphuong123', '2023-9-10', 'KH01'),
	   ('TK02', N'nhat phuong ahihi', 'Nhatphuong456', '2024-3-13', 'KH01'),
	   ('TK03', N'minhchau halo', '13032004', '2024-3-4', 'KH04'),
	   ('TK04', N'tuhyaenhh', 'chao04061303', '2023-6-4', 'KH05'),
	   ('TK05', N'giaminhhoang', 'minh2701', '2024-3-1', 'KH02'),
	   ('TK06', N'nhatminhnguyen', 'minh29', '2023-12-27', 'KH03')
-- Khuyen Mai --
INSERT INTO KHUYENMAI (MAKM, DKSD, MUCKM, NGAYBD, NGAYKT)
VALUES	('KM1','Đặt vé đôi','10','2023-7-12','2024-1-27'),
		('KM2','Đặt 3 vé','15','2023-1-26','2023-5-9'),
		('KM3','Đặt vé vip','15','2023-2-4','2023-7-11'),
		('KM4','Đặt 2 vé vip','20','2023-12-8','2024-3-15'),
		('KM5','Đặt 3 vé vip','25','2022-7-14','2023-1-22')
-- The Loai Phim --
INSERT INTO THELOAIPHIM (MATL, TENTL)
VALUES ('TL1', N'Kinh dị'),
	   ('TL2', N'Tình cảm'),
	   ('TL3', N'Hành động'),
	   ('TL4', N'Khoa học viễn tưởng'),
	   ('TL5', N'Hài kịch'),
	   ('TL6', N'Chiến tranh'),
	   ('TL7', N'Chính kịch'),
	   ('TL8', N'Quốc gia'),
	   ('TL9', N'Thần bí'),
	   ('TL10', N'Trinh thám'),
	   ('TL11', N'Hoạt hình')
-- Loai ghe --
INSERT INTO  LOAIGHE(MALOAIGHE, TENLOAIGHE)
VALUES	('LG1', N'Thường'),
		('LG2', N'Vip'),
		('LG3', N'Đôi')
-- Ghe ngoi --
INSERT INTO GHENGOI (MAGHE, HANG, COT, TRANGTHAIGHE, MALOAIGHE)
VALUES	('G01','A','10', N'Đã đặt','LG1'),
		('G02','H','2', N'Đã đặt','LG2'),
		('G03','F','7', N'Còn trống','LG1'),
		('G04','B','8', N'Đã đặt','LG3'),
		('G05','J','5', N'Còn trống','LG2')
-- Phim --
INSERT INTO PHIM(MAPHIM, TENPHIM, NDPHIM, DAODIEN, THOILUONG, NGAYKHOICHIEU,
NGONNGU, GIOIHANTUOI, NUOCSX, NAMSX, LUOTDANHGIA, TRAILER, TRANGTHAIPHIM)
VALUES ('P01', N'Đào, phở và piano', N'Lấy bối cảnh trận chiến đông xuân kéo dài 60 ngày đêm từ cuối năm 1946 đến đầu năm 1947 ở Hà Nội, 
câu chuyện theo chân chàng dân quân Văn Dân và chuyện tình với nàng tiểu thư đam mê dương cầm Thục Hương. Khi những người khác đã di 
tản lên chiến khu, họ quyết định cố thủ lại mảnh đất thủ đô đã tan hoang vì bom đạn, mặc cho những hiểm nguy đang chờ đợi trước mắt.', 
N'Phi Tiến Sơn', 100, '2024-2-22', N'Tiếng Việt', 16, N'Việt Nam',
2023, 8590, N'Có', 'Đang chiếu'),
	('P02', N'Quật mộ trùng ma', N'Hai pháp sư, một thầy phong thuỷ và một chuyên gia khâm liệm cùng hợp lực khai quật ngôi mộ bị nguyền
	rủa của một gia đình giàu có, nhằm cứu lấy sinh mạng hậu duệ cuối cùng trong dòng tộc. Bí mật hắc ám của tổ tiên được đánh thức.', 
	N'Jang Jae Hyun', 150, '2024-3-15', N'Tiếng Việt', 16, N'Hàn Quốc', 2023, 10500,
	N'Có', 'Đang chiếu'),
	('P03', N'Godzilla X Kong: Đế chế mới 2D (K)', N'Kong và Godzilla - hai sinh vật vĩ đại huyền thoại, hai kẻ thủ truyền kiếp sẽ cùng bắt
	 tay thực thi một sứ mệnh chung mang tính sống còn để bảo vệ nhân loại, và trận chiến gắn kết chúng với loài người mãi mãi sẽ bắt đầu.',
	 N'Adam Wingard', 125, '2024-3-27', N'Tiếng Việt', 6, N'Mỹ', 2023, 800, N'Không', 'Đang chiếu'),
	('P04', N'Biệt đội săn ma: Kỷ nguyên băng giá', N'Sau các sự kiện của Ghostbusters: Afterlife, gia đình Spengler đang tìm kiếm cuộc sống mới 
	ở Thành phố New York. Nhóm săn ma bao gồm Ray, Winston và Podcast sử dụng công nghệ mới để chống lại các mối đe dọa chết người cổ xưa đang ẩn 
	náu trong các vật dụng hàng ngày. Thế nhưng, họ sẽ phải đối đầu với một thế lực đen tối hùng mạnh mới.', N'Gil Kenan', 99, '2024-3-29', N'Tiếng Việt',
	6, N'Mỹ', 2023, 0, N'Có', 'Sắp chiếu'),
	('P05', N'Monkey Man báo thù', N'Một chàng trẻ vô danh, đã bắt đầu cuộc hành trình trả thù chống lại những kẻ lãnh đạo tham nhũng đã sát hại mẹ anh và đàn áp những người nghèo khổ và yếu thế hơn.',
	N'Dev Patel', 120, '2024-5-4', N'Tiếng Việt', 16, N'Mỹ', 2023, 0, N'Có', 'Sắp chiếu')

--Loại Phòng--
INSERT INTO  LOAIPHONG (MALOAIPHONG, TENLOAIPHONG, TRANGTHAILP)
VALUES	('LP1', N'Phòng 2D','Còn'),
		('LP2', N'Phòng 3D','Hết')
--Phòng Chiếu--
INSERT INTO  PHONGCHIEU (MAPHONG, TONGSOCHO, TRANGTHAIPHONG, MALOAIPHONG, MARAP)
VALUES	('PC1', 100, N'Còn chỗ', 'LP1','R1'),
		('PC2', 75, N'Hết chỗ', 'LP2','R3'),
		('PC3', 95, N'Còn chỗ', 'LP1','R4'),
		('PC4', 114, N'Hết chỗ', 'LP1','R5'),
		('PC5', 86, N'Còn chỗ', 'LP2','R2')

--Diễn viên--
INSERT INTO DIENVIEN (MADV, TENDV)
VALUES ('DV01', N'Dev Patel'),
	   ('DV02', N'Sharlto Copley'),
	   ('DV03', N'Pitobash'),
	   ('DV04', N'Choi Min Sik'),
	   ('DV05', N'Kim Go Eun'),
	   ('DV06', N'Lee Do Hyun'),
	   ('DV07', N'Rebecca Hall'),
	   ('DV08', N'Dan Stevens'),
	   ('DV09', N'Rachel House'),
	   ('DV10', N'Doãn Quốc Đam'),
	   ('DV11', N'Cao Thị Thùy Linh'),
	   ('DV12', N'Trần Lực'),
	   ('DV13', N'William Atherton'),
	   ('DV14', N'Emily Alyn Lind')
-- Đánh giá --
INSERT INTO DANHGIA (MADG, NOIDUNGDG, MATK, MAPHIM)
VALUES ('DG01', N'Lâu lắm mới phải canh me 1 phim để xem như vậy. Không biết m.n đi xem theo trend hay ủng hộ phim về đề tài lịch sử thật. Nhưng mình cũng thấy vui và cảm động về lòng yêu nước của tất cả mọi người. ',
'TK01',  'P01'),
	   ('DG02', N'Lâu lắm mới có 1 bộ phim được đầu tư và để lại nhiều ấn tượng với mình như vậy. Là một người con sinh ra trong gia đình có truyền thống yêu nước thì đây quả thật là một bộ phim mà mình mong đợi. ', 
	    'TK03', 'P01'),
		('DG03', N'Cá nhân mình thấy nội dung dễ đoán rồi , thêm hầu như cảnh phim hoạt quay bị rối khiến khán giả chưa hiểu chuyện gì vừa xảy ra vậy. ',
		'TK04', 'P01'),
		('DG04', N'Phim có sự chỉn chu về mặt hình ảnh, cốt truyện mặc dù về chủ đề tâm linh nhưng cũng được xây dựng một cách có hệ thống, bài bản và rành mạch nên những người không rành về tâm linh như mình cũng vẫn có thể xem và hiểu được. Diễn xuất của dàn diễn viên đều tốt',
		'TK04', 'P02'),
		('DG05', N'Hiệu ứng âm thanh đỉnh, xem phim thì ko sợ đâu nhưng âm thanh khiến mình trở nên hồi hộp
  So với âm thanh thì hình ảnh có phần kém hơn, nhưng vẫn hay do truyền tải những văn hóa tâm linh của ng Hàn, nhưng nó ko đáng sợ nên nếu ai muốn xem phim kinh dị sợ hãi các thứ thì phim này ko đáp ứng đc',
  'TK05', 'P02'),
		('DG06', N'Phim có nhiều phân đoạn đấm nhau của quái thú rất đã mắt, âm thanh sống động, có điều do toàn cảnh mấy con thú to ngang ngang nhau và không đánh ở thành phố nên cảm giác không hoành tráng như phần 2021, nhưng giải trí thì vẫn rất ổn nha',
		'TK05', 'PK03')
-- Phim_Diễn viên --
INSERT INTO PHIM_DIENVIEN (MAPHIM, MADV)
VALUES ('P02','DV04'),
	   ('P02', 'DV05'),
	   ('P02', 'DV06'),
	   ('P01', 'DV10'),
	   ('P01', 'DV11'),
	   ('P01', 'DV12'),
	   ('P03', 'DV07'),
	   ('P03', 'DV08'),
	   ('P03', 'DV09'),
	   ('P04', 'DV13'),
	   ('P04', 'DV14'),
	   ('P05', 'DV01'),
	   ('P05', 'DV02'),
	   ('P05', 'DV03')
-- Ca Chiếu --
INSERT INTO CACHIEU (MACA, MAPHONG, MAPHIM, NGAYCHIEU, THOIGIANBD, THOIGIANKT,
TRANGTHAICA)
VALUES ('CA01', 'PC1', 'P01', '2024-2-27','20:30', '22:30', N'Đã kết thúc'),
	   ('CA02', 'PC1', 'P02', '2024-3-27', '20:00', '22:30', N'Chưa bắt đầu'),
	   ('CA03', 'PC1', 'P03', '2024-3-27', '17:00','19:00', N'Đang chiếu'),
	   ('CA04', 'PC1', 'P04', '2024-4-1', '17:00','19:00', N'Chưa bắt đầu'),
	   ('CA05', 'PC1', 'P05', '2024-4-5', '19:00','21:00', N'Chưa bắt đầu'),
	   ('CA06', 'PC2', 'P01', '2024-3-1', '18:30', '20:30', N'Đã kết thúc'),
	   ('CA07', 'PC2', 'P02', '2024-3-27', '17:00', '19:00', N'Đang chiếu'),
	   ('CA08', 'PC3', 'P03', '2024-03-27','17:00','19:00', N'Đang chiếu'),
	   ('CA10', 'PC2', 'P05', '2024-4-6','8:00','10:00', N'Chưa bắt đầu')
-- Phim_Thể loại phim --
INSERT INTO PHIM_THELOAIPHIM (MATL,MAPHIM)
VALUES ('TL9', 'P02'),
	   ('TL10', 'P02'),
	   ('TL1', 'P02'),
	   ('TL6', 'P01'),
	   ('TL7', 'P01'),
	   ('TL8', 'P01'),
	   ('TL3', 'P05'),
	   ('TL11', 'P04'),
	   ('TL4', 'P04'),
	   ('TL4', 'P03'),
	   ('TL3', 'P03')
-- Cập nhật trạng thái ghế khi có một vé đã đặt cho ghế --
GO
CREATE TRIGGER DAT_VE ON DATVE AFTER INSERT AS 
BEGIN 
UPDATE GHENGOI
SET TRANGTHAIGHE= N'Đã đặt'
FROM GHENGOI JOIN VE
ON GHENGOI.MAGHE = VE.MAGHE
JOIN INSERTED ON VE.MAVE = INSERTED.MAVE
END

-- Cập nhật trạng thái ghế khi có một vé đã đặt cho ghế bị hủy --
GO
CREATE TRIGGER HUY_GHE ON VE AFTER DELETE AS 
BEGIN 
UPDATE GHENGOI
SET TRANGTHAIGHE= N'Trống'
FROM GHENGOI JOIN VE
ON GHENGOI.MAGHE = VE.MAGHE
JOIN DELETED ON VE.MAVE = DELETED.MAVE 
END

-- Cập nhật tổng số ghế một phòng khi một ghế được thêm
GO
CREATE TRIGGER THEM_GHE
ON GHENGOI
AFTER INSERT
AS
BEGIN
    DECLARE @MaPhong VARCHAR(20)

    -- Lấy ra mã phòng của ghế vừa được thêm vào
    SELECT @MaPhong = MAPHONG
    FROM inserted

    -- Cập nhật tổng số ghế của phòng đó
    UPDATE PHONGCHIEU
    SET TONGSOCHO = TONGSOCHO + 1
    WHERE MAPHONG = @MaPhong
END
GO

-- Cập nhật tổng số ghế một phòng khi một ghế được xóa
CREATE TRIGGER XOA_GHE
ON GHENGOI
AFTER DELETE
AS
BEGIN
    DECLARE @MaPhong VARCHAR(20)

    -- Lấy ra mã phòng của ghế vừa được xóa
    SELECT @MaPhong = MAPHONG
    FROM deleted

    -- Cập nhật tổng số ghế của phòng đó
    UPDATE PHONGCHIEU
    SET TONGSOCHO = TONGSOCHO - 1
    WHERE MAPHONG = @MaPhong
END

-- Cập nhật tổng tiền trên hóa đơn đặt vé nếu có khuyến mãi --
GO
CREATE TRIGGER TONG_TIEN
ON DATVE
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @MaDatVe VARCHAR(20)
    DECLARE @MaVe VARCHAR(20)
    DECLARE @SoLuong INT
    DECLARE @MucKhuyenMai INT
    DECLARE @GiaVe MONEY
    DECLARE @TongTien MONEY
    DECLARE @ThanhTien MONEY

    -- Lấy thông tin từ dữ liệu vừa được thêm hoặc cập nhật
    SELECT @MaDatVe = MADATVE, @MaVe = MAVE, @SoLuong = SOLUONG, @MucKhuyenMai = KHUYENMAI.MUCKM, @GiaVe = VE.GIAVE
    FROM inserted
    INNER JOIN VE ON inserted.MAVE = VE.MAVE
    INNER JOIN KHUYENMAI ON inserted.MAKM = KHUYENMAI.MAKM

    -- Tính tổng tiền với khuyến mãi
    SET @ThanhTien = @GiaVe * @SoLuong
    SET @TongTien = @ThanhTien * (100 - @MucKhuyenMai) / 100

    -- Cập nhật tổng tiền trên hóa đơn đặt vé
    UPDATE DATVE
    SET THANHTIEN = @ThanhTien, TONGTIEN = @TongTien
    WHERE MADATVE = @MaDatVe AND MAVE = @MaVe
END

-- Mật khẩu phải có ít nhất một chữ cái, một chữ số và một kí tự đặc biệt ---
GO
CREATE TRIGGER KTRA_MATKHAU
ON TAIKHOAN
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @MatKhau VARCHAR(20)
    DECLARE @MatKhauPattern NVARCHAR(100) = '%[a-zA-Z]%[0-9]%[!@#$%^&*()]%'

    -- Lấy mật khẩu từ dữ liệu vừa được chèn hoặc cập nhật
    SELECT @MatKhau = MATKHAU
    FROM INSERTED

    -- Kiểm tra mật khẩu theo mẫu
    IF @MatKhau NOT LIKE @MatKhauPattern
    BEGIN
        PRINT 'Mật khẩu phải chứa ít nhất một chữ cái, một chữ số và một kí tự đặc biệt.'
        ROLLBACK TRANSACTION
        RETURN
    END
END

-- Kiểm tra tính hợp lệ của mã khuyến mãi khi đặt vé --
GO
CREATE TRIGGER KTRA_HOPLE_KM
ON DATVE
AFTER INSERT
AS
BEGIN
    DECLARE @MAKM VARCHAR(20)
    DECLARE @IsValid BIT

    -- Lấy mã khuyến mãi từ dữ liệu được chèn mới
    SELECT @MAKM = i.MAKM
    FROM INSERTED i

    -- Kiểm tra tính hợp lệ của mã khuyến mãi
    SELECT @IsValid = CASE 
                        WHEN EXISTS (SELECT 1 FROM KHUYENMAI WHERE MAKM = @MAKM AND NGAYKT >= GETDATE() AND NGAYBD <= GETDATE())
                        THEN 1
                        ELSE 0
                      END

    -- Nếu mã giảm giá không hợp lệ, rollback giao dịch và thông báo lỗi
    IF @IsValid = 0
    BEGIN
        PRINT 'Mã giảm giá không hợp lệ hoặc đã hết hạn.'
        ROLLBACK TRANSACTION
        RETURN
    END
END

-- Cập nhật số lượt đánh giá phim --
GO
CREATE TRIGGER KTRA_LDG1 ON DANHGIA AFTER INSERT AS
BEGIN
	DECLARE @MAPHIM VARCHAR(20)
	SELECT @MAPHIM = MAPHIM
	FROM INSERTED

	UPDATE PHIM
	SET LUOTDANHGIA = LUOTDANHGIA + 1
	WHERE MAPHIM = @MAPHIM
END

GO 
CREATE TRIGGER KTRA_LDG2 ON DANHGIA AFTER DELETED AS
BEGIN
	DECLARE @MAPHIM VARCHAR(20)
	SELECT @MAPHIM = MAPHIM
	FROM DELETED

	UPDATE PHIM
	SET LUOTDANHGIA = LUOTDANHGIA - 1
	WHERE MAPHIM = @MAPHIM
END

SELECT * FROM KHACHHANG