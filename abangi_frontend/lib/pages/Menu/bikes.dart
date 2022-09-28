// ignore_for_file: camel_case_types, prefer_const_constructors
import 'package:abangi_v1/Models/Item.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class Bikes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: false ? Colors.white : Colors.white,
          title: Text(
            'Bikes',
            style: TextStyle(
                color: false ? Colors.black : Colors.grey,
                fontWeight: FontWeight.w500),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color.fromRGBO(0, 176, 236, 1)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: BikesScreen(),
      ),
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Poppins'),
    );
  }
}

class BikesScreen extends StatefulWidget {
  const BikesScreen({Key? key}) : super(key: key);

  @override
  State<BikesScreen> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<BikesScreen> {
  static List<String> electronics = [
    'Panasonic Lumix DMC-G5 DSLR + accessories',
    'Raspberry pi 3 model B + Camera',
    'Mackie Mixer ProFX8v2 8-Channel Professional Effects Mixer',
    'Blue Microphones Yeti USB Microphone, Blackout',
    'Raspberry pi 3 model B + Camera',
    'Mackie Mixer ProFX8v2 8-Channel Professional Effects Mixer',
    'Blue Microphones Yeti USB Microphone, Blackout'
  ];
  static List url = [
    'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bGVuc3xlbnwwfHwwfHw%3D&w=1000&q=80',
    'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bGVuc3xlbnwwfHwwfHw%3D&w=1000&q=80',
    'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bGVuc3xlbnwwfHwwfHw%3D&w=1000&q=80',
    'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bGVuc3xlbnwwfHwwfHw%3D&w=1000&q=80',
    'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bGVuc3xlbnwwfHwwfHw%3D&w=1000&q=80',
    'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bGVuc3xlbnwwfHwwfHw%3D&w=1000&q=80',
    'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bGVuc3xlbnwwfHwwfHw%3D&w=1000&q=80',
  ];
  final List<ItemModel> BikesData = List.generate(
      electronics.length,
      (index) => ItemModel(electronics[index], 'Description', url[index],
          'Price', 'Location', 'Owner'));
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: BikesData.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Image.network(BikesData[index].itemImage),
                  title: Text(BikesData[index].itemName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(BikesData[index].itemPrice,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 176, 236, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                      Text(BikesData[index].itemLocation),
                      Text(BikesData[index].itemOwner),
                    ],
                  ),
                ),
              );
            }));
  }
}
