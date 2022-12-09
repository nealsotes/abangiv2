import 'package:abangi_v1/pages/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'constants.dart';

const kChatServerUrl = "http://172.25.240.1:5000";
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
  await Stripe.instance.applySettings();
  await Firebase.initializeApp();
  //check if user is logged in or not
  runApp(ProviderScope(
    child: WelcomeScreen(),
  ));
}
