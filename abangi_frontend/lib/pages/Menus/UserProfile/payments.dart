// ignore_for_file: camel_case_types, prefer_const_constructors

// ignore: avoid_web_libraries_in_flutter
import 'dart:io' as io;
import 'package:abangi_v1/Models/Item.dart';
import 'package:abangi_v1/pages/Menus/Details/Chat/chat.dart';
import 'package:abangi_v1/pages/Menus/Details/Reservation/reservation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

// ignore: use_key_in_widget_constructors
class Payments extends StatelessWidget {
  // ignore: unused_field
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      final dynamic date = args.value;
      _range = 'From: ${date.startDate}, To: ${date.endDate}';
      _rangeCount =
          'Total days: ${date.endDate.difference(date.startDate).inDays}';
    } else {
      final dynamic date = args.value;
      _selectedDate = 'Date: $date';
      _dateCount = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: ListView(
        children: [
          Padding(
              padding: EdgeInsets.only(top: 10, left: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 300,
                    height: 100,
                    padding: EdgeInsets.only(top: 20, left: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 20,
                              offset: Offset(0, 10))
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Text('Available Balance',
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 176, 236, 1),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Container(
                          child: Text('₱ 0',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 70,
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(top: 20, left: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 20,
                              offset: Offset(0, 10))
                        ]),
                    child: RaisedButton(
                      color: Colors.white,
                      onPressed: () {},
                      child: Text('Payout Methods',
                          style: TextStyle(
                              color: Color.fromRGBO(0, 176, 236, 1),
                              fontSize: 17,
                              fontWeight: FontWeight.w600)),
                    ),
                  )
                ],
              )),
        ],
      )),
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Poppins'),
    );
  }
}

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({Key? key}) : super(key: key);

  @override
  ElectronicsDetailsState createState() => ElectronicsDetailsState();
}

/// State for ButtonWidget
class ElectronicsDetailsState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Text(
            "Ratings and Reviews",
            style: TextStyle(
                color: Colors.black, fontSize: 21, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Text(
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Text(
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Text(
            "How to book",
            style: TextStyle(
                color: Colors.black, fontSize: 21, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
        ),
        Container(
            height: 50,
            width: 400,
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: OutlinedButton(
              child: const Text('Chat Now'),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Chat()),
                // );
              },
            )),
        Container(
            height: 50,
            width: 400,
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              child: const Text('Ask for reservation'),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Reservation()),
                // );
              },
            )),
      ],
    );
  }
}
