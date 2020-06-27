//import 'package:ausocial/models/users.dart';
import 'package:ausocial/pages/home.dart';
import 'package:ausocial/widgets/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventPost extends StatefulWidget {
  final String eventTitle;
  final String eventDesc;
  final String eventDate;
  final String eventTime;
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
  });

  factory EventPost.fromDocument(DocumentSnapshot doc) {
    return EventPost(
      eventId: doc['eventId'],
      eventTitle: doc['eventTitle'],
      eventDesc: doc['eventDescription'],
      eventTime: doc['eventTime'],
      eventDate: doc['eventDate'],
      department: doc['department'],
      mediaUrl: doc['mediaUrl'],
      contact: doc['contact'],
      timeStamp: doc['timeStamp'],
      likes: doc['likes'],
      ownerId: doc['ownerId'],
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
        likes: this.likes,
        likeCount: getLikesCount(this.likes),
      );
}

class _EventPostState extends State<EventPost> {
  final String eventTitle;
  final String ownerId;
  final String eventDesc;
  final String eventDate;
  final String eventTime;
  final String dept;
  final String contact;
  final String mediaUrl;
  final String eventId;
  final Timestamp timeStamp;

  Map likes;
  int likeCount;

  _EventPostState({
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
        return GestureDetector(
          onTap: () {
            print("Event Clicked");
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
            ),
            height: 300,
            child: Stack(
              children: <Widget>[
                Image.network(
                  mediaUrl,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  right: 0.0,
                  bottom: 0.0,
                  child: Container(
                    child: Text('$eventDate'),
                  ),
                ),
                Positioned(
                  left: 10,
                  bottom: 0.0,
                  child: Container(
                    child: Text('$eventTitle'),
                  ),
                ),
              ],
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

//Column(
//children: <Widget>[
//Container(
//height: 300,
//width: MediaQuery.of(context).size.width,
//child: Image.asset(
//mediaUrl,
//fit: BoxFit.cover,
//),
//),
//Text(eventTitle),
//Row(
//children: <Widget>[
//Column(
//children: <Widget>[
//Text('Time'),
//Text(eventTime),
//],
//),
//Column(
//children: <Widget>[
//Text('Date'),
//Text(eventDate),
//],
//),
//],
//),
//Divider(),
//Container(
//child: Text(
//eventDesc,
//overflow: TextOverflow.ellipsis,
//),
//),
//Text('Department Venue '),
//Text(
//eventDesc,
//overflow: TextOverflow.ellipsis,
//),
//],
//),
