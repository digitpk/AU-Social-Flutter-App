import 'package:ausocial/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateUserAccount extends StatefulWidget {
  @override
  _CreateUserAccountState createState() => _CreateUserAccountState();
}

class _CreateUserAccountState extends State<CreateUserAccount> {
  String username;

  submit() {
    Navigator.pop(context, username);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/homeBG.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: Center(
                  child: Text(
                    'Create your UserName',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Sriracha',
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
//              Padding(
//                padding: const EdgeInsets.all(16.0),
//                child: Center(
//                  child: Container(
//                    child: Form(
//                      key: _formKey,
//                      child: TextFormField(
//                        style: TextStyle(color: Colors.white),
//                        onSaved: (val) => username = val,
//                        decoration: InputDecoration(
//                          border: OutlineInputBorder(),
//                          labelText: 'UserName',
//                          labelStyle: TextStyle(
//                            color: Color(primaryBlue),
//                            fontSize: 15.0,
//                            fontFamily: 'Sriracha',
//                          ),
//                          hintText: "Must be atleast 3 characters",
//                          hintStyle: TextStyle(color: Color(primaryBlue)),
//                        ),
//                      ),
//                    ),
//                  ),
//                ),
//              ),
              Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 15.0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(primaryBlue),
                      width: 2,
                    ),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        username = value;
                      });
                    },
                    style: GoogleFonts.abel(fontSize: 20),
                    textAlign: TextAlign.justify,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.person,
                        color: Color(primaryBlue),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: submit,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(primaryBlue),
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    height: 50.0,
                    width: 300,
                    child: Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Sriracha',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
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
  }
}
