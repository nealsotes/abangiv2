import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:abangi_v1/pages/Menus/Details/Chat/SignalRHelper%20.dart';
import 'package:abangi_v1/pages/messages.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:abangi_v1/Models/Item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'models/chatmessage.dart';

class Chat extends StatefulWidget {
  late var name;

  TextEditingController messageController = TextEditingController();
  late ItemModel? itemModel;
  final _formKey = GlobalKey<FormState>();
  Chat({
    Key? key,
    this.name,
    this.itemModel,
  }) : super(key: key);

  @override
  State<Chat> createState() => ChatScreen();
}

var updateStatus;

class ChatScreen extends State<Chat> {
  var scrollController = ScrollController();
  SignalRHelper signalRHelper = SignalRHelper();
  final List<ChatMessage> _messages = [];
  // receiveMessageHandler(args) {
  //   var message = ChatMessage.fromJson(jsonDecode(args[0]));
  //   _messages.add(message);

  //   setState(() {});
  // }
  receiveMessageHandler(args) {
    _messages.add(ChatMessage(
        name: args[0], message: args[1], isMine: args[0] == widget.name));
    scrollController.jumpTo(scrollController.position.maxScrollExtent + 75);
    setState(() {});
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
                  width: 230,
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
          padding: EdgeInsets.only(left: 17, right: 17),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Expanded(
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
                            maxWidth: MediaQuery.of(context).size.width * 0.7),
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
            ],
          ),
        ),
      ),
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white, fontFamily: 'Poppins'),
    );
  }

  // @override
  // void initState() async {
  //   super.initState();
  //   signalRHelper.connect(receiveMessageHandler);
  //   List<ChatMessage> messages = await signalRHelper.getMessages();
  //   setState(() {
  //     _messages.addAll(messages);
  //   });
  // }
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
}
