// ignore_for_file: camel_case_types, prefer_const_constructors
import 'package:abangi_v1/Models/Item.dart';
import 'package:flutter/material.dart';
import 'dart:io' as io;

import 'package:syncfusion_flutter_datepicker/datepicker.dart';

// ignore: use_key_in_widget_constructors
class BikesDetails extends StatelessWidget {
  final ItemModel itemModel;
  BikesDetails(
      {Key? key,
      required this.itemModel,
      required String itemName,
      required String description,
      required double price,
      required String category,
      required String owner,
      required String image})
      : super(key: key);

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
                        "₱${itemModel.price}/ day",
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
                          Text(
                            itemModel.owner,
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
                            icon: Icon(Icons.verified_outlined,
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
                        "Schedule Availability",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 21,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 80,
                      right: 0,
                      bottom: 0,
                      child: SfDateRangePicker(
                        onSelectionChanged: _onSelectionChanged,
                        selectionMode: DateRangePickerSelectionMode.range,
                        initialSelectedRange: PickerDateRange(
                            DateTime.now().subtract(const Duration(days: 4)),
                            DateTime.now().add(const Duration(days: 3))),
                      ),
                    ),
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
