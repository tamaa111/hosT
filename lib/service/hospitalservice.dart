import 'package:host_vendy/model/hospital.dart';
import 'package:http/http.dart'
    as http; //kalau mau menggunakan api kita berikan akses yang namanya http (tambahkan dependency), //Package ini berisi serangkaian fungsi dan kelas tingkat tinggi yang memudahkan penggunaan resource HTTP. Ini multi-platform, dan mendukung mobile, desktop, dan browser.

class HospitalService {
  //kita buat kelas (karena misalnya ada lebih dari satu api kita akan membuat kelas berbeda, karena saya hanya ada satu api jadi buat 1 kelas saja)
  static const String _baseUrl =
      'https://dekontaminasi.com/api/id/covid19/hospitals'; //buat variabel untuk menampung url

  Future getHospital() async {
    //function bertipe data future yang nantinya mendapatkan data (program melakukan proses dahulu maka akan dapat datanya)
    //gethospital function  return future dan async
    Uri urlApi =
        Uri.parse(_baseUrl); //convert dulu ke tipe data uri (string to uri)

    final response = await http.get(
        urlApi); //ini ambil datanya jadi kita buat variabel namanya response isinya await tunggu dahulu sebuah proses http get (data urlApi) karena kalau ambil yg diatasnya bukan string jadi gk bisa
    if (response.statusCode == 200) {
      //jika response. status codenya 200 / oke . maka berhasil return hospital from json
      return hospitalFromJson(response.body
          .toString()); //ketika statusnya berhasil diakses maka akan menjalankan fungsi hospital from json di hospital dart dan to string karena perlu data string
    } else {
      throw Exception("Failed to load data hospital"); //kalau gagal ambil data
    }
  }
}
