// ignore_for_file: camel_case_types, prefer_const_constructors
import 'dart:convert';
import 'dart:io';

import 'package:abangi_v1/Models/Item.dart';
import 'package:abangi_v1/api/api.dart';
import 'package:abangi_v1/pages/Menus/Details/HandyToolsDetails.dart';
import 'package:abangi_v1/pages/Menus/Details/OthersDetails.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Details/BooksDetails.dart';
import 'Details/HandyToolsDetails.dart';

// ignore: use_key_in_widget_constructors
class HandyTools extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: false ? Colors.white : Colors.white,
          title: Text(
            'HandyTools',
            style: TextStyle(
                color: false ? Colors.black : Colors.grey,
                fontWeight: FontWeight.w500),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color.fromRGBO(0, 176, 236, 1)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: HandyToolsScreen(),
      ),
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Poppins'),
    );
  }
}

class HandyToolsScreen extends StatefulWidget {
  HandyToolsScreen({Key? key}) : super(key: key);

  @override
  State<HandyToolsScreen> createState() => _MyStatefulWidgetState();
}

var currentUser;
Future<List<ItemModel>> getItemData() async {
  try {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    currentUser = localStorage.getString('userid');
    var response = await CallApi().getData(
        'api/itemcategories/getitembycategory/handy tools/$currentUser');
    var jsonData = jsonDecode(response.body);

    List<ItemModel> items = [];
    for (var i in jsonData) {
      //convert base64 to image

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
      //convert base64 to image

    }
    return items;
  } catch (e) {
    print(e);
    rethrow;
  }
}

class _MyStatefulWidgetState extends State<HandyToolsScreen> {
  late Future<List<ItemModel>> itemModel;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    itemModel = getItemData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Column(
        children: [
          Container(
            width: 390,
            height: 50,
            margin: EdgeInsets.only(bottom: 20.0),
            child: TextField(
              onChanged: (value) {
                filterSearchResults(value);
              },
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
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
                              builder: (context) => HandyToolsDetails(
                                itemModel: snapshot.data![index],
                                //pass the image to the next page
                              ),
                            ),
                          );
                        },
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
                            Text('P${snapshot.data![index].price}/ day',
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 176, 236, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                            Text(
                              snapshot.data![index].location,
                              style: TextStyle(color: Colors.black),
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 5),
                                  child: Text(
                                      snapshot.data![index].owner
                                          .substring(0, 1),
                                      style: TextStyle(
                                        color: Color.fromRGBO(0, 176, 236, 1),
                                        fontWeight: FontWeight.w500,
                                      )),
                                ),
                                InkWell(
                                  hoverColor: Colors.lightBlue[200],
                                  onTap: () {},
                                  child: Text(snapshot.data![index].owner),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          )
        ],
      ),
    );
  }

  void filterSearchResults(String query) async {
    List<ItemModel> dummySearchList = [];
    dummySearchList.addAll(await getItemData());
    if (query.isNotEmpty) {
      List<ItemModel> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.itemName.toLowerCase().contains(query)) {
          dummyListData.add(item);
        }
        if (item.owner.toLowerCase().contains(query)) {
          dummyListData.add(item);
        }
        if (item.location.toLowerCase().contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        itemModel = Future.value(dummyListData);
      });
      return;
    } else {
      setState(() {
        itemModel = getItemData();
      });
    }
  }
}
