import 'dart:convert';

List<Hospital> hospitalFromJson(String str) =>
    List<Hospital>.from(json.decode(str).map((x) => Hospital.fromJson(
        x))); //membutuhkan string str yang nantinya string akan di proses json decode

String hospitalToJson(List<Hospital> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Hospital {
  String name;
  String address;
  String region;
  String? phone; //ada kemungkinan data null
  String province;

  Hospital({
    //buat constructor yang akan set semua field di class
    required this.name,
    required this.address,
    required this.region,
    this.phone,
    required this.province,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) => Hospital(
        //method untuk mendapatkan data dalam format JSON dan menampilkan hospital objek
        //konstruktur ini akan return movie objek. sebagai parameter itu akan mengambil map (key dan value)
        name: json["name"],
        //key bakal String 'name' dan valuenya dynamic
        address: json["address"],
        region: json["region"],
        phone: json["phone"],
        province: json["province"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "region": region,
        "phone": phone,
        "province": province,
      };
}
