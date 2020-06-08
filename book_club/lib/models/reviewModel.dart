import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  String userId;
  int rating;
  String review;

  ReviewModel({
    this.userId,
    this.rating,
    this.review,
  });

  ReviewModel.fromDocumentSnapshot({DocumentSnapshot doc}) {
    userId = doc.documentID;
    rating = doc.data["rating"];
    review = doc.data["review"];
  }
}
