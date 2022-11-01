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
                  return snapshot.data![index].rentalStatus == 'Approved' ||
                          snapshot.data![index].rentalStatus == 'Disapproved' ||
                          snapshot.data![index].rentalStatus == 'Cancelled'
                      ? Visibility(visible: false, child: Text(''))
                      : RefreshIndicator(
                          onRefresh: refreshList,
                          child: ListTile(
                            onTap: () {},
                            leading: Image.file(
                              File(snapshot.data![index].image),
                              width: 80,
                              height: 70,
                            ),
                            title: Row(
                              children: [
                                Text(snapshot.data![index].itemName),
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 5, top: 5),
                                  child: Text(
                                    snapshot.data![index].rentalStatus,
                                    style: TextStyle(
                                        color: Color.fromRGBO(0, 176, 236, 1),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Requested by: ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              print("CLick");
                                            },
                                            child: Text(
                                              snapshot.data![index].renterName,
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      0, 176, 236, 1),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                          '₱${snapshot.data![index].price} . ${snapshot.data![index].category}. Listed on ${snapshot.data![index].startDate.substring(5, 10)}'),
                                      Container(
                                        padding: EdgeInsets.all(5.0),
                                        child: Row(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () async {
                                                try {
                                                  var data = [
                                                    {
                                                      "op": "replace",
                                                      "path": "rentalStatus",
                                                      "value": "Approved"
                                                    },
                                                    {
                                                      "op": "replace",
                                                      "path": "rentalRemarks",
                                                      "value":
                                                          "You can now rent this item and pay the owner"
                                                    }
                                                  ];
                                                  await CallApi().patchData(
                                                      data,
                                                      'api/rentals/${snapshot.data![index].rentalId}');
                                                } catch (e) {
                                                  print(e);
                                                }
                                                refreshList();
                                              },
                                              child: Text(
                                                snapshot.data![index]
                                                    .rentalStatus = 'Approved',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                primary: Color.fromRGBO(
                                                    0, 176, 236, 1),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 10),
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  try {
                                                    var data = [
                                                      {
                                                        "op": "replace",
                                                        "path": "rentalStatus",
                                                        "value": "Disapproved"
                                                      },
                                                      {
                                                        "op": "replace",
                                                        "path": "rentalRemarks",
                                                        "value":
                                                            "Your request to rent this item has been disapproved"
                                                      }
                                                    ];
                                                    await CallApi().patchData(
                                                        data,
                                                        'api/rentals/${snapshot.data![index].rentalId}');
                                                  } catch (e) {
                                                    print(e);
                                                  }
                                                  refreshList();
                                                },
                                                // ignore: sort_child_properties_last
                                                child: Text(
                                                  snapshot.data![index]
                                                          .rentalStatus =
                                                      "Disapproved",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  primary: Color.fromRGBO(
                                                      0, 176, 236, 1),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ));
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

  Future<void> refreshList() async {
    await Future.delayed(Duration(seconds: 0));
    setState(() {
      itemModel = getItemData();
    });
  }
}
