// ignore_for_file: camel_case_types, prefer_const_constructors, unused_field
import 'dart:convert';
import 'dart:io';
import 'package:abangi_v1/Models/User.dart';
import 'package:angles/angles.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'dart:math';
import 'dart:core';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:open_file/open_file.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart' as intl;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../api/api.dart';
import '../global_utils.dart';

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

Future<List<User>> getUser() async {
  try {
    var response = await CallApi().getData('users');
    var jsonData = jsonDecode(response.body);

    List<User> users = [];
    for (var i in jsonData) {
      User user = User(
        i['fullname'],
        i['email'],
        i['role'],
        i['contact'],
        i['address'],
        i['image'],
        i['isAbangiVerified'],
      );
      users.add(user);
    }
    return users;
  } catch (e) {
    print(e);
    rethrow;
  }
}

var role = '';
void _showUser() async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  var currentUserSession = localStorage.getString('email');
  List<User> users = await getUser();
  for (var user in users) {
    if (user.email == currentUserSession) {
      role = user.role;
      localStorage.setString('is_verified', user.isAbangiVerified);
    }
  }
}

class _MyStatefulWidgetState extends State<CreateListingScreen> {
  TextEditingController listingController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  TextEditingController itemHouseLocationController = TextEditingController();
  TextEditingController itemBarLocationController = TextEditingController();
  TextEditingController itemCityLocationController = TextEditingController();
  late Future<List<User>> user;

  @override
  void initState() {
    super.initState();
    user = getUser();
  }

  var _dateRangePickerController;
  bool _isLoading = false;
  // change text to upload file
  String _uploadFileText = '+ Add Photo';

  // ignore: prefer_typing_uninitialized_variables
  var _radioRentalValue;
  var textInputFontSize = 14.00;
  final _formKey = GlobalKey<FormState>();
  //Image upload

  dynamic _fileName = '';
  var dropdownvalueCategory = "9";

  var dropdownvalueDaysWeeks = "Days";
  // ignore: non_constant_identifier_names
  var DaysWeeks = [
    'Days',
    'Weeks',
    'Months',
  ];
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  String _startDate = '';
  String _endDate = '';

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    // if no file is picked

    if (result == null) return;

    _fileName = result.files.first.path;

    final file = result.files.first;
    _openFile(file);
  }

  void _openFile(PlatformFile file) async {
    OpenFile.open(file.path);
  }

