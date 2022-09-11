import 'package:abangi_v1/pages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(ProviderScope(
      child: WelcomeScreen(),
    ));
