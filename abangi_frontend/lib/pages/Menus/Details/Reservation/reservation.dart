import 'dart:convert';

import 'package:abangi_v1/Models/Item.dart';
import 'package:abangi_v1/api/api.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart' as intl;

import '../../../home.dart';

/// My app class to display the date range picker
class Reservation extends StatefulWidget {
  final ItemModel itemModel;
  const Reservation({Key? key, required this.itemModel}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

/// State for Reservation
class MyAppState extends State<Reservation> {
  final _formKey = GlobalKey<FormState>();
  var _dateRangePickerController;
  bool _isLoading = false;
  String _selectedDateFormated = " ";
  String _selectedDate = " ";
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  String _startDate = '';
  String _endDate = '';

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${intl.DateFormat.yMMMEd().format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${intl.DateFormat.yMMMEd().format(args.value.endDate ?? args.value.startDate)}';
        _startDate = intl.DateFormat.yMMMEd().format(args.value.startDate);
        _endDate = intl.DateFormat.yMMMEd().format(args.value.endDate);
        // .format(args.value.endDate ?? args.value.startDate);
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: false ? Colors.white : Colors.white,
            leading: IconButton(
              icon:
                  Icon(Icons.arrow_back, color: Color.fromRGBO(0, 176, 236, 1)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: 10,
                      left: 20,
                    ),
                    // ignore: prefer_const_constructors
                    child: Text(
                      'Reservation Date',
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    // ignore: prefer_const_constructors
                    child: Text(
                      'Select the date you want to reserve',
                      // ignore: prefer_const_constructors
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    // only display current months and future months
                    child: SfDateRangePicker(
                      controller: _dateRangePickerController,
                      selectionMode: DateRangePickerSelectionMode.range,
                      onSelectionChanged: _onSelectionChanged,
                      minDate: DateTime.now(),
                      maxDate: DateTime.now().add(const Duration(days: 365)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        //add button to clear the selected date

                        Container(
                            padding: EdgeInsets.only(left: 15),
                            // ignore: prefer_const_constructors
                            child: // error if selected date is more than 1
                                _range == " "
                                    ? Text(
                                        'Please select a date',
                                        // ignore: prefer_const_constructors
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      )
                                    : Row(
                                        children: [
                                          //add x button to clear the selected date
                                          Text(
                                            _range,
                                            // ignore: prefer_const_constructors
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.close,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _range = " ";
                                              });
                                            },
                                          ),
                                        ],
                                      )

                            // ignore: prefer_const_constructors
                            ),
                      ],
                    ),
                  ),
                  //add clear button to remove selected date

                  Container(
                    padding: EdgeInsets.only(left: 12, top: 20, right: 12),
                    // ignore: prefer_const_constructors
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        // ignore: prefer_const_constructors
                        Text(
                          'Important:  Merchant needs to accept your reserve request first before you can book the listing. Merchant can also reject the request. Reservation is not guaranteed until payment',
                          // ignore: prefer_const_constructors
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                        Container(
                            height: 50,
                            width: 400,
                            margin: const EdgeInsets.only(top: 25),
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ElevatedButton(
                              child: const Text('Send Reservation Request'),
                              onPressed: () {
                                _handleSubmitRequest();
                              },
                            )),
                      ],
                    ),
                  ),
                ],
              ))),
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Poppins'),
    );
  }

  void _handleSubmitRequest() async {
    setState(() {
      _isLoading = true;
    });
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var userid = localStorage.getString('userid');

      var data = {
        "Userid": int.parse(userid!),
        "Itemid": widget.itemModel.itemId,
        "StartDate": _startDate,
        "EndDate": _endDate,
        "RentalStatus": "For Approval",
        "RentalRemarks": "Waiting for merchant to accept reservation"
      };
      var res = await CallApi().postData(data, 'api/rentals');
      var body = json.decode(res.body);
      if (res.statusCode == 201) {
        // ignore: use_build_context_synchronously, avoid_single_cascade_in_expression_statements
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          headerAnimationLoop: false,
          animType: AnimType.bottomSlide,
          title: 'Success',
          desc: 'Please wait for the merchant to accept your request',
          buttonsTextStyle: const TextStyle(color: Colors.white),
          showCloseIcon: false,
          btnOkOnPress: () {
            Navigator.of(context).pop();
            MaterialPageRoute(builder: ((context) {
              return Home();
            }));
          },
        ).show();
      } else {
        // ignore: use_build_context_synchronously, avoid_single_cascade_in_expression_statements
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          headerAnimationLoop: false,
          animType: AnimType.BOTTOMSLIDE,
          title: 'Error',
          desc: 'Cannot send request',
          buttonsTextStyle: const TextStyle(color: Colors.white),
          showCloseIcon: false,
          btnOkOnPress: () {},
        ).show();
      }
    } catch (e) {
      print(e);
    }
  }
}
