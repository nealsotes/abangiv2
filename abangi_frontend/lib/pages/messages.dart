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

/// State for MyListWidget
class TabViewState extends State<MyListWidget> {
  var currentUser;

  void getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    currentUser = prefs.getString('user');
  }

  @override
  Widget build(BuildContext context) {
    getCurrentUser();
    return Container(
        child: DefaultTabController(
      length: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 20, left: 30),
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
                  text: 'My Inquiries',
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
                Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                          // backgroundImage: AssetImage('assets/images/abangi.png'),
                          ),
                      title: Text('Abangi'),
                      subtitle: Text('Hello, I am interested in your item'),
                      trailing: Text('12:00'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Chat()),
                        );
                      },
                    ),
                    ListTile(
                      leading: CircleAvatar(
                          // backgroundImage: AssetImage('assets/images/abangi.png'),
                          ),
                      title: Text('Neal Sotes'),
                      subtitle: Text('Hello, I am interested in your item'),
                      trailing: Text('2:00'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Chat()),
                        );
                      },
                    ),
                  ],
                ),

                // trailing: Image.file(File(widget.itemModel.image),
                //     width: 59, height: 100, fit: BoxFit.cover),

                Payments(),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
