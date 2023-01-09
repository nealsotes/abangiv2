// ignore_for_file: camel_case_types, prefer_const_constructors
import 'dart:convert';

import 'dart:io';

import 'package:abangi_v1/Models/Item.dart';
import 'package:abangi_v1/api/api.dart';
import 'package:abangi_v1/pages/Menus/Details/Chat/chat.dart';
import 'package:abangi_v1/pages/Menus/Details/Chat/chat_approval.dart';
import 'package:abangi_v1/pages/account.dart';
import 'package:abangi_v1/pages/notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart';

import '../../../Models/Rental.dart';

void main() => runApp(MyListing());

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

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

Future<List<RentalModel>> getRental() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('userid');

    var response =
        await CallApi().getData('api/rentals/GetRentalByOwnerId/$userid');
    var jsonData = jsonDecode(response.body);
    List<RentalModel> rentals = [];
    for (var r in jsonData) {
      RentalModel rental = RentalModel(
        r['rentalId'],
        r['itemOwner'],
        r['itemImage'],
        r['itemName'],
        r['rentalStatus'],
        r['rentalRemarks'],
        r['startDate'],
        r['status'],
        r['itemPrice'],
        r['itemLocation'],
        r['itemId'],
        r['endDate'],
        r['renterName'],
        r['itemCategory'],
      );

      rentals.add(rental);
    }

    return rentals;
  } catch (e) {
    print(e);
    rethrow;
  }
}

class _MyStatefulWidgetState extends State<MyListingScreen> {
  late Future<List<RentalModel>> itemModel;

  @override
  void initState() {
    super.initState();
    itemModel = getRental();
    Notif.initialize(flutterLocalNotificationsPlugin);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13),
      child: SizedBox(
        child: FutureBuilder<List<RentalModel>>(
          future: itemModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return snapshot.data![index].rentalStatus == 'Disapproved' ||
                          snapshot.data![index].rentalStatus == 'Cancelled'
                      ? Visibility(visible: false, child: Text(''))
                      : RefreshIndicator(
                          onRefresh: refreshList,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            color: Colors.grey[200],
                            child: ListTile(
                              onTap: () async {
                                SharedPreferences localStorage =
                                    await SharedPreferences.getInstance();
                                String name = localStorage.getString('user')!;
                                // ignore: use_build_context_synchronously
                                Navigator.of(context, rootNavigator: true)
                                    .push(MaterialPageRoute(
                                        // ignore: unnecessary_new
                                        builder: (context) => Chat(
                                              name: name,
                                            )));
                              },
                              leading: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    image: MemoryImage(base64Decode(
                                        snapshot.data![index].image)),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: Row(
                                children: [
                                  Text(
                                    //trim the item name to 10
                                    snapshot.data![index].itemName.length > 10
                                        ? snapshot.data![index].itemName
                                                .substring(0, 10) +
                                            '...'
                                        : snapshot.data![index].itemName,
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 5, left: 10.0),
                                    child: Text(
                                      snapshot.data![index].rentalStatus,
                                      style: TextStyle(
                                          color: Color.fromRGBO(0, 176, 236, 1),
                                          fontSize: 9,
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
                                                snapshot
                                                    .data![index].renterName,
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        0, 176, 236, 1),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'P${snapshot.data![index].rentalPrice} . ${snapshot.data![index].itemCategory}. Requested on ${snapshot.data![index].requestDate.substring(5, 10) + " to " + snapshot.data![index].endDate.substring(5, 10)}',
                                          style: TextStyle(fontSize: 8.0),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(5.0),
                                          child: snapshot.data![index]
                                                      .rentalStatus ==
                                                  'Paid'
                                              ? Text(
                                                  'Payment Status: ${snapshot.data![index].rentalStatus}',
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              : Row(
                                                  children: [
                                                    ElevatedButton(
                                                        onPressed: () async {
                                                          try {
                                                            var data = [
                                                              {
                                                                "op": "replace",
                                                                "path":
                                                                    "rentalStatus",
                                                                "value":
                                                                    "Pending payment"
                                                              },
                                                              {
                                                                "op": "replace",
                                                                "path":
                                                                    "rentalRemarks",
                                                                "value":
                                                                    "You can now rent this item and pay the owner"
                                                              }
                                                            ];
                                                            await CallApi()
                                                                .patchData(data,
                                                                    'api/rentals/${snapshot.data![index].rentalId}');
                                                            sendNotification(
                                                                "Approved",
                                                                "You can now rent this item and pay the owner");
                                                          } catch (e) {
                                                            print(e);
                                                          }
                                                          setState(() {
                                                            snapshot
                                                                    .data![index]
                                                                    .rentalStatus =
                                                                'Pending payment';
                                                          });
                                                          refreshList();
                                                        },
                                                        child: Text(
                                                          snapshot.data![index]
                                                                  .rentalStatus =
                                                              'Approved',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 11),
                                                        ),
                                                        style: //if the status is approved, change the button color to green
                                                            ElevatedButton.styleFrom(
                                                                primary: Color
                                                                    .fromRGBO(
                                                                        0,
                                                                        176,
                                                                        236,
                                                                        1))),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 3.0),
                                                      child: ElevatedButton(
                                                        onPressed: () async {
                                                          try {
                                                            var data = [
                                                              {
                                                                "op": "replace",
                                                                "path":
                                                                    "rentalStatus",
                                                                "value":
                                                                    "Disapproved"
                                                              },
                                                              {
                                                                "op": "replace",
                                                                "path":
                                                                    "rentalRemarks",
                                                                "value":
                                                                    "Your request to rent this item has been disapproved"
                                                              }
                                                            ];
                                                            await CallApi()
                                                                .patchData(data,
                                                                    'api/rentals/${snapshot.data![index].rentalId}');
                                                            await CallApi()
                                                                .deleteData(
                                                                    'api/rentals/${snapshot.data![index].rentalId}');
                                                            sendNotification(
                                                                "Dissaproved",
                                                                "Your request to rent this item has been disapproved");
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
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 11),
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary:
                                                              Color.fromRGBO(0,
                                                                  176, 236, 1),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
      itemModel = getRental();
    });
  }

  void sendNotification(String title, String body) async {
    // String? token = await FirebaseMessaging.instance.getToken();
    String tokenRaffysPhone =
        "fLTbtSOoRnO7OYshH2obN2:APA91bGOoSVmWjmVw9qnXYWYWPPIl2RbO_I_PQH5qV5k7lLlzCgCi7hrbcH2sWBBwIH-5NMvhMwQ57hC6n9otMBCB3NE4unoOYZ3IOK0SKFS3FTpWbvzKQPUpZeUzZxCa0zT_6czrHl5";
    String vivoPhone =
        "fBaPVO0kQYqhPcR7ygm8d6:APA91bHodFIZ1UCrGNVRPHNjrPq5MmS_HVvvCxVv5hZZ3nnF4CzjVzTMVKoaXEnVPsMDanBhYZj1LhZPMimFOykoWJCmzr2WfZVIMpvA5eZY_G24YDQX8TvePEnBMasCPwVDqpjYalSd";
    print(vivoPhone);
    var data = {
      "deviceId": vivoPhone,
      "isAndroidDevice": true,
      "title": title,
      "body": body,
    };

    var res = await CallApi().postData(data, "api/notification/send");
    if (res.statusCode == 200) {
      print(res.body);
    } else {
      print(res.body);
    }
  }
}
