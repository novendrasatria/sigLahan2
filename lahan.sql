-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 07 Jul 2019 pada 17.19
-- Versi server: 10.1.34-MariaDB
-- Versi PHP: 5.6.37

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lahan`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `kecamatan`
--

CREATE TABLE `kecamatan` (
  `id` int(11) NOT NULL,
  `nama_kecamatan` varchar(255) NOT NULL,
  `latitude` varchar(255) NOT NULL,
  `longitude` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `kecamatan`
--

INSERT INTO `kecamatan` (`id`, `nama_kecamatan`, `latitude`, `longitude`) VALUES
(1, 'Wonosobo Timur', '-7.3617721', '109.8950592'),
(2, 'Wonosobo', '-7.3608663', '109.8841953'),
(3, 'Garung', '-7.3608663', '109.8841953');

-- --------------------------------------------------------

--
-- Struktur dari tabel `lokasi_lahan`
--

CREATE TABLE `lokasi_lahan` (
  `id` int(11) NOT NULL,
  `nama_lokasi` varchar(255) NOT NULL,
  `kecamatan` int(11) NOT NULL,
  `alamat` text NOT NULL,
  `status` int(11) NOT NULL,
  `keterangan` text NOT NULL,
  `polygon` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `lokasi_lahan`
--

INSERT INTO `lokasi_lahan` (`id`, `nama_lokasi`, `kecamatan`, `alamat`, `status`, `keterangan`, `polygon`) VALUES
(1, 'Alun Alun', 1, 'Jl Kartini', 1, 'Tidak Dijual', '-7.3568562,109.8993721 -7.3617934,109.8950592 -7.356998,109.9058303'),
(2, 'Sasana Adipura', 2, 'Jl Soekarno Hatta\r\n', 2, 'Hanya Dijual', '-7.77182414305255,110.4983169555664 -7.791618064314864,110.4818374633789 -7.804823773446234,110.40827331542969 -7.8211011355174,110.44912872314453'),
(3, 'Ngradenan', 3, 'Jl Besi Tempa', 3, 'Hanya Untuk Palawija', '-7.92844,110.40740 -7.901307,110.4105340 -7.819393,110.464735 -7.865133,110.473661');

-- --------------------------------------------------------

--
-- Struktur dari tabel `status`
--

CREATE TABLE `status` (
  `id` int(11) NOT NULL,
  `nama_status` varchar(100) NOT NULL,
  `warna` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `status`
--

INSERT INTO `status` (`id`, `nama_status`, `warna`) VALUES
(1, 'Tidak dijual', '#FF0000'),
(2, 'Hanya untuk disewa', '#FF0000'),
(3, 'Untuk palawija', '#FF0000');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `kecamatan`
--
ALTER TABLE `kecamatan`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `lokasi_lahan`
--
ALTER TABLE `lokasi_lahan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kecamatan` (`kecamatan`),
  ADD KEY `status` (`status`);

--
-- Indeks untuk tabel `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `kecamatan`
--
ALTER TABLE `kecamatan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT untuk tabel `lokasi_lahan`
--
ALTER TABLE `lokasi_lahan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT untuk tabel `status`
--
ALTER TABLE `status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
