import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stdio/chat/add_user.dart';
import 'package:stdio/chat/dialog.dart';

class BuildItem extends StatefulWidget {
  DataSnapshot dataSnapshot;
  Animation animation;
  String groupId;
  String groupName;
  BuildItem(
      {Key key,
      this.dataSnapshot,
      this.animation,
      this.groupId,
      this.groupName});
  @override
  State<StatefulWidget> createState() {
    return _BuildItemState();
  }
}

class _BuildItemState extends State<BuildItem> {
  String changeString(String email) {
    String em = email.replaceRange(email.length - 4, email.length - 3, '_');
    return em;
  }

  AddUser addUser = AddUser();
  final googleSignIn = new GoogleSignIn();
  Widget buildItem(BuildContext context) {
    return Container(
      height: 70.0,
      decoration: BoxDecoration(border: Border.all(color: Colors.grey[200])),
      child: Center(
        child: ListTile(
          title: Text('${widget.dataSnapshot.value['name']}'),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.dataSnapshot.value['avatar']),
          ),
          subtitle: Text('${widget.dataSnapshot.value['email']}'),
          onTap: () {
            dialogAddUser(context);
          },
        ),
      ),
    );
  }

  Future<bool> dialogAddUser(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Do you want to add this user ?'),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    bool isJoined = true;
                    addUser.onAddUser(widget.dataSnapshot.value['email'],
                        widget.groupId, widget.groupName, isJoined);

                    showDialog(
                        context: context,
                        child: AddItemDialog(
                            message: isJoined
                                ? 'This user is joined group'
                                : 'Success'));
                  },
                  child: Text('Yes')),
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('No')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return buildItem(context);
  }
}
