import 'package:cloud_firestore/cloud_firestore.dart';

class BookModel {
  String id;
  String name;
  String author;
  int length;
  Timestamp dateCompleted;

  BookModel({
    this.id,
    this.name,
    this.length,
    this.dateCompleted,
  });
}
