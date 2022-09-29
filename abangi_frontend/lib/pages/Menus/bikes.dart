// ignore_for_file: camel_case_types, prefer_const_constructors
import 'dart:convert';

import 'package:abangi_v1/Models/Item.dart';
import 'package:abangi_v1/api/api.dart';
import 'package:flutter/material.dart';

import 'Details/BikesDetails.dart';
import 'Details/ElectronicsDetails.dart';

// ignore: use_key_in_widget_constructors
class Bikes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: false ? Colors.white : Colors.white,
          title: Text(
            'Bikes',
            style: TextStyle(
                color: false ? Colors.black : Colors.grey,
                fontWeight: FontWeight.w500),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color.fromRGBO(0, 176, 236, 1)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: BikesScreen(),
      ),
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Poppins'),
    );
  }
}

class BikesScreen extends StatefulWidget {
  BikesScreen({Key? key}) : super(key: key);

  @override
  State<BikesScreen> createState() => _MyStatefulWidgetState();
}

Future<List<ItemModel>> getItemData() async {
  try {
    var response =
        await CallApi().getData('api/itemcategories/getitembycategory/bikes');
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

class _MyStatefulWidgetState extends State<BikesScreen> {
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
                          builder: (context) => BikesDetails(
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
                        'https://images.pexels.com/photos/100582/pexels-photo-100582.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
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
