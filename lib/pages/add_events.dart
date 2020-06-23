import 'package:ausocial/constants.dart';
import 'package:ausocial/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class AddEvents extends StatefulWidget {
  @override
  _AddEventsState createState() => _AddEventsState();
}

class _AddEventsState extends State<AddEvents> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Hello, \n${googleSignIn.currentUser.displayName}',
                    style: GoogleFonts.abel(
                      fontSize: 25.0,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 40,
                    height: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image(
                        image: NetworkImage(
                          '${googleSignIn.currentUser.photoUrl}',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      containerBoxShadow,
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                height: 5.0,
                                width: 100.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Center(
                              child: Text(
                                'Create an Event',
                                style: GoogleFonts.abel(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(primaryBlue),
                                ),
                              ),
                            ),
                          ),
                          FormTitles(title: 'Event Title'),
                          buildFormInput(
                            lines: 1,
                            height: 50.0,
                          ),
                          FormTitles(
                            title: 'Event Description',
                          ),
                          buildFormInput(
                            lines: 6,
                            height: 125.0,
                          ),
                          FormTitles(title: 'Choose date & time'),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: paddingLeft, top: 15.0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 50.0,
                                    width: 150.0,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          FontAwesome.calendar_plus_o,
                                          color: Color(primaryBlue),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          'Select a date',
                                          style: GoogleFonts.abel(
                                            fontSize: 20.0,
                                            color: Color(primaryBlue),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: paddingLeft, top: 15.0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 50.0,
                                    width: 150.0,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          MaterialIcons.access_time,
                                          color: Color(primaryBlue),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          'Select Time',
                                          style: GoogleFonts.abel(
                                            fontSize: 20.0,
                                            color: Color(primaryBlue),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Form buildFormInput({int lines, double height}) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.grey.withOpacity(0.1),
            border: Border.all(
              width: 0.5,
              color: Colors.grey,
            ),
          ),
          width: 350,
          height: height,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: TextFormField(
              maxLines: lines,
              style: GoogleFonts.abel(fontSize: 20.0),
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
        ),
      ),
    );
  }
}

class FormTitles extends StatelessWidget {
  final String title;
  FormTitles({@required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: paddingLeft, top: 30),
      child: Row(
        children: <Widget>[
          Text(
            '$title',
            style: GoogleFonts.abel(
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}
