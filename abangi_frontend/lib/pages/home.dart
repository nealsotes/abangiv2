// ignore_for_file: camel_case_types, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

// ignore: use_key_in_widget_constructors
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: HomeScreen(),
      ),
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Poppins'),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  ParseUser? currentUser;
  Future<ParseUser?> getData() async {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            /*   new Positioned(
              child: AppBar(
                title: Text(''), // You can add title here
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back, color: Colors.grey),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Welcome()),
                    );
                  },
                ),
                backgroundColor: Colors.white,
                //You can make this transparent
                elevation: 0.0, //No shadow
              ),
            ), */
            Container(
                alignment: Alignment.topRight,
                // ignore: unnecessary_new
                child: new IconButton(
                    onPressed: () {}, icon: Icon(Icons.notifications))),
            Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 2),
                child: FutureBuilder<ParseUser?>(
                  future: getData(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: CircularProgressIndicator(),
                          ),
                        );

                      default:
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Center(
                                child: Text(
                                  'let\'s Rent,',
                                  style: TextStyle(
                                      color: Color.fromRGBO(0, 176, 236, 1),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 35),
                                ),
                              )
                            ],
                          ),
                        );
                    }
                  },
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  labelText: 'Search',
                ),
              ),
            ),
          ],
        ));
  }
}
