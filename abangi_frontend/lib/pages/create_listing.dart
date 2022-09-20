// ignore_for_file: camel_case_types, prefer_const_constructors
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: use_key_in_widget_constructors
class CreateListing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: CreateListingScreen(),
      ),
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Poppins'),
    );
  }
}

class CreateListingScreen extends StatefulWidget {
  const CreateListingScreen({Key? key}) : super(key: key);

  @override
  State<CreateListingScreen> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<CreateListingScreen> {
  TextEditingController nameOfListing = TextEditingController();
  TextEditingController describeListing = TextEditingController();

  var dropdownvalueCategory = "Electronics";
  var dropdownvaluePerPrice = "1";
  var perprice = ['1', '2', '3', '4', '5', '6', '7'];
  var dropdownvalueDaysWeeks = "Days";
  var DaysWeeks = [
    'Days',
    'Weeks',
    'Months',
  ];
  var textInputFontSize = 14.00;
  var category = [
    'Electronics',
    'Bikes',
    'Books',
    'Handy Tools',
    'Clothes',
    'Others'
  ];

  var _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(top: 10),
                    child: const Text(
                      'Create Listing',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 176, 236, 1),
                          fontWeight: FontWeight.w600,
                          fontSize: 35),
                    )),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: const Text(
                    'Complete the information below to create listing.',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 60,
                  child: ElevatedButton(
                    // ignore: sort_child_properties_last
                    child: const Text(
                      '+ Add Photo',
                      style: TextStyle(color: Color.fromRGBO(0, 176, 236, 1)),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        // ignore: prefer_const_constructors
                        primary: Color.fromRGBO(255, 255, 255, 1),
                        // ignore: prefer_const_constructors
                        side: BorderSide(
                            // ignore: prefer_const_constructors
                            color: Color.fromRGBO(0, 176, 236, 1),
                            width: 1)),
                    onPressed: () {},
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Listing Title',
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    child: TextFormField(
                      style: TextStyle(fontSize: textInputFontSize),
                      controller: nameOfListing,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        labelText: 'Name this listing',
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(7),
                  child: const Text(
                    'Category',
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(7),
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        // ignore: prefer_const_constructors
                        // Initial Value
                        value: dropdownvalueCategory,
                        // Down Arrow Icon
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          size: 25,
                        ),
                        // Array list of items
                        items: category.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items,
                                style: TextStyle(fontSize: textInputFontSize)),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalueCategory = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Description',
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(7),
                  child: TextFormField(
                    controller: describeListing,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Describe your listing',
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              'Price',
                              style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: '₱0.00',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        // ignore: prefer_const_constructors
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: const Text(
                                'Per',
                                style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              width: 50,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  // ignore: prefer_const_constructors
                                  // Initial Value
                                  value: dropdownvaluePerPrice,
                                  // Down Arrow Icon
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 10,
                                  ),
                                  // Array list of items
                                  items: perprice.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvaluePerPrice = newValue!;
                                    });
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 52),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  // ignore: prefer_const_constructors
                                  // Initial Value
                                  value: dropdownvalueDaysWeeks,
                                  // Down Arrow Icon
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 10,
                                  ),
                                  // Array list of items
                                  items: DaysWeeks.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvalueDaysWeeks = newValue!;
                                    });
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Location',
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: 100,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'House unit no.',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: SizedBox(
                          width: 100,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Barangay',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 10)),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: 100,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'City/Municipality',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: SizedBox(
                          width: 100,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Province',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Rental Method',
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: mounted ? _isChecked : true,
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked = value!;
                            });
                          },
                        ),
                        const Text('Rent to own'),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: mounted ? _isChecked : true,
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked = value!;
                            });
                          },
                        ),
                        const Text('Rent to own'),
                      ],
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                              child: Checkbox(
                                value: mounted ? _isChecked : true,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isChecked = value!;
                                  });
                                },
                              ),
                            ),
                            const Text('Rent to own'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                // ignore: avoid_unnecessary_containers
              ],
            )));
  }
}
