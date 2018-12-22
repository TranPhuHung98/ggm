import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AddGroup {
  void onAddGroup(String groupName, FirebaseUser user) {
      String changeString(String email){
    String em = email. replaceRange(email.length-4, email.length-3, '_');
    print(email);
    return em ;
  }
    if (groupName != '') {
      int dateCreate = DateTime.now().millisecondsSinceEpoch ;
      String groupId = dateCreate.toString() ;
      FirebaseDatabase.instance
          .reference()
          .child("Group")
          .child(groupId)
          .child("infor")
          .set({
        "avatar": "https://www.beper.com/imagecache/uploads/images/PARTY_57622d.jpg",
        "name": groupName,
      });
      FirebaseDatabase.instance
          .reference()
          .child("Group")
          .child(groupId)
          .child("users")
          .child(changeString(user.email))
          .set({
        "email": user.email,
      });
      FirebaseDatabase.instance
          .reference()
          .child("Users")
          ..child(changeString(user.email))
          .child("JoinedGroup")
          .child(groupId)
          .set({
        "groupName": groupName,
        "avatar" : "https://www.beper.com/imagecache/uploads/images/PARTY_57622d.jpg",
        "dateJoined": DateTime.now().millisecondsSinceEpoch 
      });

    }
  }
}
