import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:abangi_v1/Models/Rental.dart';
import 'package:abangi_v1/api/api.dart';
import 'package:abangi_v1/pages/Payments/CardFormScreen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SignalRHelper .dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'models/chatmessage.dart';
import 'package:intl/intl.dart' as intl;

// ignore: must_be_immutable
class ChatApproval extends StatefulWidget {
  late var name;
  late RentalModel? rental;
  TextEditingController messageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  ChatApproval({
    Key? key,
    this.name,
    this.rental,
  }) : super(key: key);

  @override
  State<ChatApproval> createState() => ChatApprovalScreen();
}

// ignore: prefer_typing_uninitialized_variables
var updateStatus;

class ChatApprovalScreen extends State<ChatApproval> {
  bool isCancelled = false;
  var scrollController = ScrollController();
  SignalRHelper signalRHelper = SignalRHelper();
  final List<ChatMessage> _messages = [];
  receiveMessageHandler(args) {
    _messages.add(ChatMessage(
        name: args[0], message: args[1], isMine: args[0] == widget.name));
    scrollController.jumpTo(scrollController.position.maxScrollExtent + 75);
    setState(() {});
  }

  void _toggleCancel() {
    setState(() {
      isCancelled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Form(
          key: widget._formKey,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    iconSize: 40,
                    onPressed: () {},
                    // ignore: prefer_const_constructors
                    icon: Icon(
                      Icons.camera_alt,
                      color: const Color.fromRGBO(0, 176, 236, 1),
                    )),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  color: Colors.grey.shade100,
                  width: 230,
                  height: 55,
                  child: TextField(
                    controller: widget.messageController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 15),
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.abc,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none),
                  ),
                ),
                IconButton(
                    iconSize: 40,
                    onPressed: () {
                      signalRHelper.sendMessage(
                          widget.name, widget.messageController.text);

                      widget.messageController.clear();
                      scrollController.jumpTo(
                          scrollController.position.maxScrollExtent + 75);
                      scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut);
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Color.fromRGBO(0, 176, 236, 1),
                    )),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: const Color.fromRGBO(0, 176, 236, 1),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Row(
            children: [],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 17, right: 17),
          child: Column(
            children: [
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                tileColor: Colors.grey.shade200,
                title: Text(
                  widget.rental!.itemName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: SizedBox(
                  width: 250,
                  //add toggle button to show and hide the column

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.rental!.rentalPrice}/ day ',
                            style: const TextStyle(fontSize: 9),
                          ),
                          Text(widget.rental!.location,
                              style: const TextStyle(fontSize: 9)),
                        ],
                      ),

                      super.widget.rental!.rentalStatus == 'Cancelled' ||
                              isCancelled ||
                              widget.rental!.rentalStatus == 'Approved' ||
                              widget.rental!.rentalStatus ==
                                  'Pending payment' ||
                              widget.rental!.rentalStatus == 'Completed'
                          ? Center(
                              child: isCancelled == true
                                  ? const Text(
                                      'Cancelled',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.redAccent),
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          widget.rental!.rentalRemarks,
                                          style: const TextStyle(
                                              fontSize: 9,
                                              color: Colors.redAccent),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(5.0),
                                          width: 170,
                                          height: 33,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            "Amount Due: P${widget.rental!.rentalPrice}",
                                            style:
                                                const TextStyle(fontSize: 12.0),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                height: 40,
                                                margin: const EdgeInsets.only(
                                                    top: 5.0, left: 17.0),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary:
                                                        Colors.grey.shade200,
                                                    onPrimary: Colors.black,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    try {
                                                      var data = [
                                                        {
                                                          "op": "replace",
                                                          "path":
                                                              "rentalStatus",
                                                          "value": "Cancelled"
                                                        },
                                                        {
                                                          "op": "replace",
                                                          "path":
                                                              "rentalRemarks",
                                                          "value":
                                                              "Transaction Cancelled."
                                                        }
                                                      ];
                                                      _toggleCancel();
                                                      await CallApi().patchData(
                                                          data,
                                                          'api/rentals/${widget.rental!.rentalId}');
                                                    } catch (e) {
                                                      print(e);
                                                    }
                                                    onRefresh();
                                                  },
                                                  child: const Text('Cancel'),
                                                )),
                                            Container(
                                                width: 107,
                                                height: 40,
                                                margin: const EdgeInsets.only(
                                                    left: 10.0, top: 5.0),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary:
                                                        const Color.fromRGBO(
                                                            0, 176, 236, 1),
                                                    onPrimary: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              CardFormScreen(
                                                                rental: widget
                                                                    .rental!,
                                                              )),
                                                    );
                                                  },
                                                  child: const Text('Pay Now'),
                                                )),
                                          ],
                                        )
                                      ],
                                    ))
                          : RefreshIndicator(
                              onRefresh: onRefresh,
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 5.0),
                                    child: Text(widget.rental!.rentalRemarks,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.redAccent)),
                                  ),
                                  Container(
                                    width: Size.infinite.width,
                                    padding: const EdgeInsets.only(top: 2.0),
                                    margin: const EdgeInsets.only(
                                        top: 5.0, bottom: 5.0),
                                    child: widget.rental!.rentalStatus == "Paid"
                                        ? ElevatedButton(
                                            onPressed: () {
                                              //show Rating Dialog
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return RatingDialog(
                                                      initialRating: 1.0,
                                                      starSize: 25.0,
                                                      title: Text(
                                                        'Please rate this transaction',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      message: Text(
                                                        'Tap a star to set your rating.',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      image: Image.asset(
                                                        'assets/images/abangi-dual-color.png',
                                                        height: 150,
                                                        width: 150,
                                                      ),
                                                      submitButtonText:
                                                          "Submit",
                                                      onCancelled: () =>
                                                          print('cancelled'),
                                                      onSubmitted:
                                                          (response) async {
                                                        print(
                                                            'rating: ${response.rating}, comment: ${response.comment}');
                                                        _submitFeedback(
                                                            response);
                                                        try {
                                                          var data = [
                                                            {
                                                              "op": "replace",
                                                              "path":
                                                                  "rentalStatus",
                                                              "value":
                                                                  "Completed"
                                                            },
                                                            {
                                                              "op": "replace",
                                                              "path":
                                                                  "rentalRemarks",
                                                              "value":
                                                                  "Transaction Completed."
                                                            }
                                                          ];
                                                          _toggleCancel();
                                                          await CallApi().patchData(
                                                              data,
                                                              'api/rentals/${widget.rental!.rentalId}');
                                                          await CallApi()
                                                              .deleteData(
                                                                  'api/rentals/${widget.rental!.rentalId}');
                                                          setState(() {
                                                            widget.rental!
                                                                    .rentalStatus =
                                                                "Completed";
                                                            widget.rental!
                                                                    .rentalRemarks =
                                                                "Transaction Completed.";
                                                          });
                                                        } catch (e) {
                                                          print(e);
                                                        }
                                                      },
                                                    );
                                                  });
                                            },
                                            child: const Text(
                                                "Complete Transaction"))
                                        : ElevatedButton(
                                            onPressed: () async {
                                              try {
                                                var data = [
                                                  {
                                                    "op": "replace",
                                                    "path": "rentalStatus",
                                                    "value": "Cancelled"
                                                  },
                                                  {
                                                    "op": "replace",
                                                    "path": "rentalRemarks",
                                                    "value":
                                                        "Transaction Cancelled."
                                                  }
                                                ];
                                                _toggleCancel();
                                                await CallApi().patchData(data,
                                                    'api/rentals/${widget.rental!.rentalId}');
                                                await CallApi().deleteData(
                                                    'api/rentals/${widget.rental!.rentalId}');
                                              } catch (e) {
                                                print(e);
                                              }
                                              onRefresh();
                                            },
                                            child: const Text(
                                              "Cancel Reservation",
                                              style: TextStyle(fontSize: 12),
                                            )),
                                  ),
                                ],
                              ),
                            )
                      // ignore: unrelated_type_equality_checks
                    ],
                  ),
                ),
                trailing: Container(
                  width: 55,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: MemoryImage(base64Decode(widget.rental!.image),
                          scale: 0.5),
                    ),
                  ),
                ),
              ),
              WillPopScope(
                  child: Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: scrollController,
                      itemCount: _messages.length,
                      itemBuilder: (context, i) {
                        return Align(
                          alignment: _messages[i].isMine
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            height: 50,
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.7),
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                                color: _messages[i].isMine
                                    ? const Color.fromRGBO(0, 176, 236, 1)
                                    : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12)),
                            child: Text(
                              _messages[i].isMine
                                  ? _messages[i].message
                                  : '${_messages[i].name}: ${_messages[i].message}',
                              textAlign: _messages[i].isMine
                                  ? TextAlign.end
                                  : TextAlign.start,
                              style: TextStyle(
                                  color: _messages[i].isMine
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  onWillPop: () async {
                    return false;
                  }),
            ],
          ),
        ),
      ),
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white, fontFamily: 'Poppins'),
    );
  }

  @override
  void initState() {
    super.initState();
    signalRHelper.connect(receiveMessageHandler);
    //make not awia
    List<ChatMessage> messages = [];
    setState(() {
      _messages.addAll(messages);
    });
  }

  @override
  void dispose() {
    widget.messageController.dispose();
    scrollController.dispose();
    signalRHelper.disconnect();
    super.dispose();
  }

  Future<void> onRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {});
  }

  _submitFeedback(response) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userId = localStorage.getString('userid');
    try {
      var data = {
        "userId": int.parse(userId!),
        "itemId": widget.rental!.itemId,
        "ratings": response.rating,
        "comments": response.comment,
      };
      var res = await CallApi().postData(data, 'api/feedbacks');
      var body = json.decode(res.body);
      if (res.statusCode == 200) {
        print(body);
      } else {
        print(body);
      }
    } catch (e) {
      print(e);
    }
    Navigator.of(context).pop();
  }

  void historyTransactions(
      String owner,
      String itemrented,
      String dateRequested,
      String datereturned,
      String paymentStatus,
      String paymentMethod,
      String transactionStatus,
      int itemPrice,
      String itemCategory,
      int amountPaid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var renter = prefs.getString('user');
    var data = {
      "renter": renter,
      "owner": owner,
      "itemrented": itemrented,
      "daterented": dateRequested,
      "dateReturned": datereturned,
      "paymentstatus": paymentStatus,
      "paymentmethod": paymentMethod,
      "transactionStatus": transactionStatus,
      "itemPrice": itemPrice,
      "itemCategory": itemCategory,
      "amountPage": amountPaid
    };

    var res = await CallApi().postData(data, "api/transactionhistory");
    var body = json.decode(res.body);
    if (res.statusCode == 200) {
      print(body);
    } else {
      print(body);
    }
  }
}

class CancelAction extends Action<MyIntent> {
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
  // ignore: body_might_complete_normally_nullable
  Object? invoke(covariant MyIntent intent) {
    notifyActionListeners();
  }
}

class MyIntent extends Intent {
  const MyIntent();
}
