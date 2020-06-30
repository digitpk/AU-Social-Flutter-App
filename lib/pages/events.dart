import 'package:ausocial/constants.dart';
import 'package:ausocial/models/users.dart';
import 'package:ausocial/pages/add_events.dart';
import 'package:ausocial/pages/home.dart';
import 'package:ausocial/widgets/event_container.dart';
import 'package:ausocial/widgets/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventsPage extends StatefulWidget {
  final User currentUser;

  EventsPage({this.currentUser});
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  bool isLoading = false;
  List<EventPost> posts = [];
  @override
  void initState() {
    super.initState();
    getEventPosts();
  }

  getEventPosts() async {
    setState(() {
      isLoading = true;
    });

    print("Current ID : ${googleSignIn.currentUser.id ?? 'empty'}");
    QuerySnapshot snapshot =
        await eventRef.orderBy('timeStamp', descending: true).getDocuments();
    setState(() {
      isLoading = false;
      posts =
          snapshot.documents.map((doc) => EventPost.fromDocument(doc)).toList();
    });
  }

  logout() {
    googleSignIn.signOut();
  }

  buildEventPosts() {
    if (isLoading) {
      return circularProgress();
    }
    return Column(
      children: posts,
    );
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
              padding: const EdgeInsets.only(
                left: 16.0,
                bottom: 8,
                right: 16,
              ),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        'Events',
                        style: GoogleFonts.abel(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AddEvents(currentUser: currentUser)));
                            },
                            icon: Icon(
                              Icons.add_circle_outline,
                              size: 28,
                              color: Color(primaryBlue),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20.0,
                          ),
                          child: IconButton(
                            onPressed: () {
                              logout();
                            },
                            icon: Icon(
                              Icons.clear,
                              size: 28,
                              color: Color(primaryBlue),
                            ),
                          ),
                        ),
                      ],
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
                    buildEventPosts(),
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
