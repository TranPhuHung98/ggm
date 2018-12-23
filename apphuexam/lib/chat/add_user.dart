import 'package:firebase_database/firebase_database.dart';

class AddUser {
  void onAddUser(String email, String groupId, String groupName,bool isJoined) {
    String changeString(String email) {
    String em = email ;
     for(int i =0 ; i < em.length; i ++ )
      if(em[i] == '.')
        em = em.replaceRange(i,i+1, '_');
    return em;
  }
    isJoined =true ;
    FirebaseDatabase.instance
        .reference()
        .child("Group")
        .child(groupId)
        .child("users")
        .child(changeString(email))
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot.value == null) {
        isJoined = false ;
        FirebaseDatabase.instance
            .reference()
            .child("Group")
            .child(groupId)
            .child("users")
            .child(changeString(email))
            .set({
          "email": email,
        });
        FirebaseDatabase.instance
            .reference()
            .child('Users')
            .child(changeString(email))
            .child('JoinedGroup')
            .child(groupId)
            .set({
          "groupName": groupName,
          "avatar":
              "https://www.beper.com/imagecache/uploads/images/PARTY_57622d.jpg",
          "dateJoined": DateTime.now().millisecondsSinceEpoch,
        });
      }
      // snapshot.
    });
  }
}
