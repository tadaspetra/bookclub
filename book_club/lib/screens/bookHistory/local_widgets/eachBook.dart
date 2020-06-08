import 'package:book_club/models/book.dart';
import 'package:book_club/screens/reviewHistory/reviewHistory.dart';
import 'package:book_club/widgets/shadowContainer.dart';
import 'package:flutter/material.dart';

class EachBook extends StatelessWidget {
  final BookModel book;
  final String groupId;

  void _goToReviewHistory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReviewHistory(
          groupId: groupId,
          bookId: book.id,
        ),
      ),
    );
  }

  EachBook({this.book, this.groupId});
  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      child: Column(
        children: [
          Text(
            book.name,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            book.author,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            child: Text("Reviews"),
            onPressed: () => _goToReviewHistory(context),
          )
        ],
      ),
    );
  }
}
