import 'package:flutter/material.dart';

class BlankPage extends StatelessWidget {
  const BlankPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Container(
      color: const Color(0xFF2DBD3A),
      child: Text("Please wait for the admin approval"),
    );
  }
}
