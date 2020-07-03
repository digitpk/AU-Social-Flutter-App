import 'package:ausocial/constants.dart';
import 'package:ausocial/models/users.dart';
import 'package:ausocial/pages/about_page.dart';
import 'package:ausocial/pages/add_events.dart';
import 'package:ausocial/pages/home.dart';
import 'package:ausocial/widgets/event_container.dart';
import 'package:ausocial/widgets/progress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EventsPage extends StatefulWidget {
  final User currentUsers;

  EventsPage({this.currentUsers});
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  bool isLoading = false;
  List<EventPost> posts = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

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
    QuerySnapshot snapshot = await eventRef
        .orderBy(
          'eventDate',
          descending: false,
        )
        .getDocuments();

    setState(() {
      isLoading = false;

      posts =
          snapshot.documents.map((doc) => EventPost.fromDocument(doc)).toList();
    });
    _refreshController.refreshCompleted();
  }

  logout() {
    googleSignIn.signOut();
  }

  buildEventPosts() {
    if (isLoading) {
      return circularProgress();
    }
    return BounceInUp(
      child: Column(
        children: posts,
      ),
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
              child: Stack(
                children: <Widget>[
                  Container(
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
//                        Padding(
//                          padding: const EdgeInsets.only(top: 20.0),
//                          child: GestureDetector(
//                            onTap: logout,
//                            onDoubleTap: () => Navigator.push(
//                                context,
//                                MaterialPageRoute(
//                                    builder: (context) => AboutPage())),
//                            child: Container(
//                              decoration: BoxDecoration(
//                                borderRadius: BorderRadius.circular(20),
//                              ),
//                              width: 40,
//                              height: 40,
//                              child: ClipRRect(
//                                borderRadius: BorderRadius.circular(15),
//                                child: Image(
//                                  image: CachedNetworkImageProvider(
//                                    '${googleSignIn.currentUser.photoUrl}',
//                                  ),
//                                ),
//                              ),
//                            ),
//                          ),
//                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddEvents(
                                              currentUser: currentUser)));
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
                ],
              ),
            ),
            Flexible(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
                child: SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: true,
                  onRefresh: getEventPosts,
                  header: WaterDropHeader(
                    waterDropColor: Color(primaryBlue),
                    idleIcon: Icon(
                      Icons.airplanemode_active,
                      color: Colors.white,
                      size: 10,
                    ),
                  ),
                  child: ListView(
                    children: <Widget>[
                      buildEventPosts(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
