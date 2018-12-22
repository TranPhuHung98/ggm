import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stdio/home/home_screen.dart';
import 'package:stdio/login/login_screen.dart';
import 'package:stdio/theme.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  FirebaseUser user;
  bool isLogin = false;
  void _keepLogin() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await _auth.currentUser();
    print(firebaseUser);
    if (firebaseUser != null)
      setState(() {
        isLogin = true;
        user = firebaseUser;
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _keepLogin();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Demo',
      // theme: new ThemeData(
      //   primaryColor: themeColor,
      // ),
      // home: isLogin ? HomeScreen(user: user,): LoginScreen(),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
