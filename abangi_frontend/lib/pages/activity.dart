// ignore_for_file: camel_case_types, prefer_const_constructors

// ignore: avoid_web_libraries_in_flutter
import 'dart:io' as io;
import 'package:abangi_v1/Models/Item.dart';
import 'package:abangi_v1/pages/Menus/Details/Chat/chat.dart';
import 'package:abangi_v1/pages/Menus/Details/Reservation/reservation.dart';
import 'package:abangi_v1/pages/Menus/UserProfile/payments.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

import 'Menus/UserProfile/mylist.dart';

// ignore: use_key_in_widget_constructors
class ActivityScreen extends StatelessWidget {
  var currentUserSession;
  var currentEmailSession;
  var isVerified;
  // ignore: unused_element
  void handleCurrentUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    currentUserSession = localStorage.getString('user');
    currentEmailSession = localStorage.getString('email');
    isVerified = localStorage.getString('is_verified');
  }

  @override
  Widget build(BuildContext context) {
    handleCurrentUser();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            toolbarHeight: 150,
            leadingWidth: 200,
            backgroundColor: Color.fromRGBO(0, 176, 236, 1),
            title: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Text(
                      currentUserSession.toString().substring(0, 1),
                      style: TextStyle(
                          color: Color.fromRGBO(0, 176, 236, 1),
                          fontSize: 30,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '$currentUserSession',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 25),
                    ),
                    Container(
                      child: Text(
                        '$currentEmailSession',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 50),
                  margin: EdgeInsets.only(
                    top: 90,
                  ),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: Colors.white),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        isVerified == 'Abangi Verified'
                            ? Icon(
                                Icons.verified,
                                color: Colors.white,
                                size: 14,
                              )
                            : Icon(
                                Icons.error,
                                color: Colors.white,
                                size: 14,
                              ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                              isVerified == 'Abangi Verified'
                                  ? 'Verified'
                                  : 'Not Verified',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: MyListWidget()),
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Poppins'),
    );
  }
}

class MyListWidget extends StatefulWidget {
  const MyListWidget({Key? key}) : super(key: key);

  @override
  TabViewState createState() => TabViewState();
}

/// State for MyListWidget
class TabViewState extends State<MyListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints.expand(height: 50),
            child: TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  text: 'My Listings',
                ),
                Tab(
                  text: 'Payments',
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                MyListing(),
                Payments(),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
