import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:abangi_v1/Models/Item.dart';
import 'package:abangi_v1/Models/User.dart';
import 'package:abangi_v1/api/api.dart';
import 'package:abangi_v1/pages/account_settings.dart';
import 'package:abangi_v1/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
        messageContent: json['text'], messageType: json['messageType']);
  }
}

List<ChatMessage> messages = [
  ChatMessage(messageContent: "Hello, Will", messageType: "receiver"),
  ChatMessage(messageContent: "How have you been?", messageType: "receiver"),
  ChatMessage(
      messageContent: "Hey Kriss, I am doing fine dude. wbu?",
      messageType: "sender"),
  ChatMessage(messageContent: "ehhhh, doing OK.", messageType: "receiver"),
  ChatMessage(
      messageContent: "Is there any thing wrong?", messageType: "sender"),
];

class Chat extends StatefulWidget {
  TextEditingController messageController = TextEditingController();
  ItemModel itemModel;
  final _formKey = GlobalKey<FormState>();
  Chat({
    Key? key,
    required this.itemModel,
  }) : super(key: key);

  Future<ChatMessage> getMessageData() async {
    var response = await CallApi().getData('api/chats');
    var jsonData = jsonDecode(response.body);
    print(jsonData);
    ChatMessage message = ChatMessage.fromJson(jsonData);
    return message;
  }

  @override
  State<Chat> createState() => _MyAppState();
}

var updateStatus;

class _MyAppState extends State<Chat> {
  late Future<ChatMessage> message;

  @override
  void initState() {
    super.initState();
    message = widget.getMessageData();
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
                    onPressed: () {},
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
                  child: Text(widget.itemModel.owner.substring(0, 1),
                      style: TextStyle(fontSize: 20, color: Colors.white))),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 6),
                    child: Text(widget.itemModel.owner,
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w500)),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text("(${super.widget.itemModel.userStatus})",
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
                  widget.itemModel.itemName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Row(
                  children: [
                    Text(
                      widget.itemModel.price.toString() + '/ day ',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      widget.itemModel.location,
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
                trailing: Image.file(File(widget.itemModel.image),
                    width: 59, height: 100, fit: BoxFit.cover),
              ),
              ListView.builder(
                itemCount: messages.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment: (messages[index].messageType == "receiver"
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (messages[index].messageType == "receiver"
                              ? Colors.grey.shade200
                              : Color.fromRGBO(0, 176, 236, 1)),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          messages[index].messageContent,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white, fontFamily: 'Poppins'),
    );
  }
}
