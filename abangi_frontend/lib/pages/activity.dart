// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class Activity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: ActivityScreen(),
      ),
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Poppins'),
    );
  }
}

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<ActivityScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 10),
                child: const Text(
                  'Activity',
                  style: TextStyle(
                      color: Color.fromRGBO(0, 176, 236, 1),
                      fontWeight: FontWeight.w600,
                      fontSize: 35),
                )),

            // ignore: avoid_unnecessary_containers

            Container(
                // ignore: prefer_const_constructors
                padding: const EdgeInsets.all(10),
                child: const Text('My Inquiries')),
          ],
        ));
  }
}
