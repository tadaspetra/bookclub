import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel {
  String id;
  String name;
  String leader;
  List<String> members;
  Timestamp groupCreated;
  String currentBookId;
  Timestamp currentBookDue;

  GroupModel({
    this.id,
    this.name,
    this.leader,
    this.members,
    this.groupCreated,
    this.currentBookId,
    this.currentBookDue,
  });

  GroupModel.fromDocumentSnapshot({DocumentSnapshot doc}) {
    id = doc.documentID;
    name = doc.data["name"];
    leader = doc.data["leader"];
    members = List<String>.from(doc.data["members"]);
    groupCreated = doc.data["groupCreated"];
    currentBookId = doc.data["currentBookId"];
    currentBookDue = doc.data["currentBookDue"];
  }
}
