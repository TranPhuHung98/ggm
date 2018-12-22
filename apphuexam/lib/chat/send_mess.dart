import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SendMessage {
  void onSendMessage(String content, int type, String groupId) async {
    // type: 0 = text, 1 = image
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await _auth.currentUser();
    if (content != '') {
      FirebaseDatabase.instance
          .reference()
          .child('Group')
          .child('$groupId')
          .child('message')
          .push()
          .set({
        'type': type,
        'text': content,
        'email': firebaseUser.email,
        'senderName': firebaseUser.displayName,
        'senderPhotoUrl': firebaseUser.photoUrl
      });
    } else {
      //
    }
  }
}
