// ignore_for_file: camel_case_types, prefer_const_constructors
import 'package:abangi_v1/pages/Menus/bikes.dart';
import 'package:abangi_v1/pages/Menus/books.dart';
import 'package:abangi_v1/pages/Menus/electronics.dart';
import 'package:abangi_v1/pages/Menus/clothes.dart';
import 'package:abangi_v1/pages/Menus/handytools.dart';
import 'package:abangi_v1/pages/Menus/others.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ignore: use_key_in_widget_constructors
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: HomeScreen(),
      ),
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Poppins'),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  ParseUser? currentUser;
  Future<ParseUser?> getData() async {
    currentUser = await ParseUser.currentUser() as ParseUser?;
    return currentUser;
  }

  var currentUserSession;
  // ignore: unused_element
  void handleCurrentUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    currentUserSession = localStorage.getString('user');
  }

  @override
  Widget build(BuildContext context) {
    handleCurrentUser();
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.topRight,
                // ignore: unnecessary_new
                child: new IconButton(
                    onPressed: () {}, icon: Icon(Icons.notifications))),
            Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 2),
                child: FutureBuilder<ParseUser?>(
                  future: getData(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: CircularProgressIndicator(),
                          ),
                        );

                      default:
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Center(
                                child: Text(
                                  'let\'s Rent,' + ' ' + currentUserSession,
                                  style: TextStyle(
                                      color: Color.fromRGBO(0, 176, 236, 1),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                              )
                            ],
                          ),
                        );
                    }
                  },
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  labelText: 'Search',
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 25),
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Electronics()),
                            );
                          },
                          icon: Icon(
                            Icons.cable_outlined,
                            color: Color.fromRGBO(0, 176, 236, 1),
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      child: const Text(
                        'Electronics',
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 25),
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Bikes()),
                            );
                          },
                          icon: Icon(Icons.pedal_bike,
                              color: Color.fromRGBO(0, 176, 236, 1), size: 40),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      child: const Text(
                        'Bikes',
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 25),
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Books()),
                            );
                          },
                          icon: Icon(Icons.library_books,
                              color: Color.fromRGBO(0, 176, 236, 1), size: 40),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      child: const Text(
                        'Books',
                      ),
                    )
                  ],
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 45),
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HandyTools()),
                            );
                          },
                          icon: Icon(
                            Icons.handyman_outlined,
                            color: Color.fromRGBO(0, 176, 236, 1),
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      child: const Text(
                        'Handy Tools',
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 45),
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Clothes()),
                            );
                          },
                          icon: Icon(Icons.checkroom_outlined,
                              color: Color.fromRGBO(0, 176, 236, 1), size: 40),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      child: const Text(
                        'Clothes',
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 45),
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Others()),
                            );
                          },
                          icon: Icon(Icons.device_unknown,
                              color: Color.fromRGBO(0, 176, 236, 1), size: 40),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      child: const Text(
                        'Others',
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ));
  }
}
