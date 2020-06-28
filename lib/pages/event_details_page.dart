import 'package:ausocial/constants.dart';
import 'package:ausocial/widgets/fancy_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: FancyButton(
                color: Color(primaryBlue),
                label: 'Contact',
                onPress: () {},
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      mediaUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: paddingInDetailPage,
                      top: paddingInDetailPage,
                    ),
                    child: Text(
                      eventTitle,
                      style: GoogleFonts.quicksand(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                      left: 15.0,
                      right: 30,
                      bottom: 20.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Time',
                              style: GoogleFonts.quicksand(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                eventTime,
                                style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Date',
                              style: GoogleFonts.quicksand(
                                color: Colors.grey[500],
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                eventDate,
                                style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                      left: paddingInDetailPage,
                    ),
                    child: Container(
                      child: Text(
                        eventDesc,
                        style: GoogleFonts.quicksand(
                          fontSize: 16,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 6,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: paddingInDetailPage,
                      top: 20.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Department Venue ',
                          style: GoogleFonts.quicksand(
                            color: Colors.grey[500],
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            department,
                            style: GoogleFonts.quicksand(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
