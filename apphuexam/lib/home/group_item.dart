import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stdio/ticket/group_screen.dart';

class GroupItem extends StatefulWidget {
  String avatar;
  String groupName;
  String groupId;
  FirebaseUser user;
  GroupItem({Key key, this.avatar, this.groupName, this.user, this.groupId})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _GroupItemState();
  }
}

class _GroupItemState extends State<GroupItem> {
  Widget buildItem(BuildContext context) {
    return widget.groupName== null ? Container():Column(
      children: <Widget>[        
        FlatButton(
          child: Row(
            children: <Widget>[
              Container(
                child: Material(
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.avatar,
                    ),
                  ),
                  ),
                ),
              ),
              Container(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(widget.groupName,
                        style:
                            TextStyle(color: Colors.blueGrey, fontSize: 17.0)),
                  ],
                ),
              ),
            ],
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => GroupScreen(groupId: widget.groupId,groupName: widget.groupName,user: widget.user,)));
          },
        ),
        Divider(
          height: 30.0,
          color: Colors.grey,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildItem(context);
  }
}
