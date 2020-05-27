import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String email;
  Timestamp accountCreated;
  String fullName;
  String groupId;

  UserModel({
    this.uid,
    this.email,
  });

  UserModel.fromDocumentSnapshot({DocumentSnapshot doc}) {
    uid = doc.documentID;
    email = doc.data['email'];
    accountCreated = doc.data['accountCreated'];
    fullName = doc.data['fullName'];
    groupId = doc.data['groupId'];
  }
}
