// ignore_for_file: avoid_print
import 'dart:convert';

import 'package:address_app/page_kabupaten.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    const MyApp(),
  );
}

//? Step 1: Create a model class for Province
class Province {
  final String id;
  final String name;

  Province({required this.id, required this.name});

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      id: json['id'],
      name: json['name'],
    );
  }
}

//? Step 2: Fetch provinces from API
Future<List<Province>> fetchProvinces() async {
  try {
    final response = await http
        .get(Uri.parse(
            'https://www.emsifa.com/api-wilayah-indonesia/api/provinces.json'))
        .timeout(const Duration(seconds: 10)); // Timeout in 10 seconds

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Province.fromJson(json)).toList();
    } else {
      print('Failed to load provinces. Status code: ${response.statusCode}');
      throw Exception('Failed to load province');
    }
  } catch (error) {
    print("Error: $error");
    throw Exception('Failed to load provinces');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API Tutorial',
      debugShowCheckedModeBanner: false, // Menghilangkan debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProvinceListPage(),
    );
  }
}

class ProvinceListPage extends StatefulWidget {
  const ProvinceListPage({super.key});

  @override
  ProvinceListPageState createState() => ProvinceListPageState();
}

class ProvinceListPageState extends State<ProvinceListPage> {
  //? Step 6: Late demo using FutureBuilder
  late Future<List<Province>> _provincesFuture;

  @override
  void initState() {
    super.initState();
    _provincesFuture = fetchProvinces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Indonesian Provinces'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<Province>>(
            future: _provincesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => KabupatenListPage(
                              provinceId: snapshot.data![index].id,
                              provinceName: snapshot.data![index].name,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          title: Text(
                            snapshot.data![index].name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            'ID: ${snapshot.data![index].id}',
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          ),
        ),
      ),
    );
  }
}
