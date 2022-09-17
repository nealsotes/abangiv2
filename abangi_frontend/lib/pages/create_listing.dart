// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';

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
                  'Create Listing',
                  style: TextStyle(
                      color: Color.fromARGB(255, 1, 17, 22),
                      fontWeight: FontWeight.w600,
                      fontSize: 25),
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
              child: ElevatedButton(
                child: const Text('Add Photo'),
                onPressed: () {},
              ),
            ),

            Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Listing Title',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: nameOfListing,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name this listing',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Category',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: nameOfListing,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Home Equipment',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Sub Category',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: nameOfListing,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'None',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Description',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(),
            )
            // ignore: avoid_unnecessary_containers
          ],
        ));
  }
}
