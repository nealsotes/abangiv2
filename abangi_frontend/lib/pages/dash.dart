// ignore_for_file: prefer_const_constructors, duplicate_ignore
import 'package:abangi_v1/Models/Item.dart';
import 'package:abangi_v1/pages/account.dart';
import 'package:abangi_v1/pages/activity.dart';
import 'package:abangi_v1/pages/create_listing.dart';
import 'package:abangi_v1/pages/mylistings.dart';
import 'package:abangi_v1/pages/home.dart';
import 'package:abangi_v1/pages/messages.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homedash extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      // ignore: prefer_const_constructors
      home: DashboardScreen(),
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Poppins'),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => DashState();
}

class DashState extends State<DashboardScreen> {
  var currentUser;
  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentUser = prefs.getString('user');
  }

  int _selectedIndex = 0;
  // ignore: prefer_final_fields
  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    MessagesScreen(),
    CreateListingScreen(),
    MyListingsScreen(),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              primaryColor: Colors.blue,
              textTheme: Theme.of(context)
                  .textTheme
                  // ignore: unnecessary_new
                  .copyWith(caption: new TextStyle(color: Colors.yellow))),
          // ignore: unnecessary_new
          child: new BottomNavigationBar(
            // ignore: prefer_const_literals_to_create_immutables
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.blue,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message, color: Colors.blue),
                label: 'Messages',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star, color: Colors.blue),
                label: 'Post for Rent',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history, color: Colors.blue),
                label: 'My Listings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.manage_accounts, color: Colors.blue),
                label: 'Account',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue,
            onTap: _onItemTapped,
          )),
    );
  }
}
