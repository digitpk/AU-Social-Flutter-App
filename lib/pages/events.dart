import 'package:ausocial/constants.dart';
import 'package:ausocial/pages/home.dart';
import 'package:flutter/material.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  logout() {
    googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Events',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_circle_outline,
                        size: 28,
                        color: Color(primaryBlue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
                child: ListView(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: logout,
                      child: Text('LogOut'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
