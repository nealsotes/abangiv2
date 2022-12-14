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

import 'Menus/UserProfile/my_inquiries.dart';
import 'Menus/UserProfile/mylist.dart';

// ignore: use_key_in_widget_constructors
class MyListingsScreen extends StatelessWidget {
  var currentUserSession;
  var currentEmailSession;
  var isVerified;
  // ignore: unused_element

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 40, left: 30),
            child: Text(
              "Listings",
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
                  text: 'My Listings',
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
                MyInquiries(),
                Payments(),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
