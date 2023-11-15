-- create database 
DROP DATABASE db_kampus;
CREATE DATABASE db_kampus;
USE kampus;

CREATE TABLE mahasiswa (
    id_mahasiswa INT PRIMARY KEY,
    nama_mahasiswa VARCHAR(50),
    nim VARCHAR(10) UNIQUE,
    jurusan VARCHAR(50),
    tanggal_lahir DATE,
    alamat TEXT
);

CREATE TABLE matakuliah (
    id_matakuliah INT PRIMARY KEY,
    nama_matakuliah VARCHAR(255) NOT NULL,
    sks INT NOT NULL
);


CREATE TABLE perkuliahan (
    id_perkuliahan INT PRIMARY KEY,
    id_mahasiswa INT,
    id_matakuliah INT,
    nilai INT NOT NULL,
    FOREIGN KEY (id_mahasiswa) REFERENCES mahasiswa(id_mahasiswa),
    FOREIGN KEY (id_matakuliah) REFERENCES matakuliah(id_matakuliah)
);



-- insert mahasiswa
INSERT INTO mahasiswa (id_mahasiswa, nama_mahasiswa, nim, jurusan, tanggal_lahir, alamat)
VALUES
	(1, 'John Doe', '1234567890', 'Informatika', '1990-01-15', 'bandung'),
    (2, 'Jane Smith', '0987654321', 'Bisnis', '1992-03-20', 'bandung'),
    (3, 'Aerul Andi', '1234567891', 'Informatika', '1991-10-15', 'jakarta'),
    (4, 'Jane Dani', '0987654322', 'Bisnis', '1991-03-20', 'jakarta'),
    (5, 'Alice Johnson', '5678901234', 'Komunikasi', '1991-07-10', 'bandung');


-- insert MK 
INSERT INTO matakuliah (id_matakuliah, nama_matakuliah, sks)
VALUES 
	(1, 'Matematika Dasar', 3),
	(2, 'Fisika Dasar', 3);


-- insert perkuliahan
-- Memasukkan perkuliahan Mahasiswa 1 (id_mahasiswa) mengambil Matematika Dasar (id_matakuliah)
INSERT INTO perkuliahan (id_perkuliahan, id_mahasiswa, id_matakuliah, nilai)
VALUES 
	(1, 1, 1, 90),
	(2, 1, 2, 60),
	(3, 2, 1, 44),
	(4, 2, 2, 50),
	(5, 3, 1, 90),
	(6, 3, 2, 56),
	(7, 4, 1, 88),
	(8, 5, 2, 70);


-- JOIN ALL -- using blend aja
SELECT *
FROM mahasiswa
INNER JOIN perkuliahan ON mahasiswa.id_mahasiswa = perkuliahan.id_mahasiswa
INNER JOIN matakuliah ON perkuliahan.id_matakuliah = matakuliah.id_matakuliah;


-- find avg nilai mhs dari alamt 
SELECT mahasiswa.alamat, AVG(perkuliahan.nilai) AS rata_nilai
FROM perkuliahan
JOIN mahasiswa ON perkuliahan.id_mahasiswa = mahasiswa.id_mahasiswa
GROUP BY mahasiswa.alamat;

-- find avg nilai mhs dari jurusan 
SELECT mahasiswa.jurusan, AVG(perkuliahan.nilai) AS rata_nilai
FROM perkuliahan
JOIN mahasiswa ON perkuliahan.id_mahasiswa = mahasiswa.id_mahasiswa
GROUP BY mahasiswa.jurusan;

-- find avg nilai mhs dari mk 
SELECT matakuliah.nama_matakuliah, AVG(perkuliahan.nilai) AS rata_nilai
FROM perkuliahan
JOIN matakuliah ON perkuliahan.id_matakuliah = matakuliah.id_matakuliah
GROUP BY matakuliah.nama_matakuliah;

-- find avg matakuliah dari setiap prodi 
SELECT
  matakuliah.nama_matakuliah,
  mahasiswa.jurusan,
  AVG(perkuliahan.nilai) AS rata_nilai
FROM
  perkuliahan
  JOIN mahasiswa ON perkuliahan.id_mahasiswa = mahasiswa.id_mahasiswa
  JOIN matakuliah ON perkuliahan.id_matakuliah = matakuliah.id_matakuliah
GROUP BY
  mahasiswa.jurusan, matakuliah.nama_matakuliah;