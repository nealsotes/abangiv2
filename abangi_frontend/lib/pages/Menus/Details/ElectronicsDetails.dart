// ignore_for_file: camel_case_types, prefer_const_constructors

// ignore: avoid_web_libraries_in_flutter
import 'dart:io' as io;
import 'package:abangi_v1/Models/Item.dart';
import 'package:abangi_v1/pages/Menus/Details/Chat/chat.dart';
import 'package:abangi_v1/pages/Menus/Details/Reservation/reservation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

// ignore: use_key_in_widget_constructors
class ElectronicsDetails extends StatelessWidget {
  final ItemModel itemModel;
  // ignore: prefer_const_constructors_in_immutables
  ElectronicsDetails({
    Key? key,
    required this.itemModel,
  }) : super(key: key);
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
          appBar: AppBar(
            elevation: 0,
            backgroundColor: false ? Colors.white : Colors.white,
            leading: IconButton(
              icon:
                  Icon(Icons.arrow_back, color: Color.fromRGBO(0, 176, 236, 1)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 240,
                      // ignore: avoid_unnecessary_containers
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: FileImage(io.File(itemModel.image)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    // ignore: avoid_unnecessary_containers
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Text(
                        itemModel.itemName,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 21,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Text(
                        "P${itemModel.price}/ day",
                        style: TextStyle(
                            color: Color.fromRGBO(0, 176, 236, 1),
                            fontSize: 21,
                            fontWeight: FontWeight.w600),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.location_on_outlined,
                                color: Color.fromRGBO(0, 176, 236, 1)),
                            onPressed: () {},
                          ),
                          Text(
                            itemModel.location,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove_red_eye_outlined,
                                color: Color.fromRGBO(0, 176, 236, 1)),
                            onPressed: () {},
                          ),
                          Text(
                            itemModel.rentalMethod,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.person_outline,
                                color: Color.fromRGBO(0, 176, 236, 1)),
                            onPressed: () {},
                          ),
                          InkWell(
                            onTap: () {
                              print("tapped");
                            },
                            child: Text(
                              itemModel.owner,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.verified_outlined,
                                color: Color.fromRGBO(0, 176, 236, 1)),
                            onPressed: () {},
                          ),
                          Text(
                              itemModel.AbangiVerified
                                  ? "Abangi Verified"
                                  : "Not Abangi Verified",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Text(
                            "Description",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Text(
                        itemModel.description,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Text(
                        "Available Dates",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 21,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SfDateRangePicker(
                      selectionMode: DateRangePickerSelectionMode.range,
                      enablePastDates: false,
                      initialSelectedRange: PickerDateRange(
                          DateTime.parse(itemModel.startDate)
                              .add(Duration(days: 0)),
                          DateTime.parse(itemModel.endDate)
                              .add(Duration(days: 0))),
                    ),
                    ButtonWidget(itemModel: itemModel),
                  ],
                ),
              )
            ],
          )),
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Poppins'),
    );
  }
}

class ButtonWidget extends StatefulWidget {
  final ItemModel itemModel;
  const ButtonWidget({Key? key, required this.itemModel}) : super(key: key);

  @override
  ElectronicsDetailsState createState() => ElectronicsDetailsState();
}

/// State for ButtonWidget
class ElectronicsDetailsState extends State<ButtonWidget> {
  var currentUser;
  void getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    currentUser = prefs.getString('user');
  }

  bool _isVisibility = false;

  @override
  Widget build(BuildContext context) {
    getCurrentUser();
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
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "How to book",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "How to reserve this listing",
                    style: TextStyle(color: Colors.black, fontSize: 13),
                  ),
                  Visibility(
                      visible: _isVisibility,
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "1. ",
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'Tap "Chat now "or "Ask for reservation".',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 11),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "2. ",
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'Choose your preferred date and submit request reserve.',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 11),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "3. ",
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'Once accepted by the owner, pay within the \napp to confirm your reservation.',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 11),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "4. ",
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'After you use/rent the product or service,Top \n"Complete Transaction".',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 11),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "5. ",
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'Leave you review and rating for the owner.',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 11),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ))
                ],
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _isVisibility = !_isVisibility;
                  });
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
        ),
        // Container(
        //     height: 50,
        //     width: 400,
        //     margin: const EdgeInsets.only(top: 15),
        //     padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        //     child: OutlinedButton(
        //       child: const Text('Chat Now'),
        //       onPressed: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) => Chat(
        //                     name: currentUser,
        //                     itemModel: widget.itemModel,
        //                   )),
        //         );
        //       },
        //     )),
        Container(
            height: 50,
            width: 400,
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              child: const Text('Ask for reservation'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Reservation(
                            itemModel: widget.itemModel,
                          )),
                );
              },
            )),
      ],
    );
  }
}
