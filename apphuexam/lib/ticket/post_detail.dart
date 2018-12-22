import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stdio/ticket/comment_onpress.dart';
import 'package:stdio/ticket/list_comment.dart';

class PostDetail extends StatefulWidget {
  String groupName;
  String groupId;
  DataSnapshot dataSnapshot;
  Animation animation;
  PostDetail(
      {Key key,
      this.dataSnapshot,
      this.animation,
      this.groupName,
      this.groupId})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PostDetailState();
  }
}

class PostDetailState extends State<PostDetail> {
  final TextEditingController _textEditingController =
      new TextEditingController();
  Comment postComment = Comment();
  File imageFile;
  String imageUrl;
  bool isLoading = false;
  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        imageFile = image;
        isLoading = true;
      });
    }
    await uploadFile();
  }

  Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference =
        FirebaseStorage.instance.ref().child(fileName);
    reference.putFile(imageFile).onComplete.then((_) {
      reference.getDownloadURL().then((dynamic value) {
        imageUrl = value.toString();
        setState(() {
          isLoading = false;
        });

        postComment.onComment(
            0, widget.groupId, widget.dataSnapshot.key, imageUrl);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.groupName),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Card(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(right: 5.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            widget.dataSnapshot.value['senderPhotoUrl']),
                      )),
                  Container(
                    child: Text(
                      '${widget.dataSnapshot.value['senderName']}\n${widget.dataSnapshot.value['timePost']}',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    padding: EdgeInsets.fromLTRB(5.0, 10.0, 15.0, 10.0),
                    margin: EdgeInsets.only(left: 10.0),
                  ),
                ],
              ),
              Divider(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        '''${widget.dataSnapshot.value['content']}''',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 20.0,
              ),
              Divider(
                height: 10.0,
              ),
              Container(
                height: 20.0,
              ),
              new Flexible(
                child: new FirebaseAnimatedList(
                  query: FirebaseDatabase.instance
                      .reference()
                      .child('Group')
                      .child('${widget.groupId}')
                      .child('post')
                      .child(widget.dataSnapshot.key)
                      .child('commment'),
                  padding: const EdgeInsets.all(8.0),
                  reverse: true,
                  sort: (a, b) => b.key.compareTo(a.key),
                  itemBuilder: (_, DataSnapshot dataSnapshotcm,
                      Animation<double> animation, int index) {
                    return CommentItem(
                        dataSnapshot: dataSnapshotcm, animation: animation);
                    // return Container();
                  },
                ),
              ),
              new Divider(height: 1.0),
              new Container(
                decoration:
                    new BoxDecoration(color: Theme.of(context).cardColor),
                child: _buildTextComposer(),
              ),
            ],
          ),
        ));
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: new Row(
        children: <Widget>[
          new Container(
            margin: new EdgeInsets.symmetric(horizontal: 4.0),
            child: new IconButton(
                icon: new Icon(
                  Icons.photo_camera,
                  color: Theme.of(context).accentColor,
                ),
                onPressed: () async {
                  getImage();
                }),
          ),
          new Flexible(
            child: new TextField(
              controller: _textEditingController,
              decoration: new InputDecoration.collapsed(
                  hintText: "Type your comment..."),
            ),
          ),
          new Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: () {
                    postComment.onComment(1, widget.groupId,
                        widget.dataSnapshot.key, _textEditingController.text);
                    _textEditingController.clear();
                  })),
        ],
      ),
    );
  }
}
