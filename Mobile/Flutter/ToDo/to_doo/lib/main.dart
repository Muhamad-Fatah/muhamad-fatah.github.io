import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class DataDiri {
  int id;
  String nama;
  int umur;

  DataDiri(
    this.id,
    this.nama,
    this.umur,
  );

  // set name(String name) {}
  // Merubah dari instance ke object
  Map<String, dynamic> toObject() {
    return {
      'id': id,
      'nama': nama,
      'umur': umur,
    };
  }
}

class _MyAppState extends State<MyApp> {
  // Ini Membuat List
  final List<DataDiri> DaftarDataDiri = [
    DataDiri(1, 'Ucok', 11),
    DataDiri(2, 'Wawan', 19),
    DataDiri(3, 'Rohim', 25),
    // DataDiri('olies', 30),
    // DataDiri('Atep', 21),
    // DataDiri('Yudi', 15),
  ];

  int idTerpilih = 0;
  Map<String, String> tampilkanValue = {"name": "", "umur": ""};
  String kataKunci = '';

  // final List<String> daftarNama = [
  //   'Rohim',
  //   'Fatah',
  //   'Kokom',
  //   'Erna',
  // ];

  // final coba<Map<String,dynamic>> = DataDiri('Baba',10)

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    TextEditingController namaController =
        TextEditingController(text: tampilkanValue["name"]);
    TextEditingController umurController =
        TextEditingController(text: tampilkanValue["umur"]);

    void untukClear() {
      setState(() {
        tampilkanValue = {"name": "", "umur": ""};
      });
    }

    void tambahNama() {
      String namaBaru = namaController.text;
      // Untuk mengubah text memjadi intejer
      //        int umurBaru = int.parse(umurController.text);
      int umurBaru = int.parse(umurController.text);
      if (namaBaru.isNotEmpty && umurBaru > 0) {
        setState(() {
          if (idTerpilih > 0) {
            DaftarDataDiri.forEach(
              (datadiri) {
                if (datadiri.id == idTerpilih) {
                  datadiri.nama = namaBaru;
                  datadiri.umur = umurBaru;
                }
              },
            );
            idTerpilih = 0;
          } else {
            Random random = Random();
            int idBaru = random.nextInt(999);

            DaftarDataDiri.add(
              DataDiri(idBaru, namaBaru, umurBaru),
            );
            //  {
            //   //           Map<String, dynamic> dataDiriBaru = {'name': namaBaru,'age' : umurBaru};
            //   // Mengubah hasil inputan menjadi object
            //   // Map<String, dynamic> dataDiriBaru = {'name': namaBaru,'age': umurBaru, };
            //   // DaftarDataDiri.add(namaBaru);
            //   // mengubah hsil inputan menjadi instance
            //   // Memamsukan ke dalam array
            // }
          }
        });
        // print(namaController.text);
        // print(umurController.text);
      }

      untukClear();
    }

    void cancelEdit() {
      setState(() {
        idTerpilih = 0;
      });
      untukClear();
    }
    // Seperti biasa harus uji coba tombol terlebih dahulu
    // Jika tipe datanya instance maka maggil datnya seperti ini
    // int id = data.id;
    // Jika tipe datanya map Maklak memmanggilnya seperti ini
    // int id = data['id'];

    void editData(Map<dynamic, dynamic> data) {
      // print(data);
      // Ini harus pake [] untuk mengambil keynya
      print(namaController.text);
      // print(id);

      // namaController.text = data['nama'];
      // namaController.notifyListeners();
      // print(namaController.text);
      String coba = namaController.text;
      setState(
        () {
          tampilkanValue = {
            "name": data["nama"],
            "umur": data["umur"].toString()
          };
          idTerpilih = data['id'];

          // String namaEdit = namaController.text;
          // int umurEdit = int.parse(umurController.text);
          // DaftarDataDiri.forEach(
          //   (datadiri) {
          //     if (datadiri.id == data['id']) {
          //       datadiri.nama = namaController.text;
          //       // datadiri.umur = umurEdit;
          //     }
          //   },
          // );
        },
      );
    }

    // Membuat fungsi untuk menghapus data Array
    void hapusData(int id) {
      setState(() {
        DaftarDataDiri.removeWhere((datadiri) => datadiri.id == id);
      });
    }

    void cariData(String kataKunci) {
      setState(() {
        this.kataKunci = kataKunci;
      });
    }
    // print(DaftarDataDiri[0].toObject());

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      // Untuk Widget Todo
      // const ToDo(),
      home: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Todo',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Masukan Data',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            TextField(
              controller: namaController,
              // onChanged: (value) {print(value);},
              decoration: const InputDecoration(
                labelText: 'Masukan Nama',
                hintText: 'Masukan Nama',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: umurController,
              decoration: const InputDecoration(
                labelText: 'Masukan umur',
                hintText: 'Masukan umur',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              width: 10,
            ),
            Row(
              children: [
                FilledButton(
                  onPressed: tambahNama,
                  child: Text(
                    idTerpilih == 0 ? 'Tambah Data' : 'Edit Data',
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                idTerpilih != 0
                    ? FilledButton(
                        onPressed: cancelEdit, child: const Text('Cancel'))
                    : const SizedBox.shrink(),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: cariData,
              decoration: const InputDecoration(
                labelText: 'Cari Data',
                hintText: 'Masukan Kata Kunci',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: DaftarDataDiri.length,
              itemBuilder: (context, index) {
                // Untuk membuat Variable untuk memmanggil si Nama tersebut
                int id = DaftarDataDiri[index].id;
                String nama = DaftarDataDiri[index].nama;
                int umur = DaftarDataDiri[index].toObject()['umur'];
                Map<String, dynamic> data = DaftarDataDiri[index].toObject();

                //  Filter berdasarkna data diri pencarian
                if (kataKunci.isNotEmpty &&
                    !nama.toLowerCase().contains(kataKunci.toLowerCase())) {
                  return SizedBox.shrink();
                }
                return ListTile(
                  title: Text(
                    '$id. $nama $umur',
                    style: TextStyle(
                      color: idTerpilih == id ? Colors.redAccent : Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  // Untuk menambahkan logo dari tempat sampah untuk menghapus data Array
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          editData(data);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          hapusData(id);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
