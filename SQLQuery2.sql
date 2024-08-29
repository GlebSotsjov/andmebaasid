-- Создание базы данных и выбор её
CREATE DATABASE autorentglebSotsjov;
USE autorentglebSotsjov;

-- Создание таблицы mark
CREATE TABLE mark(
    markID int NOT NULL PRIMARY KEY IDENTITY(1,1),
    autoMark varchar(30) UNIQUE
);

-- Вставка данных в таблицу mark
INSERT INTO mark(autoMark)
VALUES ('Ziguli'), ('Lambordzini'), ('BMW');

-- Создание таблицы kaigukast
CREATE TABLE kaigukast(
    kaigukastID int NOT NULL PRIMARY KEY IDENTITY(1,1),
    kaigukast varchar(30) UNIQUE
);

-- Вставка данных в таблицу kaigukast
INSERT INTO kaigukast(kaigukast)
VALUES ('Automaat'), ('Manual');

-- Создание таблицы auto
CREATE TABLE auto(
    autoID int NOT NULL PRIMARY KEY IDENTITY(1,1),
    regNumber varchar(6) UNIQUE,
    markID int,
    varv varchar(20),
    v_aasta int,
    kaigukastID int,
    km decimal(6,2),
    FOREIGN KEY (markID) REFERENCES mark(markID),
    FOREIGN KEY (kaigukastID) REFERENCES kaigukast(kaigukastID)
);

-- Вставка данных в таблицу auto
INSERT INTO auto (regNumber, markID, varv, v_aasta, kaigukastID, km)
VALUES 
('ABC123', 1, 'Red', 2020, 1, 15000.00),
('DEF456', 2, 'Black', 2019, 2, 30000.00),
('GHI789', 3, 'White', 2021, 1, 5000.00);

ALTER TABLE auto
ALTER COLUMN km decimal(8,2);

-- Создание таблицы klient
CREATE TABLE klient(
    klientID int NOT NULL PRIMARY KEY IDENTITY(1,1),
    kliendiNimi varchar(50),
    telefon varchar(20),
    aadress varchar(50),
    soiduKogemus varchar(30)
);

-- Вставка данных в таблицу klient
INSERT INTO klient (kliendiNimi, telefon, aadress, soiduKogemus) 
VALUES 
('Peeter Saar', '55512345', 'Tallinn, Estonia', '5 aastat'),
('Annika Leht', '55598765', 'Tartu, Estonia', '3 aastat'),
('Karl Õun', '55545678', 'Pärnu, Estonia', '10 aastat');

-- Создание таблицы tootaja
CREATE TABLE tootaja(
    tootajaID int NOT NULL PRIMARY KEY IDENTITY(1,1),
    tootajaNimi varchar(50),
    ametID int
);

-- Вставка данных в таблицу tootaja
INSERT INTO tootaja (tootajaNimi, ametID) 
VALUES 
('Jüri Mets', 101),
('Mari Tamm', 102),
('Kati Kask', 103);

-- Создание таблицы rendileping
CREATE TABLE rendileping(
    lepingID int NOT NULL PRIMARY KEY IDENTITY(1,1),
    rendiAlgus date,
    rendiLopp date,
    klientID int,
    regNumber varchar(6), 
    rendiKestvus int,
    hindKokku decimal(5,2),
    tootajaID int,
    FOREIGN KEY (klientID) REFERENCES klient(klientID),
    FOREIGN KEY (regNumber) REFERENCES auto(regNumber), 
    FOREIGN KEY (tootajaID) REFERENCES tootaja(tootajaID)
);

-- Вставка данных в таблицу rendileping
INSERT INTO rendileping (rendiAlgus, rendiLopp, klientID, regNumber, rendiKestvus, hindKokku, tootajaID)
VALUES 
('2023-08-01', '2023-08-05', 1, 'ABC123', 5, 250.00, 1),
('2023-08-10', '2023-08-15', 2, 'DEF456', 6, 300.00, 2),
('2023-08-20', '2023-08-25', 3, 'GHI789', 5, 275.00, 3);

-- Проверка данных в таблицах

-- Таблица mark
SELECT * FROM mark;

-- Таблица kaigukast
SELECT * FROM kaigukast;

-- Таблица auto
SELECT * FROM auto;

-- Таблица klient
SELECT * FROM klient;

-- Таблица tootaja
SELECT * FROM tootaja;

-- Таблица rendileping
SELECT rendileping.lepingID, klient.kliendiNimi, tootaja.tootajaNimi, rendileping.hindKokku, rendileping.regNumber
FROM rendileping
INNER JOIN klient ON rendileping.klientID = klient.klientID
INNER JOIN tootaja ON rendileping.tootajaID = tootaja.tootajaID;
