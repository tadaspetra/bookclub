import 'package:cloud_firestore/cloud_firestore.dart';

class OurUser {
  String uid;
  String email;
  String fullName;
  Timestamp accountCreated;
  String groupId;

  OurUser({
    this.uid,
    this.email,
    this.fullName,
    this.accountCreated,
    this.groupId,
  });
}
