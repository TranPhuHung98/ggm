import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class Post{

  void onPost(String content,String groupId)async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await _auth.currentUser();
    if (content != '') {
      DateTime time = DateTime.now();
      String abc  = DateFormat.jm().add_yMMMMd().format(time).toString() ;
      String timePost = time.millisecondsSinceEpoch.toString();
      FirebaseDatabase.instance
          .reference()
          .child('Group')
          .child('$groupId')
          .child('post')
          .child(timePost)
          .set({
        'content': content,
        'email': firebaseUser.email,
        'senderName': firebaseUser.displayName,
        'senderPhotoUrl': firebaseUser.photoUrl,
        'timePost' :abc
      });
    }
  }
}