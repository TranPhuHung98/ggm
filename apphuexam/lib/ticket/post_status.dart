import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stdio/ticket/post_onpress.dart';

class PostStatus extends StatefulWidget {
  String groupId;
  String groupName;
  FirebaseUser user;
  PostStatus({Key key, this.groupId, this.groupName, this.user})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PostStatusState();
  }
}

class PostStatusState extends State<PostStatus> {
  TextEditingController _textTextController = new TextEditingController();
  Post post = Post();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: Text(widget.groupName),
        ),
        body: new ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: new Card(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      child: Container(
                        margin: EdgeInsets.only(
                            right: 5.0, left: 5.0, bottom: 20.0,top: 10.0),
                        child: new Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(5.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: 50.0,
                                    child: Column(
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              widget.user.photoUrl,
                                            ),
                                          radius: 15.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 20.0,
                                  ),
                                  Flexible(
                                    child: TextField(
                                      maxLines: null,
                                      keyboardType: TextInputType.multiline,
                                      controller: _textTextController,
                                      decoration: InputDecoration.collapsed(
                                        hintText: 'What do you think?',
                                        // counterStyle: TextStyle(fontSize: 10.0),
                                        // contentPadding: EdgeInsets.fromLTRB(
                                        //     20.0, 10.0, 20.0, 10.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 30.0,
                            ),
                            Divider(
                              height: 10.0,
                            ),
                            new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 30.0,
                                    margin: EdgeInsets.only(
                                        left: 5.0,
                                        right: 5.0,
                                        bottom: 5.0,
                                        top: 5.0),
                                    child: Material(
                                        child: MaterialButton(
                                          minWidth: 20.0,
                                          padding: EdgeInsets.only(
                                            left: 80.0,
                                            right: 80.0,
                                          ),
                                          color: Colors.blueAccent,
                                          child: Text(
                                            'Post',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10.0),
                                          ),
                                          onPressed: () {
                                            post.onPost(
                                                _textTextController.text,
                                                widget.groupId);
                                            _textTextController.clear();
                                            if (_textTextController != '')
                                              showDialog(
                                                  context: context,
                                                  child: AlertDialog(
                                                    content: Text('Done'),
                                                    actions: <Widget>[
                                                      new FlatButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              new Text("Ok")),
                                                    ],
                                                  ));
                                          },
                                        ),
                                        shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(
                                                    15.0))),
                                  ),
                                ])
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ],
        ));
  }
}
