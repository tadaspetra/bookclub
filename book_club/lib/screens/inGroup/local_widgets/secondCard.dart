import 'package:book_club/widgets/shadowContainer.dart';
import 'package:flutter/material.dart';

class SecondCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Next Book\nRevealed In : ",
              style: TextStyle(
                fontSize: 30,
                color: Colors.grey[600],
              ),
            ),
            Text(
              "N/A",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
