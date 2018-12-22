import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Comment{
  void onComment(int type,String groupId , String postId ,String content) async {
     final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await _auth.currentUser();
    if (content != '') {
      FirebaseDatabase.instance
          .reference()
          .child('Group')
          .child('$groupId')
          .child('post')
          .child(postId)
          .child('commment')
          .push()
          .set({
        'type' : type,
        'content': content,
        'email': firebaseUser.email,
        'senderName': firebaseUser.displayName,
        'senderPhotoUrl': firebaseUser.photoUrl,
        'timePost' : DateTime.now().toString()
      });
    }
  }
}