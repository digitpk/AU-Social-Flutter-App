import 'package:ausocial/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventDetailsPage extends StatelessWidget {
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

  EventDetailsPage({
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              mediaUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: paddingInDetailPage,
            ),
            child: Text(eventTitle),
          ),
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('Time'),
                  Text(eventTime),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('Date'),
                  Text(eventDate),
                ],
              ),
            ],
          ),
          Divider(),
          Container(
            child: Text(
              eventDesc,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text('Department Venue '),
          Text(
            department,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
