<?php
//file:ambildata_jsonEncode.php --> dipanggil oleh aksesMap.js 
//untuk membaca peta semua kecamatan dan kondisi lahan`dan dibaca saat awal akses aplikasi
//membaca data dari database dan membuat json dengan fungsi json_encode()
header('Content-Type: application/json');

require ('connect.php');

$sql = "SELECT a.*, 
	`b`.`nama_kecamatan` as `nama_kecamatan`, 
	`c`.`nama_status` as `nama_status`,
	`c`.`warna` as `warna`
	FROM `lokasi_lahan` AS `a`
	JOIN `kecamatan` AS `b` ON a.kecamatan = b.id
	JOIN `status` AS `c` ON a.status = c.id
	ORDER BY `a`.`id`";

$data = mysqli_query($kon,$sql);
$lokasi=array();
while($x = mysqli_fetch_assoc($data)){
		$lokasi[]=$x;
	}

echo '{"lahan":'.json_encode($lokasi).'}';
?>
