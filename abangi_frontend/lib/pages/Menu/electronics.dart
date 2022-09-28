// ignore_for_file: camel_case_types, prefer_const_constructors
import 'package:abangi_v1/Models/Item.dart';
import 'package:flutter/material.dart';

import 'Details/ElectronicsDetails.dart';

// ignore: use_key_in_widget_constructors
class Electronics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: false ? Colors.white : Colors.white,
          title: Text(
            'Electronics',
            style: TextStyle(
                color: false ? Colors.black : Colors.grey,
                fontWeight: FontWeight.w500),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color.fromRGBO(0, 176, 236, 1)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: ElectronicsScreen(),
      ),
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Poppins'),
    );
  }
}

class ElectronicsScreen extends StatefulWidget {
  const ElectronicsScreen({Key? key}) : super(key: key);

  @override
  State<ElectronicsScreen> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<ElectronicsScreen> {
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
    'https://picsum.photos/seed/picsum/500/500',
    'https://loremflickr.com/320/240',
    'https://picsum.photos/seed/picsum/500/500',
    'https://picsum.photos/seed/picsum/500/500',
    'https://picsum.photos/seed/picsum/500/500',
    'https://picsum.photos/seed/picsum/500/500',
    'https://picsum.photos/seed/picsum/500/500',
  ];
  final List<ItemModel> ElectronicsData = List.generate(
      electronics.length,
      (index) => ItemModel(electronics[index], 'Description', url[index],
          'Price', 'Location', 'Owner'));
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: ElectronicsData.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Image.network(ElectronicsData[index].itemImage),
                  title: Text(ElectronicsData[index].itemName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ElectronicsData[index].itemPrice,
                          style: TextStyle(
                              color: Color.fromRGBO(0, 176, 236, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                      Text(ElectronicsData[index].itemLocation),
                      Text(ElectronicsData[index].itemOwner),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ElectronicsDetails(
                                itemModel: ElectronicsData[index])));
                  },
                ),
              );
            }));
  }
}
