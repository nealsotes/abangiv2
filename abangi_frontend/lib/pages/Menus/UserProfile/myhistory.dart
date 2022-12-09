// ignore_for_file: camel_case_types, prefer_const_constructors
import 'dart:convert';

import 'dart:io';

import 'package:abangi_v1/Models/Item.dart';
import 'package:abangi_v1/Models/TransactionLog.dart';
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

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// ignore: use_key_in_widget_constructors
class MyHistory extends StatelessWidget {
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

class _MyStatefulWidgetState extends State<MyListingScreen> {
  late Future<List<TransactionModel>> transactionModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13),
    );
  }
}