//clear text
  void clearText() {
    listingController.clear();
    itemDescriptionController.clear();
    itemPriceController.clear();
    itemHouseLocationController.clear();
    itemBarLocationController.clear();
    itemCityLocationController.clear();
    _radioRentalValue = null;
    _uploadFileText = "+ Add Photo";
  }

  List<DropdownMenuItem<String>> get dropdownCategories {
    List<DropdownMenuItem<String>> categories = [
      DropdownMenuItem(value: "8", child: Text("Electronics")),
      DropdownMenuItem(value: "9", child: Text("Bikes")),
      DropdownMenuItem(value: "10", child: Text("Books")),
      DropdownMenuItem(value: "11", child: Text("Handy Tools")),
      DropdownMenuItem(value: "12", child: Text("Clothes")),
    ];
    return categories;
  }

  List<DropdownMenuItem<String>> get dropdownPerDaysWeeks {
    List<DropdownMenuItem<String>> perdaysweeks = [
      DropdownMenuItem(value: "1", child: Text("1")),
      DropdownMenuItem(value: "2", child: Text("2")),
      DropdownMenuItem(value: "3", child: Text("3")),
      DropdownMenuItem(value: "4", child: Text("4")),
      DropdownMenuItem(value: "5", child: Text("5")),
      DropdownMenuItem(value: "6", child: Text("6")),
      DropdownMenuItem(value: "8", child: Text("7")),
    ];
    return perdaysweeks;
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range =
            '${intl.DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${intl.DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
        _startDate = intl.DateFormat('yyyy/MM/dd').format(args.value.startDate);
        _endDate = intl.DateFormat('yyyy/MM/dd')
            .format(args.value.endDate ?? args.value.startDate);
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
    _showUser();
    return Form(
      key: _formKey,
      child: FutureBuilder<List<User>>(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
                padding: const EdgeInsets.all(10),
                child: role == 'Owner'
                    ? SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
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
                              width: 900,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: const BorderSide(
                                      color: Color.fromRGBO(0, 176, 236, 1),
                                    )),
                                child: Text(
                                  _uploadFileText,
                                  style: TextStyle(
                                      color: Color.fromRGBO(0, 176, 236, 1),
                                      fontSize: 17),
                                ),
                                onPressed: () {
                                  _pickFile();
                                  setState(() {
                                    _uploadFileText = 'Photo Added';
                                  });
                                },
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
                              height: 90,
                              child: Container(
                                padding: const EdgeInsets.all(7),
                                child: TextFormField(
                                  style: TextStyle(fontSize: textInputFontSize),
                                  controller: listingController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    labelText: 'Name this listing',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Required*';
                                    }
                                    return null;
                                  },
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
                              width: 400,
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

                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownvalueCategory = newValue!;
                                      });
                                    },
                                    items: dropdownCategories,
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
                                controller: itemDescriptionController,
                                maxLines: 5,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Describe your listing',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Required*';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: const Text(
                                'Schedule Availability',
                                style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: SfDateRangePicker(
                                controller: _dateRangePickerController,
                                onSelectionChanged: _onSelectionChanged,
                                selectionMode:
                                    DateRangePickerSelectionMode.range,
                                initialSelectedRange: PickerDateRange(
                                    DateTime.now().add(const Duration(days: 0)),
                                    DateTime.now()
                                        .add(const Duration(days: 0))),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      TextFormField(
                                        controller: itemPriceController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: '₱0.00',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Required*';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
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
                                      controller: itemHouseLocationController,
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
                                        controller: itemBarLocationController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Barangay',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Required*';
                                          }
                                          return null;
                                        },
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
                                      controller: itemCityLocationController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'City/Municipality',
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Required*';
                                        }
                                        return null;
                                      },
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
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 0.2),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Radio(
                                                    value: 1,
                                                    groupValue:
                                                        _radioRentalValue,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _radioRentalValue =
                                                            value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('Meet Up'),
                                                ],
                                              ),
                                              Text(
                                                'You are going to meet up with the renter',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 0.2),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Radio(
                                                    value: 2,
                                                    groupValue:
                                                        _radioRentalValue,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _radioRentalValue =
                                                            value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text(
                                                      'Delivery/Drop Off'),
                                                ],
                                              ),
                                              Text(
                                                'You will deliver the item to the renter',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 0.2),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Radio(
                                                    value: 3,
                                                    groupValue:
                                                        _radioRentalValue,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _radioRentalValue =
                                                            value!;
                                                      });
                                                    },
                                                  ),
                                                  const Text('Pick Up'),
                                                ],
                                              ),
                                              Text(
                                                'The renter will pick up the item at your place',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 0.2),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Radio(
                                                    value: 4,
                                                    groupValue:
                                                        _radioRentalValue,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _radioRentalValue =
                                                            value;
                                                      });
                                                    },
                                                  ),
                                                  const Text('Not Applicable'),
                                                ],
                                              ),
                                              Text(
                                                'For real-estate properties,spaces, etc.',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    margin: const EdgeInsets.only(top: 15),
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: SizedBox.expand(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.blue,
                                          onPrimary: Colors.white,
                                        ),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            if (_radioRentalValue == null) {
                                              errorSnackBar(context,
                                                  "Please select a rental method");
                                            }

                                            return _isLoading
                                                ? null
                                                : _handlePost();
                                          }
                                        },
                                        child: Text(
                                            _isLoading ? 'Posting...' : 'Post'),
                                      ),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/abangi-dual-color.png',
                            height: 200,
                            width: 200,
                          ),
                          Center(
                            child: Text(
                              "You need to be verified to post listings",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            width: 800,
                            height: 60,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: const BorderSide(
                                    color: Color.fromRGBO(0, 176, 236, 1),
                                  )),
                              child: Text(
                                'Please Upload Government ID',
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 176, 236, 1),
                                    fontSize: 17),
                              ),
                              onPressed: () {
                                _pickFile();
                              },
                            ),
                          ),
                          Container(
                              height: 50,
                              margin: const EdgeInsets.only(top: 15),
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: SizedBox.expand(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue,
                                    onPrimary: Colors.white,
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      return _isLoading ? null : _handlePost();
                                    }
                                  },
                                  child: Text('Verify Now'),
                                ),
                              )),
                        ],
                      ));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _handlePost() async {
    setState(() {
      _isLoading = true;
    });
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var userid = localStorage.getString('userid');
      var data = {
        "ItemCategoryId": dropdownvalueCategory,
        "UserId": int.parse(userid!),
        "ItemName": listingController.text,
        "ItemPrice": double.parse(itemPriceController.text),
        "ItemDescription": itemDescriptionController.text,
        // ignore: prefer_interpolation_to_compose_strings
        "ItemLocation": itemHouseLocationController.text +
            ' ' +
            itemBarLocationController.text +
            ' ' +
            itemCityLocationController.text,
        "ItemImage": _fileName,
        "RentalMethodId": _radioRentalValue as int,
        "StartDate": _startDate,
        "EndDate": _endDate,
      };
      var res = await CallApi().postData(data, 'api/items');
      // ignore: prefer_typing_uninitialized_variables
      var body;
      if (res.body.isNotEmpty) {
        body = json.decode(res.body.toString().trim());
      }

      if (res.statusCode == 201) {
        // ignore: use_build_context_synchronously, avoid_single_cascade_in_expression_statements
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          headerAnimationLoop: false,
          animType: AnimType.bottomSlide,
          title: 'Success',
          desc: 'Item Posted Successfully',
          buttonsTextStyle: const TextStyle(color: Colors.white),
          showCloseIcon: false,
          btnOkOnPress: () {},
        ).show();
        clearText();
        // ignore: unnecessary_null_comparison
      } else {
        // ignore: use_build_context_synchronously
        errorSnackBar(context, "Error Posting Item Try Again");
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      _isLoading = false;
    });
  }
}
