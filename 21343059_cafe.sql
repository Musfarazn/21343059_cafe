-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 04 Jun 2023 pada 13.10
-- Versi server: 10.4.22-MariaDB
-- Versi PHP: 8.0.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `21343059_cafe`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_Tb059_pekerja` (IN `p_nama` VARCHAR(10), IN `p_no_hp` VARCHAR(13), IN `p_status` VARCHAR(10), IN `p_JK` VARCHAR(1))  BEGIN
INSERT INTO Tb059_pekerja(nama, no_hp, status, JK)
VALUES (p_nama, p_no_hp, p_status, p_JK);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `detail_meja`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `detail_meja` (
`no_meja` varchar(8)
,`tipe` varchar(8)
,`jenis_area` varchar(20)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `detail_menu`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `detail_menu` (
`menu` varchar(20)
,`jenis_menu` varchar(8)
,`harga` varchar(20)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `detail_pembayaran`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `detail_pembayaran` (
`no_meja` varchar(8)
,`tipe` varchar(8)
,`jenis_pembayaran` varchar(12)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb059_area`
--

CREATE TABLE `tb059_area` (
  `id_area` int(5) NOT NULL,
  `tipe` varchar(8) DEFAULT NULL,
  `jenis_area` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb059_area`
--

INSERT INTO `tb059_area` (`id_area`, `tipe`, `jenis_area`) VALUES
(101, 'VIP', 'Non Smoking'),
(102, 'Indoor', 'Non Smoking'),
(103, 'Outdoor', 'Smoking'),
(104, 'Rooftop', 'Smoking');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb059_fasilitas`
--

CREATE TABLE `tb059_fasilitas` (
  `perabotan` varchar(10) DEFAULT NULL,
  `jumlah` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb059_fasilitas`
--

INSERT INTO `tb059_fasilitas` (`perabotan`, `jumlah`) VALUES
('Kursi', 20),
('Sofa', 8),
('Meja', 15),
('wifi', 2),
('Toilet', 2),
('AC', 8),
('Alat Coffe', 4),
('Alat Dapur', 10),
('Mushola', 1);

--
-- Trigger `tb059_fasilitas`
--
DELIMITER $$
CREATE TRIGGER `kurangi_jumlah_fasilitas` AFTER INSERT ON `tb059_fasilitas` FOR EACH ROW BEGIN
    UPDATE Tb059_fasilitas
    SET jumlah = jumlah - 1
    WHERE perabotan = NEW.perabotan;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb059_jenis_menu`
--

CREATE TABLE `tb059_jenis_menu` (
  `id_menu` int(5) NOT NULL,
  `jenis_menu` varchar(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb059_jenis_menu`
--

INSERT INTO `tb059_jenis_menu` (`id_menu`, `jenis_menu`) VALUES
(1, 'Makanan'),
(2, 'Makanan'),
(3, 'Makanan'),
(4, 'Minuman'),
(5, 'Minuman'),
(6, 'Minuman'),
(7, 'Dessert'),
(8, 'Dessert'),
(9, 'Dessert');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb059_meja`
--

CREATE TABLE `tb059_meja` (
  `id_area` int(5) DEFAULT NULL,
  `no_meja` varchar(8) DEFAULT NULL,
  `tipe` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb059_meja`
--

INSERT INTO `tb059_meja` (`id_area`, `no_meja`, `tipe`) VALUES
(102, '04-08', 'Indoor'),
(103, '09-12', 'Outdoor'),
(104, '13-15', 'Rooftop'),
(101, '01-03', 'VIP');

--
-- Trigger `tb059_meja`
--
DELIMITER $$
CREATE TRIGGER `update_jumlah_meja` AFTER INSERT ON `tb059_meja` FOR EACH ROW BEGIN
UPDATE Tb059_area
SET jumlah_meja = (SELECT COUNT(*) FROM Tb059_meja WHERE Tb059_meja.id_area = Tb059_area.id_area)
WHERE Tb059_area.id_area = NEW.id_area;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb059_menu`
--

CREATE TABLE `tb059_menu` (
  `id_menu` int(5) DEFAULT NULL,
  `menu` varchar(20) DEFAULT NULL,
  `harga` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb059_menu`
--

INSERT INTO `tb059_menu` (`id_menu`, `menu`, `harga`) VALUES
(1, 'Ayam Bakar Madu', '20.000'),
(2, 'Cumi Saus Padang', '22.000'),
(3, 'Udang Saus Padang', '22.000'),
(4, 'Es Teh', '7.000'),
(5, 'Lemon Tea', '10.000'),
(6, 'Milk Shake', '10.000'),
(7, 'Pancake', '15.000'),
(8, 'Bolu Lumer', '20.000'),
(9, 'Puding', '15.000');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb059_pekerja`
--

CREATE TABLE `tb059_pekerja` (
  `nama` varchar(10) DEFAULT NULL,
  `no_hp` varchar(13) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `JK` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb059_pekerja`
--

INSERT INTO `tb059_pekerja` (`nama`, `no_hp`, `status`, `JK`) VALUES
('Musfara', '082345076647', 'Manager', 'P'),
('Mara', '08218735545', 'Kasir', 'P'),
('Jamal', '0823456478', 'Barista', 'L'),
('Udin', '0812343566', 'Satpam', 'L'),
('Siska', '0897342324', 'Chef', 'P'),
('Isna', '0823070762', 'Pelayan', 'P'),
('Princes', '08244683663', 'Pelayan', 'P'),
('Siska', '0897342324', 'Chef', 'P'),
('Musfara', '082345076647', 'Manager', 'P');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb059_pembayaran`
--

CREATE TABLE `tb059_pembayaran` (
  `jenis_pembayaran` varchar(12) DEFAULT NULL,
  `jenis_transaksi` varchar(10) DEFAULT NULL,
  `no_meja` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `tb059_pembayaran`
--

INSERT INTO `tb059_pembayaran` (`jenis_pembayaran`, `jenis_transaksi`, `no_meja`) VALUES
('E-Money', 'Non Tunai', ''),
('Cash', 'Tunai', '01-03'),
('Mbanking', 'Non Tunai', '04-08'),
('Kartu Kredit', 'Non Tunai', '09-12'),
('Code QR', 'Non Tunai', '13-15');

-- --------------------------------------------------------

--
-- Struktur untuk view `detail_meja`
--
DROP TABLE IF EXISTS `detail_meja`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `detail_meja`  AS SELECT `tb059_meja`.`no_meja` AS `no_meja`, `tb059_meja`.`tipe` AS `tipe`, `tb059_area`.`jenis_area` AS `jenis_area` FROM (`tb059_meja` join `tb059_area` on(`tb059_meja`.`id_area` = `tb059_area`.`id_area`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `detail_menu`
--
DROP TABLE IF EXISTS `detail_menu`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `detail_menu`  AS SELECT `tb059_menu`.`menu` AS `menu`, `tb059_jenis_menu`.`jenis_menu` AS `jenis_menu`, `tb059_menu`.`harga` AS `harga` FROM (`tb059_menu` join `tb059_jenis_menu` on(`tb059_menu`.`id_menu` = `tb059_jenis_menu`.`id_menu`)) ;

-- --------------------------------------------------------

--
-- Struktur untuk view `detail_pembayaran`
--
DROP TABLE IF EXISTS `detail_pembayaran`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `detail_pembayaran`  AS SELECT `tb059_meja`.`no_meja` AS `no_meja`, `tb059_meja`.`tipe` AS `tipe`, `tb059_pembayaran`.`jenis_pembayaran` AS `jenis_pembayaran` FROM (`tb059_meja` join `tb059_pembayaran` on(`tb059_meja`.`no_meja` = `tb059_pembayaran`.`no_meja`)) ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `tb059_area`
--
ALTER TABLE `tb059_area`
  ADD PRIMARY KEY (`id_area`),
  ADD KEY `tipe` (`tipe`);

--
-- Indeks untuk tabel `tb059_jenis_menu`
--
ALTER TABLE `tb059_jenis_menu`
  ADD PRIMARY KEY (`id_menu`);

--
-- Indeks untuk tabel `tb059_meja`
--
ALTER TABLE `tb059_meja`
  ADD PRIMARY KEY (`tipe`),
  ADD KEY `id_area` (`id_area`),
  ADD KEY `no_meja` (`no_meja`);

--
-- Indeks untuk tabel `tb059_menu`
--
ALTER TABLE `tb059_menu`
  ADD KEY `id_menu` (`id_menu`);

--
-- Indeks untuk tabel `tb059_pembayaran`
--
ALTER TABLE `tb059_pembayaran`
  ADD PRIMARY KEY (`no_meja`);

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `tb059_area`
--
ALTER TABLE `tb059_area`
  ADD CONSTRAINT `tb059_area_ibfk_1` FOREIGN KEY (`tipe`) REFERENCES `tb059_meja` (`tipe`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tb059_meja`
--
ALTER TABLE `tb059_meja`
  ADD CONSTRAINT `tb059_meja_ibfk_1` FOREIGN KEY (`id_area`) REFERENCES `tb059_area` (`id_area`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tb059_meja_ibfk_2` FOREIGN KEY (`no_meja`) REFERENCES `tb059_pembayaran` (`no_meja`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `tb059_menu`
--
ALTER TABLE `tb059_menu`
  ADD CONSTRAINT `tb059_menu_ibfk_1` FOREIGN KEY (`id_menu`) REFERENCES `tb059_jenis_menu` (`id_menu`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
