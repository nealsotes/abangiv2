import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:abangi_v1/pages/account_settings.dart';
import 'package:abangi_v1/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/User.dart';
import '../../api/api.dart';
import 'Menus/UserProfile/mylist.dart';
import 'Menus/UserProfile/payments.dart';

Future<User> getUser() async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  var currentId = localStorage.getString('userid');

  final response = await CallApi().getData('users/$currentId');
  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user');
  }
}

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _MyAppState();
}

class _MyAppState extends State<AccountScreen> {
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = getUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            toolbarHeight: 150,
            leadingWidth: 240,
            backgroundColor: Color.fromRGBO(0, 176, 236, 1),
            title: FutureBuilder<User>(
              future: futureUser,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: CircleAvatar(
                            onBackgroundImageError: (exception, stackTrace) {
                              print('Error loading image');
                            },
                            backgroundImage: Image.file(
                              File(snapshot.data!.profileImage != null
                                  ? snapshot.data!.profileImage!
                                  : ''),
                            ).image,
                            radius: 40,
                            backgroundColor: Colors.white,
                            // ignore: unnecessary_null_comparison
                            child: snapshot.data!.profileImage == null
                                ? Text(snapshot.data!.name.substring(0, 1),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(0, 176, 236, 1),
                                        fontSize: 35))
                                : null),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(snapshot.data!.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 23)),
                            Text(snapshot.data!.email,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13.0)),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                      side: BorderSide(color: Colors.white)),
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      snapshot.data!.isAbangiVerified ==
                                              "Abangi Verified"
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
                                            snapshot.data!.isAbangiVerified ==
                                                    "Abangi Verified"
                                                ? 'Verified'
                                                : 'Not Verified',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10)),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 90, left: 100),
                        child: IconButton(
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .push(MaterialPageRoute(
                                      // ignore: unnecessary_new
                                      builder: (context) => AccountSettings()));
                            },
                            icon: Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 30,
                            )),
                      )
                    ],
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
          body: DefaultTabController(
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
          )),
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Poppins'),
    );
  }
}
