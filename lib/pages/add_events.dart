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
  String selectedDepartment = 'Information Science and Technology';
  String eventTitle, eventDescription;
  List<DropdownMenuItem> getDropDownList() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (int i = 0; i < departments.length; i++) {
      String department = departments[i];
      var newItem = DropdownMenuItem(
        child: Text(department),
        value: department,
      );
      dropDownItems.add(newItem);
    }
    return dropDownItems;
  }

  saveEventTitles(val) {
    setState(() {
      eventTitle = val;
    });
    print(eventTitle);
  }

  saveEventDescription(val) {
    setState(() {
      eventDescription = val;
    });
    print(eventDescription);
  }

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
                      height: 1000,
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
                          Form(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 15.0,
                                left: 20.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    15.0,
                                  ),
                                  color: Colors.grey.withOpacity(0.1),
                                  border: Border.all(
                                    width: 0.5,
                                    color: Colors.grey,
                                  ),
                                ),
                                width: 350,
                                height: 50,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15.0,
                                  ),
                                  child: TextFormField(
                                    onChanged: (val) {
                                      saveEventTitles(val);
                                    },
                                    maxLines: 1,
                                    style: GoogleFonts.abel(
                                      fontSize: 20.0,
                                    ),
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          FormTitles(
                            title: 'Event Description',
                          ),
                          Form(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 15.0,
                                left: 20.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    15.0,
                                  ),
                                  color: Colors.grey.withOpacity(0.1),
                                  border: Border.all(
                                    width: 0.5,
                                    color: Colors.grey,
                                  ),
                                ),
                                width: 350,
                                height: 125,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15.0,
                                  ),
                                  child: TextFormField(
                                    onChanged: (val) {
                                      saveEventDescription(val);
                                    },
                                    maxLines: 6,
                                    style: GoogleFonts.abel(
                                      fontSize: 20.0,
                                    ),
                                    decoration: InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          FormTitles(title: 'Choose date & time'),
                          Row(
                            children: <Widget>[
                              buildSelectionContainer(
                                title: 'Select a date',
                                onTapFunc: () {},
                                icon: FontAwesome.calendar_plus_o,
                              ),
                              buildSelectionContainer(
                                  title: 'Select Time',
                                  onTapFunc: () {},
                                  icon: MaterialIcons.access_time),
                            ],
                          ),
                          FormTitles(title: 'Choose Department Venue'),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 40.0,
                                  top: 15.0,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        style: GoogleFonts.abel(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                        ),
                                        value: selectedDepartment,
                                        items: getDropDownList(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedDepartment = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          FormTitles(title: 'Contact Info'),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 15.0,
                              left: 20.0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  15.0,
                                ),
                                color: Colors.grey.withOpacity(0.1),
                                border: Border.all(
                                  width: 0.5,
                                  color: Colors.grey,
                                ),
                              ),
                              width: 350,
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 15.0,
                                ),
                                child: TextFormField(
                                  keyboardType:
                                      TextInputType.numberWithOptions(),
                                  onChanged: (val) {},
                                  maxLines: 1,
                                  style: GoogleFonts.abel(
                                    fontSize: 20.0,
                                  ),
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                ),
                              ),
                            ),
                          ),
                          FormTitles(title: 'Choose Event Image'),
                          Row(
                            children: <Widget>[
                              buildSelectionContainer(
                                title: 'Add Image',
                                icon: Feather.image,
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

  Padding buildSelectionContainer(
      {String title, IconData icon, Function onTapFunc}) {
    return Padding(
      padding: const EdgeInsets.only(left: paddingLeft, top: 15.0),
      child: GestureDetector(
        onTap: onTapFunc,
        child: Container(
          height: 50.0,
          width: 150.0,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                color: Color(primaryBlue),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                '$title',
                style: GoogleFonts.abel(
                  fontSize: 20.0,
                  color: Color(primaryBlue),
                ),
              ),
            ],
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
