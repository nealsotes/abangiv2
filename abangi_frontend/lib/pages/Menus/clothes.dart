// ignore_for_file: camel_case_types, prefer_const_constructors
import 'dart:convert';

import 'package:abangi_v1/Models/Item.dart';
import 'package:abangi_v1/api/api.dart';
import 'package:flutter/material.dart';

import 'Details/BooksDetails.dart';
import 'Details/ClothesDetails.dart';

// ignore: use_key_in_widget_constructors
class Clothes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: false ? Colors.white : Colors.white,
          title: Text(
            'Clothes',
            style: TextStyle(
                color: false ? Colors.black : Colors.grey,
                fontWeight: FontWeight.w500),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color.fromRGBO(0, 176, 236, 1)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ClothesScreen(),
      ),
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Poppins'),
    );
  }
}

class ClothesScreen extends StatefulWidget {
  ClothesScreen({Key? key}) : super(key: key);

  @override
  State<ClothesScreen> createState() => _MyStatefulWidgetState();
}

List url = [
  'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bGVuc3xlbnwwfHwwfHw%3D&w=1000&q=80',
  'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bGVuc3xlbnwwfHwwfHw%3D&w=1000&q=80',
  'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bGVuc3xlbnwwfHwwfHw%3D&w=1000&q=80',
  'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bGVuc3xlbnwwfHwwfHw%3D&w=1000&q=80',
  'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bGVuc3xlbnwwfHwwfHw%3D&w=1000&q=80',
  'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bGVuc3xlbnwwfHwwfHw%3D&w=1000&q=80',
  'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bGVuc3xlbnwwfHwwfHw%3D&w=1000&q=80',
];

Future<List<ItemModel>> getItemData() async {
  try {
    var response = await CallApi().getData('api/items');
    var jsonData = jsonDecode(response.body);
    print(jsonData);
    List<ItemModel> items = [];
    for (var i in jsonData) {
      ItemModel item = ItemModel(
        i['itemName'],
        i['description'],
        i['price'],
        i['category'],
        i['owner'],
        i['rentalMethod'],
        i['location'],
      );
      items.add(item);
    }
    return items;
  } catch (e) {
    print(e);
    rethrow;
  }
}

class _MyStatefulWidgetState extends State<ClothesScreen> {
  late Future<List<ItemModel>> itemModel;

  @override
  void initState() {
    super.initState();
    itemModel = getItemData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        child: FutureBuilder<List<ItemModel>>(
          future: itemModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClothesDetails(
                            itemName: snapshot.data![index].itemName,
                            description: snapshot.data![index].description,
                            price: snapshot.data![index].price,
                            category: snapshot.data![index].category,
                            owner: snapshot.data![index].owner,
                            itemModel: snapshot.data![index],
                          ),
                        ),
                      );
                    },
                    leading: Image.network(
                        'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bGVuc3xlbnwwfHwwfHw%3D&w=1000&q=80'),
                    title: Text(snapshot.data![index].itemName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('₱${snapshot.data![index].price}/ day',
                            style: TextStyle(
                                color: Color.fromRGBO(0, 176, 236, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                        Text(
                          snapshot.data![index].location,
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(snapshot.data![index].owner),
                      ],
                    ),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
