import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventDetailsPage extends StatefulWidget {
  final String eventTitle;
  final String eventDesc;
  final String eventDate;
  final String eventTime;
  final String department;
  final String contact;
  final String mediaUrl;
  final String eventId;
  final String timeStamp;
  final dynamic likes;

  EventDetailsPage(
      {this.eventId,
      this.timeStamp,
      this.eventTitle,
      this.eventDesc,
      this.eventDate,
      this.eventTime,
      this.department,
      this.contact,
      this.mediaUrl,
      this.likes});

  factory EventDetailsPage.fromDocument(DocumentSnapshot doc) {
    return EventDetailsPage(
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
    return count;
  }

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState(
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

class _EventDetailsPageState extends State<EventDetailsPage> {
  final String eventTitle;
  final String eventDesc;
  final String eventDate;
  final String eventTime;
  final String dept;
  final String contact;
  final String mediaUrl;
  final String eventId;
  final String timeStamp;
  Map likes;
  int likeCount;

  _EventDetailsPageState(
      {this.eventId,
      this.timeStamp,
      this.eventTitle,
      this.eventDesc,
      this.eventDate,
      this.eventTime,
      this.dept,
      this.contact,
      this.mediaUrl,
      this.likes,
      this.likeCount});
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
