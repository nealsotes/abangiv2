// ignore_for_file: camel_case_types, prefer_const_constructors
import 'dart:convert';

import 'dart:io';

import 'package:abangi_v1/Models/Item.dart';
import 'package:abangi_v1/api/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: use_key_in_widget_constructors
class MyListing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MyListingScreen(),
      ),
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Poppins'),
    );
  }
}

class MyListingScreen extends StatefulWidget {
  MyListingScreen({Key? key}) : super(key: key);

  @override
  State<MyListingScreen> createState() => _MyStatefulWidgetState();
}

Future<List<ItemModel>> getItemData() async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  var currentId = localStorage.getString('userid');
  try {
    // var category = await CallApi().getData('api/itemcategories');
    // var jsonData2 = jsonDecode(category.body);
    // print(jsonData2[3]['items']);
    var response =
        await CallApi().getData('api/items/GetItemByUser/$currentId');
    var jsonData = jsonDecode(response.body);

    List<ItemModel> items = [];
    for (var i in jsonData) {
      ItemModel item = ItemModel(
        i['userId'],
        i['itemName'],
        i['description'],
        i['price'],
        i['category'],
        i['owner'],
        i['rentalMethod'],
        i['location'],
        i['image'],
        i['startDate'],
        i['endDate'],
        i['abangiVerified'],
        i['dateCreated'],
        i['Status'],
      );
      items.add(item);
    }
    return items;
  } catch (e) {
    print(e);
    rethrow;
  }
}

class _MyStatefulWidgetState extends State<MyListingScreen> {
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
      child: SizedBox(
        child: FutureBuilder<List<ItemModel>>(
          future: itemModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {},
                    leading: Image.file(
                      File(snapshot.data![index].image),
                      width: 80,
                      height: 70,
                    ),
                    title: Text(snapshot.data![index].itemName),
                    subtitle: Row(
                      children: [
                        SizedBox(
                          child: Text(
                              '₱${snapshot.data![index].price} . ${snapshot.data![index].category}. Listed on ${snapshot.data![index].startDate.substring(5, 10)}'),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text("You don't have any listings yet"));
            }
          },
        ),
      ),
    );
  }
}
