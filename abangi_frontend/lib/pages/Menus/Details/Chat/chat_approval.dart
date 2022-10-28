import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:abangi_v1/Models/Rental.dart';
import 'package:abangi_v1/api/api.dart';
import 'package:abangi_v1/pages/messages.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:abangi_v1/Models/Item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'SignalRHelper .dart';
import 'models/chatmessage.dart';

class ChatApproval extends StatefulWidget {
  late var name;
  final RentalModel rental;
  TextEditingController messageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  ChatApproval({
    Key? key,
    this.name,
    required this.rental,
  }) : super(key: key);

  @override
  State<ChatApproval> createState() => ChatApprovalScreen();
}

var updateStatus;

class ChatApprovalScreen extends State<ChatApproval> {
  var scrollController = ScrollController();
  SignalRHelper signalRHelper = SignalRHelper();
  receiveMessageHandler(args) {
    signalRHelper.messageList.add(ChatMessage(
        name: args[0], message: args[1], isMine: args[0] == widget.name));
    scrollController.jumpTo(scrollController.position.maxScrollExtent + 75);
    setState(() {});
  }

  var transactionMessage = 'Transaction Cancelled';
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
                    icon: Icon(
                      Icons.camera_alt,
                      color: Color.fromRGBO(0, 176, 236, 1),
                    )),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  color: Colors.grey.shade100,
                  width: 300,
                  height: 45,
                  child: TextField(
                    controller: widget.messageController,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                        prefixIcon: Icon(
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
                    },
                    icon: Icon(
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
            children: [
              CircleAvatar(
                  radius: 25,
                  backgroundColor: Color.fromRGBO(0, 176, 236, 1),
                  child: Text(widget.rental.owner.substring(0, 1),
                      style: TextStyle(fontSize: 20, color: Colors.white))),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 6),
                    child: Text(widget.rental.owner,
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w500)),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text("(${super.widget.rental.userStatus})",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.green,
                            fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 17, right: 17),
          child: Column(
            children: [
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                tileColor: Colors.grey.shade200,
                title: Text(
                  widget.rental.itemName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.rental.rentalPrice.toString() + '/ day ',
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          widget.rental.location,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    widget.rental.rentalStatus == 'Cancelled'
                        ? Center(
                            child: Text(widget.rental.rentalRemarks,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.redAccent)),
                          )
                        : RefreshIndicator(
                            onRefresh: onRefresh,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 5.0),
                                  child: Text(widget.rental.rentalRemarks,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.redAccent)),
                                ),
                                Container(
                                  width: Size.infinite.width,
                                  padding: EdgeInsets.only(top: 2.0),
                                  margin:
                                      EdgeInsets.only(top: 5.0, bottom: 5.0),
                                  child: ElevatedButton(
                                      onPressed: () {
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
                                              "value": "Transaction Cancelled."
                                            }
                                          ];
                                          CallApi().patchData(data,
                                              'api/rentals/${widget.rental.rentalId}');
                                        } catch (e) {
                                          print(e);
                                        }
                                        onRefresh();
                                      },
                                      child: Text(
                                        "Cancel Reservation",
                                        style: TextStyle(fontSize: 12),
                                      )),
                                ),
                              ],
                            ),
                          )
                  ],
                ),
                trailing: Image.file(File(widget.rental.image),
                    width: 59, height: 100, fit: BoxFit.cover),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  itemCount: signalRHelper.messageList.length,
                  itemBuilder: (context, i) {
                    return Align(
                      alignment: signalRHelper.messageList[i].isMine
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                            color: signalRHelper.messageList[i].isMine
                                ? Color.fromRGBO(0, 176, 236, 1)
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          signalRHelper.messageList[i].isMine
                              ? signalRHelper.messageList[i].message
                              : signalRHelper.messageList[i].name +
                                  ': ' +
                                  signalRHelper.messageList[i].message,
                          textAlign: signalRHelper.messageList[i].isMine
                              ? TextAlign.end
                              : TextAlign.start,
                          style: TextStyle(
                              color: signalRHelper.messageList[i].isMine
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, i) {
                    return Divider(
                      thickness: 0.1,
                    );
                  },
                ),
              ),
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
  }

  @override
  void dispose() {
    widget.messageController.dispose();
    scrollController.dispose();
    signalRHelper.disconnect();
    super.dispose();
  }

  Future<void> onRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
  }
}