import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel {
  String id;
  String name;
  String leader;
  List<String> members;
  List<String> tokens;
  Timestamp groupCreated;
  String currentBookId;
  int indexPickingBook;
  String nextBookId;
  Timestamp currentBookDue;
  Timestamp nextBookDue;

  GroupModel({
    this.id,
    this.name,
    this.leader,
    this.members,
    this.tokens,
    this.groupCreated,
    this.currentBookId,
    this.indexPickingBook,
    this.nextBookId,
    this.currentBookDue,
    this.nextBookDue,
  });

  GroupModel.fromDocumentSnapshot({DocumentSnapshot doc}) {
    id = doc.documentID;
    name = doc.data["name"];
    leader = doc.data["leader"];
    members = List<String>.from(doc.data["members"]);
    tokens = List<String>.from(doc.data["tokens"] ?? []);
    groupCreated = doc.data["groupCreated"];
    currentBookId = doc.data["currentBookId"];
    indexPickingBook = doc.data["indexPickingBook"];
    nextBookId = doc.data["nextBookId"];
    currentBookDue = doc.data["currentBookDue"];
    nextBookDue = doc.data["nextBookDue"];
  }
}
