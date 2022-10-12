import 'dart:convert';

import 'package:abangi_v1/global_utils.dart';
import 'package:abangi_v1/api/api.dart';
import 'package:flutter/material.dart';
import 'package:abangi_v1/pages/login.dart';

void main() => runApp(const SignUp());

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
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
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
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
                          'Sign Up',
                          style: TextStyle(
                              color: Color.fromRGBO(0, 176, 236, 1),
                              fontWeight: FontWeight.w400,
                              fontSize: 20),
                        )),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: const Text(
                        'Create and account to get started today',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(4),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    // ignore: prefer_const_constructors
                    style: TextStyle(fontSize: 14.0),
                    keyboardType: TextInputType.phone,
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return "* Required";
                      } else if (!RegExp(r'^[a-z A-Z]+$').hasMatch(val)) {
                        return "Enter valid name";
                      } else {
                        return null;
                      }
                    },
                  ),
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
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    // ignore: prefer_const_constructors
                    style: TextStyle(fontSize: 14.0),
                    controller: addressController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Address',
                    ),
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return "* Required";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    controller: mobileNumberController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone',
                    ),
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return "* Required";
                      } else if (!RegExp(r'^(09|\+639)\d{9}$').hasMatch(val)) {
                        return "Enter valid phone number";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    // ignore: prefer_const_constructors
                    style: TextStyle(fontSize: 14.0),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    controller: passwordController,
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return "* Required";
                      } else if (val.length < 6) {
                        return "Password should be atleast 6 characters";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    // ignore: prefer_const_constructors
                    style: TextStyle(fontSize: 14.0),
                    obscureText: true,
                    controller: confirmPasswordController,
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return '* Required';
                      }
                      if (val != passwordController.text) {
                        return 'Not Match';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm Password',
                    ),
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
                        child: Text(_isLoading ? "Signing up..." : 'Sign Up'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            return _isLoading ? null : _handleRegister();
                          }
                        })),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 90),
                      child: Row(
                        children: [
                          const Text("Already have an account?"),
                          TextButton(
                            child: const Text(
                              'Log in',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(0, 176, 236, 1)),
                            ),
                            onPressed: () {
                              //login screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )));
  }

  _handleRegister() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'email': emailController.text,
      'address': addressController.text,
      'password': passwordController.text,
      'contact': mobileNumberController.text,
      'fullname': nameController.text,
    };
    var res = await CallApi().postData(data, 'users/register');
    // ignore: prefer_typing_uninitialized_variables
    var body;

    if (res.body.isNotEmpty) {
      body = json.decode(res.body.toString().trim());
    }

    if (res.statusCode == 200) {
      // ignore: use_build_context_synchronously, prefer_const_constructors
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
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
