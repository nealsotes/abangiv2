import 'dart:convert';

import 'package:abangi_v1/global_utils.dart';
import 'package:abangi_v1/api/api.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:abangi_v1/pages/login.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color.fromRGBO(0, 176, 236, 1)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: MyStatefulWidget(),
      ),
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Poppins'),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Column(
                  children: [
                    Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(top: 5),
                        child: const Text(
                          'Reset Password',
                          style: TextStyle(
                              color: Color.fromRGBO(0, 176, 236, 1),
                              fontWeight: FontWeight.w400,
                              fontSize: 20),
                        )),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: const Text(
                        'Enter the email address associated with your account',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    // ignore: prefer_const_constructors
                    style: TextStyle(fontSize: 14.0),
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return "* Required";
                      } else if (!RegExp(r'^(?:\d{10}|\w+@\w+\.\w{2,3})$')
                          .hasMatch(val)) {
                        return "Enter valid email";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                    height: 50,
                    margin: const EdgeInsets.only(top: 15),
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            onSurface: const Color.fromRGBO(0, 176, 236, 1)),
                        // ignore: sort_child_properties_last
                        child: Text(
                            _isLoading ? "Reseting pass..." : 'Reset Password'),
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            headerAnimationLoop: false,
                            animType: AnimType.bottomSlide,
                            title: 'Success',
                            desc:
                                'Please check your email to reset your password. If you do not receive an email, please check your spam folder.',
                            buttonsTextStyle:
                                const TextStyle(color: Colors.white),
                            showCloseIcon: false,
                            btnOkOnPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()),
                              );
                            },
                          ).show();
                        })),
              ],
            )));
  }

  _handleResetPassword() async {
    setState(() {
      _isLoading = true;
    });
    String? token = await FirebaseMessaging.instance.getToken();

    var res =
        await CallApi().getData('forgot-password/${emailController.text}');
    // ignore: prefer_typing_uninitialized_variables
    var body;

    if (res.body.isNotEmpty) {
      body = json.decode(res.body.toString().trim());
    }

    if (res.statusCode == 200) {
      // ignore: use_build_context_synchronously, prefer_const_constructors
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        title: 'Success',
        desc: 'Please check your email to verify your account',
        buttonsTextStyle: const TextStyle(color: Colors.white),
        showCloseIcon: false,
        btnOkOnPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
          );
        },
      ).show();
    } else {
      // ignore: use_build_context_synchronously, void_checks
      errorSnackBar(context, body['message']);
    }
    print(body);
    setState(() {
      _isLoading = false;
    });
    // ignore: avoid_print
  }
}
