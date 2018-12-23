import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stdio/home/home_screen.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  @override
  bool isLoggedIn = false;
  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    this.setState(() {
      isLoading = true;
    });
    isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn) {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      FirebaseUser firebaseUser = await _auth.currentUser();
            Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => HomeScreen(user: firebaseUser)));
    
    }

    this.setState(() {
      isLoading = false;
    });
  }

  String changeString(String email) {
    String em = email ;
     for(int i =0 ; i < em.length; i ++ )
      if(em[i] == '.')
        em = em.replaceRange(i,i+1, '_');
    return em;
  }

  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences prefs;

  bool isLoading = false;

  Future<FirebaseUser> _handleSignIn() async {
    setState(() {
      isLoading = true;
    });
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user = await firebaseAuth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    prefs = await SharedPreferences.getInstance();
    if (user != null) {
      FirebaseDatabase.instance
          .reference()
          .child('Users')
          .child(changeString(user.email))
          .once()
          .then((DataSnapshot snapshot) {
        if (snapshot.value == null)
          FirebaseDatabase.instance
              .reference()
              .child("Users")
              .child(changeString(user.email))
              .set({
            "name": user.displayName,
            "avatar": user.photoUrl,
            "email": user.email,
          });
      });
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => HomeScreen(user: user)));
    } else {
      setState(() {
        isLoading = false;
      });
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Login"),
          centerTitle: true,
        ),
        body: new Stack(
          children: <Widget>[
            new Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Image.asset('images/image3.jpg', fit: BoxFit.contain),
                    Container(
                      height: 50.0
                    ),
                    Column(
                      children: <Widget>[
                    Container(
                      child: Material(
                        child: RaisedButton(
                            padding: EdgeInsets.only(
                                left: 60.0, right: 60.0, top: 0.0, bottom: 0.0),
                            color: Colors.red,
                            child: Text(
                              'Sign in with Google',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15.0),
                            ),
                            onPressed: () {
                              _handleSignIn();
                            },
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(15.0))),
                      ),
                    ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              child: isLoading
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.grey),
                        ),
                      ),
                      color: Colors.white.withOpacity(0.8),
                    )
                  : Container(),
            ),
          ],
        ));
  }
}
