import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:stdio/see_image.dart';

class CommentItem extends StatefulWidget {
  DataSnapshot dataSnapshot;
  Animation animation;
  CommentItem({Key key, this.dataSnapshot, this.animation}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CommentItemState();
  }
}

class CommentItemState extends State<CommentItem> {
  _commentItem(DataSnapshot dataSnapshot, Animation animation) {
    return Row(
      children: <Widget>[
        Container(
            height: 25.0,
            width: 25.0,
            margin: const EdgeInsets.only(right: 5.0),
            child: CircleAvatar(
              backgroundImage:
                  NetworkImage(dataSnapshot.value['senderPhotoUrl']),
            )),
        // Container(
        //   margin: EdgeInsets.all(5.0),
        //   child:Text('${widget.dataSnapshot.value['timePost']}',style: TextStyle(fontWeight: FontWeight.bold),),
        // ),
        dataSnapshot.value['type'] == 1
            ? Flexible(
                child: Container(
                child: Text(
                  dataSnapshot.value['content'],
                  style: TextStyle(color: Colors.black),
                ),
                padding: EdgeInsets.only(
                    left: 20.0, right: 15.0, bottom: 10.0, top: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.grey[50]),
                margin: EdgeInsets.all(5.0),
              ))
            : Container(
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => WatchImageScreen(
                                  url: dataSnapshot.value['content'],
                                )));
                  },
                    child: Image.network(
                  dataSnapshot.value['content'],
                  fit: BoxFit.cover,
                )),
                height: 200.0,
                width: 200.0,
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _commentItem(widget.dataSnapshot, widget.animation),
      margin: EdgeInsets.only(left: 10.0, top: 5.0),
    );
  }
}
