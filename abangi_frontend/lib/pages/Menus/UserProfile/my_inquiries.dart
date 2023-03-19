// ignore_for_file: camel_case_types, prefer_const_constructors
import 'dart:convert';

import 'dart:io';

import 'package:abangi_v1/Models/Item.dart';
import 'package:abangi_v1/api/api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: use_key_in_widget_constructors
class MyInquiries extends StatelessWidget {
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
    var response =
        await CallApi().getData('api/items/GetUserItemListings/$currentId');
    var jsonData = jsonDecode(response.body);

    List<ItemModel> items = [];
    for (var i in jsonData) {
      ItemModel item = ItemModel(
        i['itemId'],
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
        i['rentalStatus'],
        i['rentalId'],
        i['renterName'],
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
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    color: Colors.grey[200],
                    child: ListTile(
                      onTap: () {},
                      leading: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: MemoryImage(
                                base64Decode(snapshot.data![index].image)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(snapshot.data![index].itemName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Text(
                              'P${snapshot.data![index].price} . ${snapshot.data![index].category}. Listed on ${snapshot.data![index].startDate.substring(5, 10)}',
                              style: TextStyle(fontSize: 10.0),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 110.0),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 176, 236, 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                snapshot.data![index].rentalStatus == 'Paid'
                                    ? "Mark as rented"
                                    : "Available",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
