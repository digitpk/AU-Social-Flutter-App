import 'package:ausocial/constants.dart';
import 'package:ausocial/widgets/fancy_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class EventDetailsPage extends StatefulWidget {
  final String eventTitle;
  final String eventDesc;
  final DateTime eventDate;
  final DateTime eventTime;
  final String eventWebsite;
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
    this.eventWebsite,
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
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  final CallsAndMessagesService _service = locator<CallsAndMessagesService>();
  void initState() {
    super.initState();
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  share(BuildContext context) {
    final RenderBox box = context.findRenderObject();
    Share.share(
      '\n To Checkout more events like this install Sociau App\n\n'
      '${widget.eventTitle}\n ${widget.eventDesc}\n On ${DateTimeFormat.format(widget.eventDate, format: 'jS M \'y')} ,'
      ' ${DateTimeFormat.format(widget.eventTime, format: 'H:i a')},\n Contact : ${widget.contact} \n Website : '
      '${widget.eventWebsite}  ',
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20.0,
              ),
              child: FancyButton(
                color: Color(primaryBlue),
                label: 'Contact',
                onPress: () => _service.call(widget.contact),
              ),
            ),
            widget.eventWebsite == null
                ? SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(bottom: 20.0, left: 30),
                    child: FancyButton(
                      color: Color(primaryBlue),
                      label: 'Website',
                      onPress: () => _launchInBrowser(
                        widget.eventWebsite,
                      ),
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
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      widget.mediaUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: paddingInDetailPage,
                      top: paddingInDetailPage,
                    ),
                    child: Text(
                      widget.eventTitle,
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
                                '${DateTimeFormat.format(widget.eventTime, format: 'h:i a')}',
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
                                '${DateTimeFormat.format(widget.eventDate, format: 'j M, Y')}',
                                style: GoogleFonts.quicksand(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => share(
                            context,
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(FontAwesome.share_square_o),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Share',
                                style: GoogleFonts.quicksand(
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
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
                        widget.eventDesc,
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
                            widget.department,
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
