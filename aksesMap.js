//file : aksesMap.js dipanggil oleh index.php baris ke 14
//javascript ini digunakan untuk mengambil json dan menampilkan polygon
var nama = [];
var kecamatan = [];
var alamat = [];
var keterangan = [];
var status_lokasi = [];
var lokasi = [];
var cords = '';
var area = [];
var infoWindow;

//===fungsi ijni digunakan untuk mengakses peta dan daerah saat awal aplikasi ==
function peta_awal(){
    var wonosobo = new google.maps.LatLng(-7.3928997,109.8945517);
    var petaoption = {
        zoom: 15,
        center: wonosobo,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };

    peta = new google.maps.Map(document.getElementById("map-canvas"),petaoption);
    urlqu='ambildata.php';// --> untuk  json dengan kode sendiri
    //urlqu = 'ambildata_jsonEncode.php';
    $.ajax({
        url: urlqu,
        dataType: 'json',
        cache: false,
        success: function(msg){
            var polygon;
            var cords = [];
            for(i=0;i<msg.lahan.length;i++){
                nama[i] = msg.lahan[i].nama_lokasi;
                kecamatan[i] = msg.lahan[i].kecamatan;
                alamat[i] = msg.lahan[i].alamat;
                status_lokasi[i] = msg.lahan[i].status;
                keterangan[i] = msg.lahan[i].keterangan;
                lokasi[i] = msg.lahan[i].polygon;
               
                var str = lokasi[i].split(" "); 
                
                for (var j=0; j < str.length; j++) { 
                    var point = str[j].split(",");
                    cords.push(new google.maps.LatLng(parseFloat(point[0]), parseFloat(point[1])));
                }

               var contentString = '<b>'+nama[i]+'</b><br>' +
                                    'Alamat: '+ alamat[i] +
                                    '<br>' +
                                    'Kecamatan: '+ kecamatan[i] +
                                    '<br>' +
                                    'Keterangan: '+ keterangan[i] +
                                    '<br>' +
                                    'Status Lokasi : '+ status_lokasi[i] +
                                    '<br>';

                polygon = new google.maps.Polygon({
                    paths: [cords],
                    strokeColor: msg.lahan[i].warna,
                    strokeOpacity: 0,
                    strokeWeight: 1,
                    fillColor: msg.lahan[i].warna,
                    fillOpacity: 0.5,
                    html: contentString
                });     

                cords = []; 
                polygon.setMap(peta); 
                infoWindow = new google.maps.InfoWindow();
                google.maps.event.addListener(polygon, 'click', function(event) {
                    infoWindow.setContent(this.html);
                    infoWindow.setPosition(event.latLng);
                    infoWindow.open(peta);
                });
            }               
        }
    });
}

//===fungsi ijni digunakan untuk mengakses peta dan daerah SESUAI pilihan  ==
//menggunakan teknolohi jquery AJAX
$(document).ready(function(){
    $("#search").click(function(){
        var kecamatan  = $("#kecamatan").val();
        var status     = $("#status").val();
        var urlqu='caripeta.php';// --> untuk  json dengan kode sendiri
		//urlqu='caripeta_jsonEncode.php';
		$.ajax({
            url:urlqu ,
            data: "kecamatan="+kecamatan+"&status="+status,
            dataType: 'json',
            cache: false,
            success: function(msg) {
                var wonosobo2 = new google.maps.LatLng(-7.3928997,109.8945517);
                var petaoption2 = {
                    zoom: 15,
                    center: wonosobo2,
                    mapTypeId: google.maps.MapTypeId.ROADMAP
                };

                var peta2 = new google.maps.Map(document.getElementById("map-canvas"),petaoption2);

                var polygon;
                var cords = [];
                for(i=0;i<msg.lahan.length;i++){
                    nama[i] = msg.lahan[i].nama_lokasi;
                    kecamatan[i] = msg.lahan[i].kecamatan;
                    alamat[i] = msg.lahan[i].alamat;
                    status_lokasi[i] = msg.lahan[i].status;
                    keterangan[i] = msg.lahan[i].keterangan;
                    lokasi[i] = msg.lahan[i].polygon;
                    
                    var str = lokasi[i].split(" "); 
                    
                    for (var j=0; j < str.length; j++) { 
                        var point = str[j].split(",");
                        cords.push(new google.maps.LatLng(parseFloat(point[0]), parseFloat(point[1])));
                    }

                    var contentString = '<b>'+nama[i]+'</b><br>' +
                                        'Alamat: '+ alamat[i] +
                                        '<br>' +
                                        'Kecamatan: '+ kecamatan[i] +
                                        '<br>' +
                                        'Keterangan: '+ keterangan[i] +
                                        '<br>' +
                                        'Status Lokasi : '+ status_lokasi[i] +
                                        '<br>';
                                        
                    polygon = new google.maps.Polygon({
                        paths: [cords],
                        strokeColor: msg.lahan[i].warna,
                        strokeOpacity: 0,
                        strokeWeight: 1,
                        fillColor: msg.lahan[i].warna,
                        fillOpacity: 0.5,
                        html: contentString
                    });     

                    cords = [];

                    polygon.setMap(peta2); 
                    google.maps.event.addListener(polygon, 'click', function(event) {
                        infoWindow.setContent(this.html);
                        infoWindow.setPosition(event.latLng);
                        infoWindow.open(peta2);
                    });
                }
            }
        });
    });
});