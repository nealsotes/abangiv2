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

  void sendMessage(String name, String message) {
    hubConnection.invoke("SendMessage", args: [name, message]);
    // messageList.add(ChatMessage(name: name, message: message));
    // messageList.add(ChatMessage(name: name, message: message, isMine: true));
  }

  void disconnect() {
    hubConnection.stop();
  }
}
