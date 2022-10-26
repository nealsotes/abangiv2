import 'package:abangi_v1/pages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const kChatServerUrl = "http://172.25.240.1:5000";
void main() => runApp(ProviderScope(
      child: WelcomeScreen(),
    ));
