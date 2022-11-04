// ignore_for_file: camel_case_types

import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:abangi_v1/api/Account/view_profile.dart';
import 'package:abangi_v1/pages/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:abangi_v1/api/api.dart';
import 'package:flutter/material.dart';
// ignore: unused_import

import 'login.dart';

// ignore: use_key_in_widget_constructors
class AccountSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: false ? Colors.white : Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color.fromRGBO(0, 176, 236, 1)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            SharedPreferences localStorage =
                await SharedPreferences.getInstance();
            localStorage.remove('token');
            localStorage.remove('user');
            localStorage.remove('userid');
            localStorage.remove('email');

            Navigator.of(context, rootNavigator: true).pushReplacement(
                MaterialPageRoute(builder: (context) => Login()));
          },
          label: const Text('Logout'),
          icon: const Icon(Icons.logout),
          backgroundColor: Colors.red,
        ),
        body: AccountSettingsScreen(),
      ),
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Poppins'),
    );
  }
}

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({Key? key}) : super(key: key);

  @override
  State<AccountSettingsScreen> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<AccountSettingsScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ListView(
          children: <Widget>[
            Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 50),
                child: const Text(
                  'Account',
                  style: TextStyle(color: Colors.black, fontSize: 25),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 40),
                  child: Text(
                    'View Profile',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                          .push(MaterialPageRoute(
                              // ignore: unnecessary_new
                              builder: (context) => ViewProfile()));
                    },
                    icon: const Icon(Icons.arrow_forward_ios))
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 40),
                    child: Text(
                      'Change Password',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios))
                ],
              ),
            ),
            // ignore: avoid_unnecessary_containers
            Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 50),
                child: const Text(
                  'Support',
                  style: TextStyle(color: Colors.black, fontSize: 25),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 40),
                  child: Text(
                    'Abount Abangi',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios))
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 40),
                    child: Text(
                      'Terms and Conditions',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_forward_ios))
                ],
              ),
            ),
          ],
        ));
  }
}
