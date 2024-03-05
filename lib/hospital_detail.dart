import 'package:flutter/material.dart';
import 'package:host_vendy/model/hospital.dart';

class HospitalDetail extends StatelessWidget {
  final Hospital
      hospital; //ketika kita memanggil hospitalDetail kita mau melewati hospital

  const HospitalDetail(
      {super.key,
      required this.hospital}); // kita buat konstruktur yang mengeset properti hospital dari widget class

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hospital.province), //berisi provinsi dari hospital tersebut
        backgroundColor: const Color.fromARGB(202, 65, 104, 211),
      ),
      body: SingleChildScrollView(
        //membuat child scrollable walaupun tidak sesuai dgn screen
        child: Center(
          child: Column(
            children: [
              Image.network(
                'https://asset.kompas.com/crops/mOKFrYHlSTM6SEt4aD9PIXZnJE0=/0x5:593x400/750x500/data/photo/2020/03/16/5e6ee88f78835.jpg',
                height: 200,
              ), //Image otomatis ter download dari url tersebut dan gambar tersebut dari , kompas
//Height (tinggi) untuk mengatur tinggi dari gambar dan lebar nya akan berubah otomatis ukurannya secara proposional

              Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  hospital.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Location",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF0EEFA),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: Color(0xFF7165D6),
                    size: 30,
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, //flex
                  children: [
                    Text(hospital.address),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      hospital.region,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              const Text(
                "Phone",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF0EEFA),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.phone_rounded,
                    color: Color(0xFF7165D6),
                    size: 30,
                  ),
                ),
                title: Text(hospital.phone.toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
