import 'package:ausocial/pages/home.dart';
import 'package:flutter/material.dart';

///Changed UI and added user details to database
///Need to design Event page and start working with its functions

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
