<?php
//file:caripeta.php --> dipanggil oleh aksesMap.js 
//untuk membaca peta sesuai pilihan kecamatan/kondisi lahan
//membaca data dari database dan membuat json dengan kode sendiri
header('Content-Type: application/json');
require ('connect.php');

$kecamatan = isset($_GET['kecamatan']) ? $_GET['kecamatan'] : '';
$status = isset ($_GET['status']) ? $_GET['status'] : '';

$q = '';

if ($kecamatan != '' && $status == '') {
	$q = "WHERE `a`.`kecamatan` = '".$kecamatan."'";
} 

if ($kecamatan != '' && $status != '' ) {
	$q = "WHERE `a`.`status` = '".$status."' AND `a`.`kecamatan` = '".$kecamatan."'";
}

if ($kecamatan == '' && $status != '') {
	$q = "WHERE `a`.`status` = '".$status."'";
}

if ($kecamatan == '' && $status == '') {
	$q = "";
}

$sql = "SELECT a.*, 
		`b`.`nama_kecamatan` as `nama_kecamatan`, 
		`c`.`nama_status` as `status`,
		`c`.`warna` as `warna`
		FROM `lokasi_lahan` AS `a`
		JOIN `kecamatan` AS `b` ON a.kecamatan = b.id
		JOIN `status` AS `c` ON a.status = c.id
		".$q."
		ORDER BY `a`.`id`";

$data = mysqli_query($kon,$sql);

$json = '{"lahan":[';
$polygon = '';
if ($data) {
	while($x = mysqli_fetch_assoc($data)){
		$json .= '{';
		$json .= '"id":"'.$x['id'].'",
			"nama_lokasi":"'.htmlspecialchars($x['nama_lokasi']).'",
			"kecamatan":"'.htmlspecialchars($x['nama_kecamatan']).'",
			"status":"'.$x['status'].'",
			"keterangan":"'.$x['keterangan'].'",
			"alamat":"'.$x['alamat'].'",
			"polygon":"'.$x['polygon'].'",
			"warna":"'.$x['warna'].'"
		},';
	}

	$json = substr($json,0,strlen($json)-1);
	$json .= ']';
	$json .= '}';
	echo $json;

} else {
	echo "";
}
?>
