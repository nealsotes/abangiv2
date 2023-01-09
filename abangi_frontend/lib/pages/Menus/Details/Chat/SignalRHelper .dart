import 'dart:convert';
import 'dart:developer';
import 'package:abangi_v1/environment.dart';
import 'package:flutter/material.dart';
import 'package:signalr_netcore/signalr_client.dart';

import 'models/chatmessage.dart';

class SignalRHelper {
  final url = '${apiUrl}chatHub';
  late HubConnection hubConnection;
  var messageList = [];
  String textMessage = '';

  void connect(receiveMessageHandler) async {
    hubConnection =
        HubConnectionBuilder().withAutomaticReconnect().withUrl(url).build();
    hubConnection.on('ReceiveMessage', receiveMessageHandler);
    await hubConnection.start();
    hubConnection.onclose(({error}) {
      log(error.toString());
    });
  }

  //invokde the GetMessages method in the server
  // Future<List<ChatMessage>> getMessages() async {
  //   var messages = await hubConnection.invoke('GetMessages');
  //   var messageList = (messages as List)
  //       .map((message) => ChatMessage.fromJson(message))
  //       .toList();
  //   return messageList;
  // }

  void sendMessage(String name, String message) {
    hubConnection.invoke("SendMessage", args: [name, message]);
    textMessage = '';
  }

  void disconnect() {
    hubConnection.stop();
  }
}
