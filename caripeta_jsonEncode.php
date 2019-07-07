<?php
//file:caripeta_jsonEncode.php --> dipanggil oleh aksesMap.js 
//untuk membaca peta sesuai pilihan kecamatan/kondisi lahan
//membaca data dari database dan membuat json dengan fungsi json_encode()
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
$polygon = '';
if ($data) {
	 $lokasi=array();
	while($x = mysqli_fetch_assoc($data)){
	$lokasi[]=$x;	
	}
		echo '{"lahan":'.json_encode($lokasi).'}';

}
?>
