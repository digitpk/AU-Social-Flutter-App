import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;

  @override
  void initState() {
    super.initState();
    googleSignIn.onCurrentUserChanged.listen((account) {
      if (account != null) {
        setState(() {
          isAuth = true;
        });
      } else {
        isAuth = false;
      }
    });
  }

  void login() {
    googleSignIn.signIn();
  }

  Widget buildAuthScreen() {
    return Text('Authenticated');
  }

  Widget buildUnAuthScreen() {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/homeBG.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 300.0, bottom: 200.0),
                  child: Center(
                    child: Text(
                      'SOCIAU',
                      style: TextStyle(
                        fontFamily: 'Heaters',
                        fontSize: 100,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.black12,
                  child: Ink(
                    width: 300,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Color(0xff6894bc),
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30.0),
                      onTap: login,
                      splashColor: Color(0xff6894bc),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Image(
                            image: AssetImage('assets/images/googleicon.png'),
                            width: 50.0,
                          ),
                          SizedBox(
                            width: 50.0,
                          ),
                          Text(
                            'Sign in with Google',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28.0,
                              fontFamily: 'Heaters',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}
