import 'package:ausocial/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

/// Add Animation to Homepage
/// try to solve the error in addEventsPage Animation

void main() {
  setupLocator();
  runApp(MyApp());
}

GetIt locator = GetIt();

void setupLocator() {
  locator.registerSingleton(CallsAndMessagesService());
}

class CallsAndMessagesService {
  void call(String number) => launch("tel:$number");
  void mail(String mail) => launch("mailto:$mail");
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
