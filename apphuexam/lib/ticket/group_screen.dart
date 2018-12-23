import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:stdio/chat/chat_screen.dart';
import 'package:stdio/edit_group_screen.dart';
import 'package:stdio/ticket/post_model.dart';
import 'package:stdio/ticket/post_status.dart';

class GroupScreen extends StatefulWidget {
  String groupId;
  String groupName;
  String groupAvatar;
  FirebaseUser user;
  GroupScreen({Key key, this.groupId, this.groupName, this.user,this.groupAvatar})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return GroupScreenState();
  }
}

class GroupScreenState extends State<GroupScreen> {
  final TextEditingController _textEditingController =
      new TextEditingController();
  Widget listPost() {
    return new FirebaseAnimatedList(
      query: FirebaseDatabase.instance
          .reference()
          .child('Group')
          .child('${widget.groupId}')
          .child('post'),
      padding: const EdgeInsets.all(8.0),
      reverse: true,
      sort: (a, b) => b.key.compareTo(a.key),
      itemBuilder: (_, DataSnapshot dataSnapshot, Animation<double> animation,
          int index) {
        return PostModel(
          dataSnaphot: dataSnapshot,
          animation: animation,
          groupId: widget.groupId,
          groupName: widget.groupName,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var listPost = FirebaseDatabase.instance
        .reference()
        .child('Group')
        .child('${widget.groupId}')
        .child('post');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupName),
        centerTitle: false,
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => SettingGrpScreen(
                      grpName: widget.groupName,
                      grpAvatar: widget.groupAvatar,
                      grpId: widget.groupId,
                    ))),
          ),
          IconButton(
            icon: Icon(Icons.chat),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => ChatScreen(
                        groupName: widget.groupName,
                        user: widget.user,
                        groupId: widget.groupId,
                      )));
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 9,
              child: new FirebaseAnimatedList(
                query: listPost,
                padding: const EdgeInsets.all(8.0),
                reverse: false,
                sort: (a, b) => b.key.compareTo(a.key),
                itemBuilder: (_, DataSnapshot dataSnapshot,
                    Animation<double> animation, int index) {
                  return PostModel(
                    dataSnaphot: dataSnapshot,
                    animation: animation,
                    groupName: widget.groupName,
                    groupId: widget.groupId,
                  );
                },
              ),
            )
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
              child: Text('Post Status'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => PostStatus(
                          groupId: widget.groupId,
                          groupName: widget.groupName,
                          user: widget.user,
                        )));
              },
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15.0))),
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}
