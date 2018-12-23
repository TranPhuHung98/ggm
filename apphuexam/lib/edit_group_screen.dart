import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SettingGrpScreen extends StatefulWidget {
  String grpAvatar;
  String grpName;
  String grpId;

  SettingGrpScreen({this.grpAvatar, this.grpName, this.grpId});

  @override
  _SettingGrpScreenState createState() => _SettingGrpScreenState();
}

class _SettingGrpScreenState extends State<SettingGrpScreen> {
  String urlAvatar;
  String nameGrp;
  File imageFile;
  bool isLoading = false;

  @override
  void initState() {
    urlAvatar = widget.grpAvatar;
    nameGrp = widget.grpName;
    super.initState();
  }

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
    String fileName =  DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference =
        FirebaseStorage.instance.ref().child(fileName);
    reference.putFile(imageFile).onComplete.then((_) {
      reference.getDownloadURL().then((dynamic value) {
        urlAvatar = value.toString();
        setState(() {
          isLoading = false;
        });

        // sendMessage.onSendMessage(imageUrl, 1, widget.groupId);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting Group'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        urlAvatar,
                      ),
                      radius: 80,
                    ),
                  ),
                  Center(
                    child: RaisedButton(
                      elevation: 0.0,
                      child: Text(
                        'Change image',
                        style: TextStyle(color: Colors.blue[300]),
                      ),
                      onPressed: () {
                        getImage();
                        uploadFile();
                      },
                    ),
                  ),
                  Center(
                    child: Container(
                      padding:
                          EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Name group: $nameGrp'),
                        onChanged: (String str) => nameGrp = str,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: RaisedButton(
                  child: Text('SAVE',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  color: Colors.blue[300],
                  onPressed: () {
                    if (nameGrp != widget.grpName) 
                      FirebaseDatabase.instance.reference().child("Group/${widget.grpId}/infor/name").set(nameGrp);
                    if (urlAvatar != widget.grpAvatar)
                      FirebaseDatabase.instance.reference().child("Group/${widget.grpId}/infor/avatar").set(urlAvatar);
               //     Scaffold.of(context).showSnackBar(SnackBar(content: Text('Change Complete'),));
                    Navigator.pop(context);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
