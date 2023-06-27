import 'package:cloud_firestore/cloud_firestore.dart';

class databaseService {
  final String? uid;
  databaseService({this.uid});

//reference for collections

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  Future savingUserData(String fullName, String email) async {
    return await userCollection
        .doc(uid)
        .set({"fullName": fullName, "email": email, "uid": uid});
  }

  //getting user data

  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }
}
