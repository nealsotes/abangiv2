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
import '../../../Models/TransactionLog.dart';
import '../../../api/api.dart';

// ignore: use_key_in_widget_constructors
class TransactionHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: TransactionHistory()),
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Poppins'),
    );
  }
}

class TransactionHistory extends StatefulWidget {
  @override
  TabViewState createState() => TabViewState();
}

Future<List<TransactionModel>> getTransactions() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('userid');

    var response = await CallApi()
        .getData('api/TransactionHistory/GetTransactionHistoryByRenter/109');
    var jsonData = jsonDecode(response.body);
    List<TransactionModel> transactions = [];
    for (var t in jsonData) {
      TransactionModel transaction = TransactionModel(
          t['renter'],
          t['owner'],
          t['itemRented'],
          t['dateRented'],
          t['dateReturned'],
          t['paymentStatus'],
          t['transactionStatus'],
          t['amountPaid'],
          t['paymentMethod'],
          t['TimeStamp'],
          t['itemPrice']);

      transactions.add(transaction);
    }

    return transactions;
  } catch (e) {
    print(e);
    rethrow;
  }
}

/// State for TransactionHistory
class TabViewState extends State<TransactionHistory> {
  late Future<List<TransactionModel>> transactions;
  var currentUser;

  @override
  void initState() {
    super.initState();
    transactions = getTransactions();
  }

//get device id

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TransactionModel>>(
      future: transactions,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  //return a list of transactions history
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.history),
                      title: Text(snapshot.data![index].itemRented),
                      subtitle: Text(snapshot.data![index].dateRented),
                      trailing: Text(snapshot.data![index].amountPaid),
                      onTap: () {},
                    ),
                  );
                }),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
