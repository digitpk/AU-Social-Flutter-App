import 'package:ausocial/constants.dart';
import 'package:ausocial/pages/event_details_page.dart';
import 'package:ausocial/pages/home.dart';
import 'package:ausocial/widgets/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_animator/widgets/bouncing_entrances/bounce_in_right.dart';
import 'package:google_fonts/google_fonts.dart';

class EventPost extends StatefulWidget {
  final String eventTitle;
  final String eventDesc;
  final String eventWebsite;
  final DateTime eventDate;
  final DateTime eventTime;
  final String department;
  final String contact;
  final String mediaUrl;
  final String eventId;
  final String ownerId;
  final Timestamp timeStamp;
  final dynamic likes;

  EventPost({
    this.eventId,
    this.timeStamp,
    this.eventTitle,
    this.eventDesc,
    this.eventDate,
    this.eventTime,
    this.department,
    this.contact,
    this.mediaUrl,
    this.likes,
    this.ownerId,
    this.eventWebsite,
  });

  factory EventPost.fromDocument(DocumentSnapshot doc) {
    return EventPost(
      eventId: doc['eventId'],
      eventTitle: doc['eventTitle'],
      eventDesc: doc['eventDescription'],
      eventTime: DateTime.parse(doc['eventTime'].toDate().toString()),
      eventDate: DateTime.parse(doc['eventDate'].toDate().toString()),
      department: doc['department'],
      mediaUrl: doc['mediaUrl'],
      contact: doc['contact'],
      timeStamp: doc['timeStamp'],
      likes: doc['likes'],
      ownerId: doc['ownerId'],
      eventWebsite: doc['eventWebsite'],
    );
  }

  int getLikesCount(likes) {
    if (likes == null) {
      return 0;
    }
    int count = 0;
    likes.values.forEach((val) {
      if (val == true) {
        count++;
      }
    });
    print(count);
    return count;
  }

  @override
  _EventPostState createState() => _EventPostState(
        ownerId: this.ownerId,
        eventId: this.eventId,
        eventDesc: this.eventDesc,
        eventTime: this.eventTime,
        eventTitle: this.eventTitle,
        eventDate: this.eventDate,
        contact: this.contact,
        dept: this.department,
        mediaUrl: this.mediaUrl,
        timeStamp: this.timeStamp,
        eventWebsite: this.eventWebsite,
        likes: this.likes,
        likeCount: getLikesCount(this.likes),
      );
}

class _EventPostState extends State<EventPost> {
  final String eventTitle;
  final String ownerId;
  final String eventDesc;
  final String eventWebsite;
  final DateTime eventDate;
  final DateTime eventTime;
  final String dept;
  final String contact;
  final String mediaUrl;
  final String eventId;
  final Timestamp timeStamp;

  Map likes;
  int likeCount;

  _EventPostState({
    this.eventWebsite,
    this.ownerId,
    this.eventId,
    this.timeStamp,
    this.eventTitle,
    this.eventDesc,
    this.eventDate,
    this.eventTime,
    this.dept,
    this.contact,
    this.mediaUrl,
    this.likes,
    this.likeCount,
  });

  void initState() {
    super.initState();
    print("EventContainer Created");
  }

  buildPost() {
    return FutureBuilder(
      future: userRef.document(ownerId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
//        User user = User.fromDocument(snapshot.data);
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: GestureDetector(
            onTap: () {
              print("Event Clicked");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EventDetailsPage(
                            ownerId: this.ownerId,
                            eventId: this.eventId,
                            eventWebsite: this.eventWebsite,
                            eventDesc: this.eventDesc,
                            eventTime: this.eventTime,
                            eventTitle: this.eventTitle,
                            eventDate: this.eventDate,
                            contact: this.contact,
                            department: this.dept,
                            mediaUrl: this.mediaUrl,
                            timeStamp: this.timeStamp,
                            likes: this.likes,
                          )));
            },
            child: Container(
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Hero(
                      tag: '${widget.mediaUrl}',
                      child: Container(
                        height: 230,
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          mediaUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width - 30,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(.7),
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0.0,
                    bottom: 20.0,
                    child: BounceInRight(
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: Color(primaryBlue),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              '${DateTimeFormat.format(
                                eventDate,
                                format: 'j M',
                              )}',
                              style: GoogleFonts.quicksand(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    bottom: 20.0,
                    child: BounceInLeft(
                      child: Container(
                        child: Text(
                          '$eventTitle',
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildPost();
  }
}
