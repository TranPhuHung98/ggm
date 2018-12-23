import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stdio/home/add_group.dart';
import 'package:stdio/home/add_group_dialog.dart';
import 'package:stdio/home/group_item.dart';
import 'package:stdio/login/login_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.user}) : super(key: key);
  FirebaseUser user;
  @override
  HomeScreenState createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
     String changeString(String email) {
    String em = email ;
     for(int i =0 ; i < em.length; i ++ )
      if(em[i] == '.')
        em = em.replaceRange(i,i+1, '_');
    return em;
  }

  AddGroup addGroup = AddGroup();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<Null> handleSignOut() async {
    await FirebaseAuth.instance.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Home'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              handleSignOut();
            },
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top:10.0),
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: FirebaseAnimatedList(
                        query: FirebaseDatabase.instance
                            .reference()
                            .child('Users')
                            .child(changeString(widget.user.email))
                            .child('JoinedGroup'),
                        itemBuilder: (BuildContext context,
                            DataSnapshot groupSnapshot,
                            Animation<double> animation,
                            int index) {
                          return GroupItem(
                            avatar: groupSnapshot.value['avatar'],
                            groupName: groupSnapshot.value['groupName'],
                            groupId: groupSnapshot.key,
                            user: widget.user,
                          );
                        })),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 35.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Material(
          child: RaisedButton(
              color: Colors.blueAccent[100],
              child: Text('Create Group'),
              onPressed: () {
                _openAddItemDialog(context);
              },
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15.0))),
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }

  _openAddItemDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AddGroupDialog(
              user: widget.user,
            ));
  }
}
