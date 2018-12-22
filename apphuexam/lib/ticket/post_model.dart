import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:stdio/ticket/post_detail.dart';

class PostModel extends StatefulWidget {
  DataSnapshot dataSnaphot;
  Animation animation;
  String groupId;
  String groupName;
  PostModel(
      {Key key, this.dataSnaphot, this.animation, this.groupId, this.groupName})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return PostModelState();
  }
}

class PostModelState extends State<PostModel> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Container(
          child: ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => PostDetail(
                        dataSnapshot: widget.dataSnaphot,
                        animation: widget.animation,
                        groupName: widget.groupName,
                        groupId: widget.groupId,
                      )));
            },
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage(widget.dataSnaphot.value['senderPhotoUrl']),
            ),
            title: Text(
              widget.dataSnaphot.value['senderName'],
              style: TextStyle(color: Colors.black),
            ),
            subtitle: widget.dataSnaphot.value['content'].length <= 100
                ? Text(
                    '${widget.dataSnaphot.value['timePost']}\n${widget.dataSnaphot.value['content']}')
                : Text(
                    '${widget.dataSnaphot.value['timePost']}\n${widget.dataSnaphot.value['content'].substring(1, 100)}...'),
          ),
          height: 80.0,
        ),
        Divider(
          height: 10.0,
        ),
        Container(
          height: 10.0,
        )
      ],
    );
  }
}
