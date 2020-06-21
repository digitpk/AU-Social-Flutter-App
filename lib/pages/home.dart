import 'package:ausocial/constants.dart';
import 'package:ausocial/pages/events.dart';
import 'package:ausocial/pages/explore.dart';
import 'package:ausocial/pages/stories.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    googleSignIn.onCurrentUserChanged.listen(
      (account) {
        handleSignIn(account);
      },
      onError: (err) {
        print('Error Signing in: $err');
      },
    );

    //Re authenticate user when app is opened
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
    }).catchError((error) {
      print(error);
    });
  }

  void handleSignIn(GoogleSignInAccount account) {
    if (account != null) {
      print('User signed in : $account');
      setState(() {
        isAuth = true;
      });
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }

  void login() {
    googleSignIn.signIn();
  }

  void logout() {
    googleSignIn.signOut();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.jumpToPage(pageIndex);
  }

  Scaffold buildAuthScreen() {
    return Scaffold(
      body: PageView(
        children: <Widget>[EventsPage(), ExplorePage(), StoriesPage()],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        backgroundColor: Color(primaryBlack),
        activeColor: Color(primaryGreen),
        inactiveColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 35.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
          ),
        ],
      ),
    );
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
