import 'package:flutter/material.dart';
import 'package:host_vendy/hospital_detail.dart';
import 'package:host_vendy/model/hospital.dart';
import 'package:host_vendy/service/hospitalservice.dart';
import 'package:host_vendy/view/hospital_search.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  runApp(const MyhosT());
}

class MyhosT extends StatelessWidget {
  const MyhosT({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'hospital Demo',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future
      data; //untuk menampung data yang diambil dari prosesnya (future karean tunggu sampe proses asyncronus selesai)
  List<Hospital> hospitals =
      []; //menampung data yang diproses dan dikasi list kosong
  bool isSearching =
      false; //biar saat mau memualai tidak saat melakukan searching
  TextEditingController searchText =
      TextEditingController(); //untuk pengaturan textfield
  bool _showShimmer = true;

  @override
  void initState() {
    //suatu proses yang dijalankan ketika sebelum widget dibuat
    data = HospitalService()
        .getHospital(); //memanggil muridservice dan ketika mendapatkan datanya ke get hopital
    data.then((value) {
      setState(() {
        //kalau sudah dapat data menjalankan perubahan data
        hospitals = value;
      });
    });
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await Future.delayed(const Duration(seconds: 3)); //delay 3 detik
    setState(() {
      _showShimmer = false;
    });
  }

  Future<void> refreshData() async {
    //refreshed action
    setState(() {
      _showShimmer = true; //untuk menampilkan shimmering effect lagi
    });
    await loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching
            ? const Text("List Covid Hospital", //false
                style: TextStyle(color: Colors.black, fontSize: 25))
            : TextField(
                //true
                controller: searchText,
                style: const TextStyle(color: Colors.black, fontSize: 25),
                decoration: const InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.grey)),
                onSubmitted: (value) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SearchHospital(
                          keyword: searchText
                              .text))); //akan menuju ke halaman searching
                },
              ),
        backgroundColor: const Color.fromARGB(255, 211, 65, 65),
        elevation: 0, //bayangan
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isSearching = !isSearching; //ketika diklik true ke false
                });
              },
              icon: !isSearching
                  ? const Icon(Icons.search,
                      color: Colors.black) //kalau gk searching
                  : const Icon(Icons.cancel,
                      color:
                          Color.fromARGB(255, 255, 255, 255))) //kalau seacrhing
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: ListView.builder(
            itemCount: hospitals.length, //sesuai dengan hospitals.length
            itemBuilder: (context, position) {
              //
              return Card(
                color: Colors.white,
                elevation: 2,
                child: _showShimmer
                    ? shimmerWidget() // kalau showshimmer betul memberikan shimerring loading effect
                    : ListTile(
                        onTap: () {
                          MaterialPageRoute route = MaterialPageRoute(
                            builder: (_) => HospitalDetail(
                              hospital: hospitals[position],
                            ),
                          );
                          Navigator.push(context, route);
                        },
                        leading: const CircleAvatar(
                            backgroundImage: AssetImage('assets/hos.png')),
                        title: Text(hospitals[position].name), //
                        subtitle: Text(hospitals[position].province),
                      ),
              );
            }),
      ),
    );
  }

  Widget shimmerWidget() {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/hosp.png'),
      ),
      title: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 230,
            height: 16,
            color: Colors.white,
          ),
        ),
      ),
      subtitle: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 190,
            height: 8,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
