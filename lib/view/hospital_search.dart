import 'package:flutter/material.dart';
import 'package:host_vendy/hospital_detail.dart';
import 'package:host_vendy/model/hospital.dart';
import 'package:host_vendy/service/hospitalservice.dart';

// ignore: must_be_immutable
class SearchHospital extends StatefulWidget {
  late String keyword; //ketika mengakses search hospital kayak membutuhkan data

  SearchHospital({super.key, required this.keyword});

  @override
  State<SearchHospital> createState() => _SearchHospitalState();
}

class _SearchHospitalState extends State<SearchHospital> {
  late Future data;
  List<Hospital> hospitals = [];
  bool isSearching = false;
  TextEditingController searchText = TextEditingController();
  bool cekData = true;

  @override
  void initState() {
    data = HospitalService().getHospital();
    data.then((value) {
      setState(() {
        hospitals = value; //diambil dari api
        hospitals = hospitals
            .where((element) =>
                element.province
                    .toLowerCase()
                    .contains(widget.keyword.toLowerCase()) ||
                element.name.toString().toLowerCase().contains(widget.keyword))
            .toList(); //diambil dari where (menampilkan data sesuai kondisi contoh nama dan province) .contains menyamakan apa yang ada di data dengan apa yang di input
        if (hospitals.isEmpty) {
          cekData = false;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: !isSearching
              ? const Text("List Covid Hospital",
                  style: TextStyle(color: Colors.black, fontSize: 25))
              : TextField(
                  controller: searchText,
                  style: const TextStyle(color: Colors.black, fontSize: 25),
                  decoration: const InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.grey)),
                  onSubmitted: (value) {},
                ),
          backgroundColor: const Color.fromARGB(255, 140, 185, 35),
          elevation: 0,
          iconTheme: const IconThemeData(
              color: Colors.black), // tombol back jadi hitam
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isSearching = !isSearching;
                  });
                },
                icon: !isSearching
                    ? const Icon(Icons.search, color: Colors.black)
                    : const Icon(Icons.cancel,
                        color: Color.fromARGB(255, 255, 255, 255)))
          ],
        ),
        body: hospitals.isEmpty
            ? cekData
                ? const Center(
                    child: CircularProgressIndicator(
                      //kalau g ada data bakal adat bulatin loading
                      color: Colors.black,
                    ),
                  )
                : Center(
                    child: Image.network(
                      'https://media.istockphoto.com/id/1299140151/vector/404-error-page-not-found-template-with-dead-file.jpg?s=612x612&w=0&k=20&c=aiqJjuQ3_8FTOwFMcYsZW-c1ixCZeZt76-Q6nxMucw0=', //dan ada gambar kalau g ada datanya
                      height: 200,
                    ),
                  )
            : ListView.builder(
                itemCount: hospitals.length,
                itemBuilder: (context, position) {
                  return Card(
                    color: Colors.white,
                    elevation: 2,
                    child: ListTile(
                      onTap: () {
                        MaterialPageRoute route = MaterialPageRoute(
                          builder: (_) => HospitalDetail(
                            hospital: hospitals[position],
                          ),
                        );
                        Navigator.push(context, route);
                      },
                      leading: const CircleAvatar(
                          backgroundImage: AssetImage('assets/hos2.png')),
                      title: Text(hospitals[position].name),
                      subtitle: Text(hospitals[position].province),
                    ),
                  );
                }));
  }
}
