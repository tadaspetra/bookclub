import 'package:cloud_firestore/cloud_firestore.dart';

class OurBook {
  String id;
  String name;
  String author;
  int length;
  Timestamp dateCompleted;

  OurBook({
    this.id,
    this.name,
    this.length,
    this.dateCompleted,
  });
}
