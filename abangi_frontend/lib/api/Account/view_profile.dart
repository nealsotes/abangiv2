// ignore_for_file: camel_case_types, prefer_const_constructors, unused_field
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:abangi_v1/Models/User.dart';
import 'package:abangi_v1/api/api.dart';
import 'package:abangi_v1/pages/blank_page.dart';
import 'package:angles/angles.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'dart:math';
import 'dart:core';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:open_file/open_file.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart' as intl;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

// ignore: use_key_in_widget_constructors
class ViewProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromRGBO(0, 176, 236, 1),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ViewProfileState(),
      ),
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Poppins'),
    );
  }
}

// ignore: prefer_typing_uninitialized_variables
var currentId;
Future<User> getUser() async {
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  currentId = localStorage.getString('userid');

  final response = await CallApi().getData('users/$currentId');
  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user');
  }
}

class ViewProfileState extends StatefulWidget {
  const ViewProfileState({Key? key}) : super(key: key);

  @override
  State<ViewProfileState> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<ViewProfileState> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  late final EditAction _editAction;
  late Future<User> futureUser;
  var edit = true;

  //image upload

  File? _image;
  //PickedFile? _pickedFile;
  final _picker = ImagePicker();
  String _uploadedFileURL = '';
  //we can use this to get the image from the gallery
  //get image from database and display it

  Future<void> getImageFromGallery(ImageSource media) async {
    var _pickedImage = await ImagePicker().pickImage(source: media);
    setState(() {
      _image = File(_pickedImage!.path);
    });
    _uploadedFileURL = base64Encode(_image!.readAsBytesSync());
  }

  @override
  void initState() {
    super.initState();
    futureUser = getUser();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FutureBuilder<User>(
              future: futureUser,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Profile", style: TextStyle(fontSize: 30)),
                          Spacer(),
                          CircleAvatar(
                            backgroundImage: Image.file(File(
                                    snapshot.data!.profileImage == null
                                        ? ''
                                        : snapshot.data!.profileImage!))
                                .image,
                            radius: 50,
                            child: IconButton(
                              icon: snapshot.data!.profileImage == null
                                  ? Icon(Icons.add_a_photo)
                                  : Icon(Icons.edit),
                              onPressed: () {
                                myAlert();
                              },
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Name: "),
                              Container(
                                width: 270,
                                child: TextFormField(
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                  //  initialValue: snapshot.data!.name,
                                  readOnly: edit,
                                  controller: _nameController =
                                      TextEditingController(
                                          text: snapshot.data!.name),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Phone: "),
                              Container(
                                width: 270,
                                child: TextFormField(
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                  controller: _phoneController =
                                      TextEditingController(
                                          text: snapshot.data!.phone),
                                  readOnly: edit,
                                  // initialValue: snapshot.data!.phone,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Email: "),
                              Container(
                                width: 270,
                                child: TextFormField(
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                  controller: _emailController =
                                      TextEditingController(
                                          text: snapshot.data!.email),
                                  // initialValue: snapshot.data!.email,
                                  readOnly: edit,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Location: "),
                              Container(
                                width: 260,
                                child: TextFormField(
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                  controller: _addressController =
                                      TextEditingController(
                                          text: snapshot.data!.location),
                                  //  initialValue: snapshot.data!.location,
                                  readOnly: edit,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ]),
                      ),
                      Center(
                        child: Container(
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromRGBO(0, 176, 236, 1),
                          ),
                          margin: EdgeInsets.only(top: 50),
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                edit = !edit;
                              });
                            },
                            child: Text('Edit Profile'),
                          ),
                        ),
                      ),
                      edit
                          ? Container()
                          : Center(
                              child: Container(
                                width: 300,
                                height: 55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromRGBO(0, 176, 236, 1),
                                ),
                                margin: EdgeInsets.only(top: 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      edit = !edit;
                                    });

                                    _handlePatch();
                                  },
                                  child: Text('Save Profile'),
                                ),
                              ),
                            )
                    ],
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        )
      ],
    );
  }

  void _handlePatch() async {
    try {
      var data = [
        {"op": "replace", "path": "fullName", "value": _nameController.text},
        {"op": "replace", "path": "email", "value": _emailController.text},
        {"op": "replace", "path": "phone", "value": _phoneController.text},
        {"op": "replace", "path": "address", "value": _addressController.text},
        {"op": "replace", "path": "userImage", "value": _uploadedFileURL},
      ];

      await CallApi().patchData(data, 'users/$currentId');
    } catch (e) {
      print(e);
    }
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImageFromGallery(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImageFromGallery(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class EditAction extends Action<MyIntent> {
  @override
  void addActionListener(ActionListenerCallback listener) {
    super.addActionListener(listener);
    debugPrint('addActionListener');
  }

  @override
  void removeActionListener(ActionListenerCallback listener) {
    super.removeActionListener(listener);
    debugPrint('Action Listener was removed');
  }

  @override
  Object? invoke(covariant MyIntent intent) {
    notifyActionListeners();
  }
}

class MyIntent extends Intent {
  const MyIntent();
}
