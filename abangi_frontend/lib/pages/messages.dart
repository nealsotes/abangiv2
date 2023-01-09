// ignore_for_file: camel_case_types, prefer_const_constructors

// ignore: avoid_web_libraries_in_flutter
import 'dart:convert';
import 'dart:io' as io;
import 'package:abangi_v1/Models/Item.dart';
import 'package:abangi_v1/pages/Menus/Details/Chat/chat.dart';
import 'package:abangi_v1/pages/Menus/Details/Chat/chat_approval.dart';
import 'package:abangi_v1/pages/Menus/Details/Reservation/reservation.dart';
import 'package:abangi_v1/pages/Menus/UserProfile/payments.dart';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:platform_device_id/platform_device_id.dart';
import '../Models/Rental.dart';
import '../api/api.dart';
import 'Menus/UserProfile/my_inquiries.dart';
import 'Menus/UserProfile/mylist.dart';

// ignore: use_key_in_widget_constructors
class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: MyListWidget()),
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Poppins'),
    );
  }
}

class MyListWidget extends StatefulWidget {
  @override
  TabViewState createState() => TabViewState();
}

Future<List<RentalModel>> getRental() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('userid');

    var response =
        await CallApi().getData('api/rentals/GetRentalByUserId/$userid');
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

/// State for MyListWidget
class TabViewState extends State<MyListWidget> {
  late Future<List<RentalModel>> rentals;
  var currentUser;

  @override
  void initState() {
    super.initState();
    rentals = getRental();
  }

//get device id

  @override
  Widget build(BuildContext context) {
    print(rentals);
    return Container(
        child: DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 40, left: 30),
            child: Text(
              "Inbox",
              style: TextStyle(
                  color: Color.fromRGBO(0, 176, 236, 1),
                  fontWeight: FontWeight.w600,
                  fontSize: 35),
            ),
          ),
          Container(
            constraints: BoxConstraints.expand(height: 50),
            child: TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  text: 'Transactions',
                ),
                Tab(
                  text: '',
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                FutureBuilder<List<RentalModel>>(
                  future: rentals,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 100,
                                margin: EdgeInsets.only(bottom: 10.0),
                                color: Colors.grey[200],
                                child: ListTile(
                                    onTap: () async {
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      String name = prefs.getString('user')!;
                                      if (snapshot.data![index].rentalStatus !=
                                          "Cancelled") {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .push(MaterialPageRoute(
                                                // ignore: unnecessary_new
                                                builder: (context) =>
                                                    ChatApproval(
                                                      name: name,
                                                      rental:
                                                          snapshot.data![index],
                                                    )));
                                      }
                                      setState(() {
                                        historyTransactions(
                                          snapshot.data![index].owner,
                                          snapshot.data![index].itemName,
                                          snapshot.data![index].requestDate
                                              .toString(),
                                          "2022-12-23",
                                          snapshot.data![index].rentalStatus,
                                          "Online Payment",
                                          snapshot.data![index].rentalRemarks,
                                          snapshot.data![index].rentalPrice
                                              .toInt(),
                                          "Electric Fan",
                                          snapshot.data![index].rentalPrice
                                              .toInt(),
                                        );
                                      });
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    leading: Icon(Icons.message,
                                        color: Color.fromRGBO(0, 176, 236, 1)),
                                    title: Text(
                                      snapshot.data![index].owner,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data![index].rentalRemarks,
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 9),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 3.0),
                                          padding: EdgeInsets.all(3.0),
                                          decoration: BoxDecoration(
                                              color: snapshot.data![index]
                                                          .rentalStatus ==
                                                      "For Approval"
                                                  ? Colors.orange
                                                  : snapshot.data![index]
                                                              .rentalStatus ==
                                                          "Approved"
                                                      ? Color.fromRGBO(
                                                          0, 176, 236, 1)
                                                      : Colors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(2)),
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10.0, right: 10.0),
                                            child: Text(
                                              snapshot
                                                  .data![index].rentalStatus,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 9),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    trailing: Column(
                                      children: [
                                        Text(
                                          DateFormat.yMMMMd().format(
                                              DateTime.parse(snapshot
                                                  .data![index].requestDate)),
                                          style: TextStyle(
                                              color: Colors.black, fontSize: 8),
                                        ),
                                        // ignore: unnecessary_null_comparison
                                        Container(
                                          width: 60,
                                          height: 44,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            image: DecorationImage(
                                              image: MemoryImage(base64Decode(
                                                  snapshot.data![index].image)),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              );
                            }),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
                Payments(),
              ],
            ),
          )
        ],
      ),
    ));
  }

  void historyTransactions(
      String owner,
      String itemrented,
      String dateRequested,
      String datereturned,
      String paymentStatus,
      String paymentMethod,
      String transactionStatus,
      int itemPrice,
      String itemCategory,
      int amountPaid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var renter = prefs.getString('user');
    var data = {
      "renter": renter,
      "owner": owner,
      "itemrented": itemrented,
      "daterented": dateRequested,
      "dateReturned": datereturned,
      "paymentstatus": paymentStatus,
      "paymentmethod": paymentMethod,
      "transactionStatus": transactionStatus,
      "itemPrice": itemPrice,
      "itemCategory": itemCategory,
      "amountPage": amountPaid
    };

    var res = await CallApi().postData(data, "api/transactionhistory");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      print(body);
    } else {
      print(body);
    }
  }
}
