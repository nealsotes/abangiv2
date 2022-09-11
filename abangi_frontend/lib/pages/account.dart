// ignore_for_file: camel_case_types

import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
import 'package:abangi_v1/api/api.dart';
import 'package:flutter/material.dart';
// ignore: unused_import

import 'login.dart';

// ignore: use_key_in_widget_constructors
class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: AccountScreen(),
      ),
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Poppins'),
    );
  }
}

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<AccountScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 10),
                child: const Text(
                  'Account',
                  style: TextStyle(
                      color: Color.fromRGBO(0, 176, 236, 1),
                      fontWeight: FontWeight.w600,
                      fontSize: 35),
                )),

            // ignore: avoid_unnecessary_containers

            Container(
                // ignore: prefer_const_constructors
                padding: const EdgeInsets.all(10),
                child: Text('My Inquiries')),
            Container(
                height: 50,
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(0, 176, 236, 1),
                  ),
                  // ignore: sort_child_properties_last
                  child: const Text('Logout'),
                  onPressed: logout,
                )),
          ],
        ));
  }

  void logout() async {
    var res = await CallApi().getData('logout');
    //var body = json.decode(res.body);
    if (res.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('token');

      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    }
  }
}
