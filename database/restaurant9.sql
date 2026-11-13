SET NAMES utf8mb4;

DROP DATABASE IF EXISTS restaurant9;
CREATE DATABASE restaurant9 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE restaurant9;

-- ---------------------------------------------------------------------
-- Thành viên, nhân viên
-- ---------------------------------------------------------------------
CREATE TABLE tblMember9 (
    id       INT          NOT NULL AUTO_INCREMENT,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    fullName VARCHAR(255) NOT NULL,
    birthday DATE         NOT NULL,
    address  VARCHAR(255) NOT NULL,
    email    VARCHAR(255) NOT NULL,
    phone    VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_tblMember9_username (username)
);

CREATE TABLE tblStaff9 (
    position     VARCHAR(255) NOT NULL,
    tblMember9id INT          NOT NULL,
    PRIMARY KEY (tblMember9id),
    CONSTRAINT fk_tblStaff9_tblMember9 FOREIGN KEY (tblMember9id) REFERENCES tblMember9 (id)
);

CREATE TABLE tblSaleStaff9 (
    tblStaff9id INT NOT NULL,
    PRIMARY KEY (tblStaff9id),
    CONSTRAINT fk_tblSaleStaff9_tblStaff9 FOREIGN KEY (tblStaff9id) REFERENCES tblStaff9 (tblMember9id)
);

CREATE TABLE tblWarehouseStaff9 (
    tblStaff9id INT NOT NULL,
    PRIMARY KEY (tblStaff9id),
    CONSTRAINT fk_tblWarehouseStaff9_tblStaff9 FOREIGN KEY (tblStaff9id) REFERENCES tblStaff9 (tblMember9id)
);

-- ---------------------------------------------------------------------
-- Món ăn, combo
-- ---------------------------------------------------------------------
CREATE TABLE tblDishCategory9 (
    id          INT          NOT NULL AUTO_INCREMENT,
    name        VARCHAR(255) NOT NULL,
    description VARCHAR(255) NULL,
    PRIMARY KEY (id)
);

CREATE TABLE tblDish9 (
    id                 INT          NOT NULL AUTO_INCREMENT,
    name               VARCHAR(255) NOT NULL,
    price              DOUBLE       NOT NULL,
    description        VARCHAR(255) NULL,
    image              VARCHAR(255) NULL,
    tblDishCategory9id INT          NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_tblDish9_tblDishCategory9 FOREIGN KEY (tblDishCategory9id) REFERENCES tblDishCategory9 (id)
);

CREATE TABLE tblCombo9 (
    id          INT          NOT NULL AUTO_INCREMENT,
    name        VARCHAR(255) NOT NULL,
    price       DOUBLE       NOT NULL,
    description VARCHAR(255) NULL,
    image       VARCHAR(255) NULL,
    PRIMARY KEY (id)
);

CREATE TABLE tblComboDish9 (
    id          INT NOT NULL AUTO_INCREMENT,
    quantity    INT NOT NULL,
    tblCombo9id INT NOT NULL,
    tblDish9id  INT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_tblComboDish9_tblCombo9 FOREIGN KEY (tblCombo9id) REFERENCES tblCombo9 (id),
    CONSTRAINT fk_tblComboDish9_tblDish9  FOREIGN KEY (tblDish9id)  REFERENCES tblDish9 (id)
);

