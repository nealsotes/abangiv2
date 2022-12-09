// ignore_for_file: unused_local_variable
import 'package:abangi_v1/pages/Menus/Details/Chat/chat.dart';
import 'package:abangi_v1/pages/forgot_password.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'dart:convert';
import 'package:abangi_v1/global_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:abangi_v1/api/api.dart';
import 'package:abangi_v1/pages/dash.dart';
import 'package:flutter/material.dart';
import 'package:abangi_v1/pages/signup.dart';

import 'home.dart';

void main() => runApp(const Login());

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: login(),
      ),
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Poppins'),
    );
  }
}

// ignore: camel_case_types
class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _LoginState();
}

class _LoginState extends State<login> {
  bool _isLoading = false;
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late ScaffoldState scaffoldState;

  // ignore: prefer_final_fields
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // ignore: unused_element
  //toggle show hide password

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unrelated_type_equality_checks
    return Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 70),
                  child: Image.asset(
                    'assets/images/abangi-dual-color.png',
                    height: 150,
                    width: 150,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: mailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return "Please enter email";
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
                  child: //toggle show/hide password
                      TextFormField(
                    controller: passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: _toggle,
                      ),
                    ),
                    validator: (String? val) {
                      if (val!.isEmpty) {
                        return "Please enter password";
                      } else if (val.length < 6) {
                        return "Password must be at least 6 characters";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgotPassword()),
                      );
                    },
                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    margin: const EdgeInsets.only(top: 15),
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          onSurface: const Color.fromRGBO(0, 176, 236, 1),
                        ),
                        child: Text(
                          _isLoading ? 'Loging in...' : 'Login',
                        ),
                        onPressed: () async {
                          final SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.setString(
                              'email', mailController.text);
                          if (_formKey.currentState!.validate()) {
                            return _isLoading ? null : _handleLogin();
                          }
                        })),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 90),
                      child: Row(
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromRGBO(0, 176, 236, 1)),
                            ),
                            onPressed: () {
                              //signup screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUp()),
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

  void _handleLogin() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'email': mailController.text,
      'password': passwordController.text
    };
    var res = await CallApi().postData(data, 'users/login');
    var body = json.decode(res.body.toString().trim());
    var getData = await CallApi().getData('users');
    var bodyData = json.decode(getData.body.toString().trim());

    if (res.statusCode == 200) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      for (var i = 0; i < bodyData.length; i++) {
        if (bodyData[i]['email'] == mailController.text) {
          localStorage.setString('user', bodyData[i]['fullName']);
          localStorage.setString('userid', bodyData[i]['userId'].toString());
          localStorage.setString('email', bodyData[i]['email']);
          localStorage.setString('userid', bodyData[i]['userId'].toString());
        }
      }

      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Homedash()),
      );
    } else {
      // ignore: use_build_context_synchronously
      errorSnackBar(context, body['message']);
    }

    setState(() {
      _isLoading = false;
    });
  }
}
