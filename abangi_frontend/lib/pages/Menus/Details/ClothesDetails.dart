// ignore_for_file: camel_case_types, prefer_const_constructors
import 'package:abangi_v1/Models/Item.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class ClothesDetails extends StatelessWidget {
  final ItemModel itemModel;
  const ClothesDetails(
      {Key? key,
      required this.itemModel,
      required String itemName,
      required String description,
      required double price,
      required String category,
      required String owner})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: false ? Colors.white : Colors.white,
            leading: IconButton(
              icon:
                  Icon(Icons.arrow_back, color: Color.fromRGBO(0, 176, 236, 1)),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 240,
                      // ignore: avoid_unnecessary_containers
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://images.pexels.com/photos/934070/pexels-photo-934070.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    // ignore: avoid_unnecessary_containers
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Text(
                        itemModel.itemName,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 21,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Text(
                        "₱${itemModel.price}/ day",
                        style: TextStyle(
                            color: Color.fromRGBO(0, 176, 236, 1),
                            fontSize: 21,
                            fontWeight: FontWeight.w600),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.location_on_outlined,
                                color: Color.fromRGBO(0, 176, 236, 1)),
                            onPressed: () {},
                          ),
                          Text(
                            itemModel.location,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove_red_eye_outlined,
                                color: Color.fromRGBO(0, 176, 236, 1)),
                            onPressed: () {},
                          ),
                          Text(
                            itemModel.rentalMethod,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.person_outline,
                                color: Color.fromRGBO(0, 176, 236, 1)),
                            onPressed: () {},
                          ),
                          Text(
                            itemModel.owner,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.verified_outlined,
                                color: Color.fromRGBO(0, 176, 236, 1)),
                            onPressed: () {},
                          ),
                          Text(
                            itemModel.rentalMethod,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Text(
                            "Description",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 21,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Text(
                        itemModel.description,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Poppins'),
    );
  }
}
