import 'package:ausocial/pages/home.dart';
import 'package:flutter/material.dart';

///Added Home page for Signing in with Google account
///need to Start with main page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