-- ---------------------------------------------------------------------
-- Bàn, khách hàng, đặt bàn
-- ---------------------------------------------------------------------
CREATE TABLE tblTable9 (
    id       INT          NOT NULL AUTO_INCREMENT,
    name     VARCHAR(255) NOT NULL,
    capacity INT          NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE tblCustomer9 (
    id       INT          NOT NULL AUTO_INCREMENT,
    fullName VARCHAR(255) NOT NULL,
    phone    VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_tblCustomer9_phone (phone)
);

CREATE TABLE tblMembershipCard9 (
    id             INT          NOT NULL AUTO_INCREMENT,
    cardCode       VARCHAR(255) NOT NULL,
    createdDate    DATE         NOT NULL,
    points         INT          NOT NULL,
    tblCustomer9id INT          NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_tblMembershipCard9_cardCode (cardCode),
    UNIQUE KEY uq_tblMembershipCard9_tblCustomer9id (tblCustomer9id),
    CONSTRAINT fk_tblMembershipCard9_tblCustomer9 FOREIGN KEY (tblCustomer9id) REFERENCES tblCustomer9 (id)
);

CREATE TABLE tblTableReservation9 (
    id             INT          NOT NULL AUTO_INCREMENT,
    arrivalTime    DATETIME     NOT NULL,
    note           VARCHAR(255) NULL,
    status         VARCHAR(255) NOT NULL,
    tblTable9id    INT          NOT NULL,
    tblCustomer9id INT          NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_tblTableReservation9_tblTable9    FOREIGN KEY (tblTable9id)    REFERENCES tblTable9 (id),
    CONSTRAINT fk_tblTableReservation9_tblCustomer9 FOREIGN KEY (tblCustomer9id) REFERENCES tblCustomer9 (id)
);

-- ---------------------------------------------------------------------
-- Đơn hàng, hóa đơn
-- ---------------------------------------------------------------------
CREATE TABLE tblOrder9 (
    id                     INT          NOT NULL AUTO_INCREMENT,
    createdTime            DATETIME     NOT NULL,
    status                 VARCHAR(255) NOT NULL,
    tblTable9id            INT          NOT NULL,
    tblTableReservation9id INT          NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_tblOrder9_tblTableReservation9id (tblTableReservation9id),
    CONSTRAINT fk_tblOrder9_tblTable9            FOREIGN KEY (tblTable9id)            REFERENCES tblTable9 (id),
    CONSTRAINT fk_tblOrder9_tblTableReservation9 FOREIGN KEY (tblTableReservation9id) REFERENCES tblTableReservation9 (id)
);

CREATE TABLE tblOrderedDish9 (
    id          INT    NOT NULL AUTO_INCREMENT,
    quantity    INT    NOT NULL,
    price       DOUBLE NOT NULL,
    tblOrder9id INT    NOT NULL,
    tblDish9id  INT    NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_tblOrderedDish9_tblOrder9 FOREIGN KEY (tblOrder9id) REFERENCES tblOrder9 (id),
    CONSTRAINT fk_tblOrderedDish9_tblDish9  FOREIGN KEY (tblDish9id)  REFERENCES tblDish9 (id)
);

CREATE TABLE tblOrderedCombo9 (
    id          INT    NOT NULL AUTO_INCREMENT,
    quantity    INT    NOT NULL,
    price       DOUBLE NOT NULL,
    tblOrder9id INT    NOT NULL,
    tblCombo9id INT    NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_tblOrderedCombo9_tblOrder9 FOREIGN KEY (tblOrder9id) REFERENCES tblOrder9 (id),
    CONSTRAINT fk_tblOrderedCombo9_tblCombo9 FOREIGN KEY (tblCombo9id) REFERENCES tblCombo9 (id)
);

CREATE TABLE tblInvoice9 (
    id              INT      NOT NULL AUTO_INCREMENT,
    paymentTime     DATETIME NOT NULL,
    tblOrder9id     INT      NOT NULL,
    tblSaleStaff9id INT      NOT NULL,
    tblCustomer9id  INT      NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_tblInvoice9_tblOrder9id (tblOrder9id),
    CONSTRAINT fk_tblInvoice9_tblOrder9     FOREIGN KEY (tblOrder9id)     REFERENCES tblOrder9 (id),
    CONSTRAINT fk_tblInvoice9_tblSaleStaff9 FOREIGN KEY (tblSaleStaff9id) REFERENCES tblSaleStaff9 (tblStaff9id),
    CONSTRAINT fk_tblInvoice9_tblCustomer9  FOREIGN KEY (tblCustomer9id)  REFERENCES tblCustomer9 (id)
);

-- ---------------------------------------------------------------------
-- Kho: nhà cung cấp, nguyên liệu, phiếu nhập
-- ---------------------------------------------------------------------
CREATE TABLE tblSupplier9 (
    id      INT          NOT NULL AUTO_INCREMENT,
    name    VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone   VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE tblIngredient9 (
    id   INT          NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    unit VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE tblImportInvoice9 (
    id                   INT  NOT NULL AUTO_INCREMENT,
    importDate           DATE NOT NULL,
    tblSupplier9id       INT  NOT NULL,
    tblWarehouseStaff9id INT  NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_tblImportInvoice9_tblSupplier9       FOREIGN KEY (tblSupplier9id)       REFERENCES tblSupplier9 (id),
    CONSTRAINT fk_tblImportInvoice9_tblWarehouseStaff9 FOREIGN KEY (tblWarehouseStaff9id) REFERENCES tblWarehouseStaff9 (tblStaff9id)
);

CREATE TABLE tblImportedIngredient9 (
    id                  INT    NOT NULL AUTO_INCREMENT,
    quantity            FLOAT  NOT NULL,
    price               DOUBLE NOT NULL,
    tblImportInvoice9id INT    NOT NULL,
    tblIngredient9id    INT    NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_tblImportedIngredient9_tblImportInvoice9 FOREIGN KEY (tblImportInvoice9id) REFERENCES tblImportInvoice9 (id),
    CONSTRAINT fk_tblImportedIngredient9_tblIngredient9    FOREIGN KEY (tblIngredient9id)    REFERENCES tblIngredient9 (id)
);


-- =====================================================================
-- DỮ LIỆU MẪU
-- =====================================================================

-- Nhân viên bán hàng Nguyễn Văn A: nva / 123456 (BCrypt $2a$, jBCrypt 0.4)
INSERT INTO tblMember9 (id, username, password, fullName, birthday, address, email, phone) VALUES
(1, 'nva', '$2a$10$FhnrtQL84PaP3Xc/cL9mVOElWRZt6O/fYwYodTV84nS6jsBCj0Ra.', 'Nguyễn Văn A',
    '2000-01-01', 'Hà Đông, Hà Nội', 'nva@nhahang9.vn', '0901000001');
INSERT INTO tblStaff9 (position, tblMember9id) VALUES ('Nhân viên bán hàng', 1);
INSERT INTO tblSaleStaff9 (tblStaff9id) VALUES (1);

-- Danh mục
INSERT INTO tblDishCategory9 (id, name, description) VALUES
(1, 'Khai vị',     'Các món ăn nhẹ trước bữa chính'),
(2, 'Món chính',   'Các món ăn chính'),
(3, 'Đồ uống',     'Nước uống các loại'),
(4, 'Tráng miệng', 'Các món tráng miệng');

-- Món ăn
INSERT INTO tblDish9 (id, name, price, description, image, tblDishCategory9id) VALUES
(1, 'Đùi gà rán',        40000, 'Đùi gà tẩm bột chiên giòn',       'https://res.cloudinary.com/dun6z7yyg/image/upload/v1794582613/dui_ga_ran_y3a16j.jpg',        2),
(2, 'Cánh gà chiên mắm', 35000, 'Cánh gà chiên giòn sốt nước mắm', 'https://res.cloudinary.com/dun6z7yyg/image/upload/v1794582632/canh_ga_mam_xpvtcg.jpg', 2),
(3, 'Khoai tây chiên',   15000, 'Khoai tây cắt thanh chiên giòn',  'https://res.cloudinary.com/dun6z7yyg/image/upload/v1794582641/khoai_tay_chien_jevfjn.jpg',   1),
(4, 'Nước cam cỡ vừa',   15000, 'Nước cam vắt tươi cỡ vừa',        'https://res.cloudinary.com/dun6z7yyg/image/upload/v1794582655/nuoc_cam_zwqc4f.jpg',   3),
(5, 'Kem vani',          20000, 'Kem vani mát lạnh',               'https://res.cloudinary.com/dun6z7yyg/image/upload/v1794582664/kem_vani_zdwnca.jpg',          4);

-- Combo bữa trưa vui vẻ: Đùi gà rán x1, Khoai tây chiên x1, Nước cam cỡ vừa x1
INSERT INTO tblCombo9 (id, name, price, description, image) VALUES
(1, 'Combo bữa trưa vui vẻ', 65000, 'Combo món ăn chỉ phục vụ vào buổi trưa', 'https://res.cloudinary.com/dun6z7yyg/image/upload/v1794583034/combo_uc2evo.jpg');
INSERT INTO tblComboDish9 (id, quantity, tblCombo9id, tblDish9id) VALUES
(1, 1, 1, 1),
(2, 1, 1, 3),
(3, 1, 1, 4);

-- Bàn ăn
INSERT INTO tblTable9 (id, name, capacity) VALUES
(1,  'Bàn 1',  2), (2,  'Bàn 2',  2), (3,  'Bàn 3',  4), (4,  'Bàn 4',  4), (5,  'Bàn 5',  4),
(6,  'Bàn 6',  4), (7,  'Bàn 7',  6), (8,  'Bàn 8',  6), (9,  'Bàn 9',  8), (10, 'Bàn 10', 8),
(11, 'Bàn 11', 2), (12, 'Bàn 12', 4), (13, 'Bàn 13', 4), (14, 'Bàn 14', 6), (15, 'Bàn 15', 6);

-- Khách hàng: Trần Văn C có thẻ thành viên; Lê Thị D không có thẻ
INSERT INTO tblCustomer9 (id, fullName, phone) VALUES
(1, 'Trần Văn C', '0912345678'),
(2, 'Lê Thị D',   '0987654321');
INSERT INTO tblMembershipCard9 (id, cardCode, createdDate, points, tblCustomer9id) VALUES
(1, 'TV0001', '2026-01-15', 0, 1);

-- Đơn hàng của Bàn 5 và Bàn 15 ở trạng thái "Đang phục vụ"
INSERT INTO tblOrder9 (id, createdTime, status, tblTable9id, tblTableReservation9id) VALUES
(1, '2026-10-05 18:30:00', 'Đang phục vụ', 5,  NULL),
(2, '2026-10-05 19:00:00', 'Đang phục vụ', 15, NULL);

-- Chi tiết đơn hàng của Bàn 5
INSERT INTO tblOrderedDish9 (id, quantity, price, tblOrder9id, tblDish9id) VALUES
(1, 2, 40000, 1, 1),
(2, 2, 15000, 1, 3),
(3, 3, 15000, 1, 4);
INSERT INTO tblOrderedCombo9 (id, quantity, price, tblOrder9id, tblCombo9id) VALUES
(1, 1, 65000, 1, 1);

-- Chi tiết đơn hàng của Bàn 15
INSERT INTO tblOrderedDish9 (id, quantity, price, tblOrder9id, tblDish9id) VALUES
(4, 2, 35000, 2, 2),
(5, 2, 15000, 2, 4);