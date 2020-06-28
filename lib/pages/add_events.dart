import 'dart:io';
import 'package:date_time_format/date_time_format.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as Im;
import 'package:ausocial/constants.dart';
import 'package:ausocial/models/users.dart';
import 'package:ausocial/pages/home.dart';
import 'package:ausocial/widgets/fancy_button.dart';
import 'package:ausocial/widgets/progress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class AddEvents extends StatefulWidget {
  final User currentUser;
  AddEvents({this.currentUser});
  @override
  _AddEventsState createState() => _AddEventsState();
}

class _AddEventsState extends State<AddEvents> {
  bool isUploading = false;
  String eventId = Uuid().v4();
  DateTime eventDate;
  TimeOfDay eventTime;
  File file;
  PickedFile pFile;
  final _picker = ImagePicker();
  String selectedDepartment = 'Information Science and Technology';
  String eventTitle, eventDescription, contactInfo, sEventDate, sEventTime;
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

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay selectedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
    if (selectedTime != null) {
      setState(() {
        eventTime = selectedTime;
        sEventTime = eventTime.toString();
        sEventTime = sEventTime.substring(10, 15);
      });
      print('Event Time: $eventTime');
    }
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (picked != null && picked != eventDate)
      setState(() {
        eventDate = picked;
      });
    print('Event Date: ${DateTimeFormat.format(picked, format: 'j M')}');
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

  handleTakePhoto() async {
    Navigator.pop(context);
    PickedFile pFile = await _picker.getImage(
      source: ImageSource.camera,
      maxHeight: 675,
      maxWidth: 960,
    );
    setState(() {
      this.pFile = pFile;
      this.file = File(pFile.path);
    });
  }

  handleChooseFromGallery() async {
    Navigator.pop(context);
    PickedFile pFile = await _picker.getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      this.pFile = pFile;
      this.file = File(pFile.path);
    });
  }

  selectImage(parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: Text('Create Post'),
            children: <Widget>[
              SimpleDialogOption(
                child: Text('Photo with Camera'),
                onPressed: handleTakePhoto,
              ),
              SimpleDialogOption(
                child: Text('Image from Gallery'),
                onPressed: handleChooseFromGallery,
              ),
              SimpleDialogOption(
                child: Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  compressImage() async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    Im.Image imageFile = Im.decodeImage(file.readAsBytesSync());
    final compressedImageFile = File('$path/img_$eventId.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile, quality: 85));
    setState(() {
      file = compressedImageFile;
    });
  }

  createPostInFirestore(
      {String eventTitle,
      String eventDesc,
      DateTime eventDate,
      String eventTime,
      String dept,
      String contact,
      String mediaUrl}) {
    eventRef.document(widget.currentUser.id).setData({
      "eventId": eventId,
      "ownerId": widget.currentUser.id,
      "username": widget.currentUser.username,
      "mediaUrl": mediaUrl,
      "eventTitle": eventTitle,
      "eventDescription": eventDesc,
      "eventDate": eventDate,
      "eventTime": eventTime,
      "department": dept,
      "contact": contact,
      "timeStamp": timeStamp,
      "likes": {},
    });
    setState(() {
      file = null;
      isUploading = false;
    });
    Navigator.pop(context);
  }

  handleSubmit() async {
    setState(() {
      isUploading = true;
    });
    await compressImage();
    String mediaUrl = await uploadImage(file);
    createPostInFirestore(
      eventTitle: eventTitle,
      eventDesc: eventDescription,
      eventDate: eventDate,
      eventTime: sEventTime,
      dept: selectedDepartment,
      mediaUrl: mediaUrl,
      contact: contactInfo,
    );
  }

  Future<String> uploadImage(imageFile) async {
    StorageUploadTask uploadTask =
        storageRef.child('event_$eventId.jpg').putFile(imageFile);
    StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    String downloadUrl = await storageSnap.ref.getDownloadURL();
    return downloadUrl;
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
                    'Hello, \n${widget.currentUser.displayName}',
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
                        image: CachedNetworkImageProvider(
                          currentUser.photoUrl,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            isUploading
                ? linearProgress()
                : SizedBox(
                    height: 1,
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
                                  color: Colors.blue.withOpacity(0.1),
                                  border: Border.all(
                                    width: 0.5,
                                    color: Colors.lightBlue,
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
                                  color: Colors.blue.withOpacity(0.1),
                                  border: Border.all(
                                    width: 0.5,
                                    color: Colors.lightBlue,
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
                                title: eventDate == null
                                    ? 'Select a date'
                                    : '${DateTimeFormat.format(
                                        eventDate,
                                        format: 'j M',
                                      )}',
                                onTapFunc: () => _selectDate(context),
                                icon: FontAwesome.calendar_plus_o,
                              ),
                              buildSelectionContainer(
                                  title: eventTime == null
                                      ? 'Select Time'
                                      : '$sEventTime',
                                  onTapFunc: () => _selectTime(context),
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
                                    color: Colors.blue.withOpacity(0.1),
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
                                color: Colors.blue.withOpacity(0.1),
                                border: Border.all(
                                  width: 0.5,
                                  color: Colors.lightBlue,
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
                                  onChanged: (val) {
                                    setState(() {
                                      contactInfo = val;
                                    });
                                  },
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: paddingLeft, top: 15.0),
                                child: GestureDetector(
                                  onTap: () => selectImage(context),
                                  child: Container(
                                    height: 50.0,
                                    width: 150.0,
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Feather.image,
                                          color: Color(primaryBlue),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        file == null
                                            ? Text(
                                                'Add Image',
                                                style: GoogleFonts.abel(
                                                  fontSize: 20.0,
                                                  color: Color(primaryBlue),
                                                ),
                                              )
                                            : Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: FileImage(file),
                                                  ),
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 80.0),
                            child: FancyButton(
                              label: 'Done',
                              color: Color(primaryBlue),
                              onPress:
                                  isUploading ? null : () => handleSubmit(),
                            ),
                          )
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
            color: Colors.blue.withOpacity(0.1),
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
