import 'package:book_club/models/book.dart';
import 'package:book_club/models/groupModel.dart';
import 'package:book_club/models/userModel.dart';
import 'package:book_club/screens/addBook/addBook.dart';
import 'package:book_club/services/dbFuture.dart';
import 'package:book_club/widgets/shadowContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecondCard extends StatefulWidget {
  @override
  _SecondCardState createState() => _SecondCardState();
}

class _SecondCardState extends State<SecondCard> {
  GroupModel _groupModel;
  UserModel _currentUser;
  UserModel _pickingUser;
  BookModel _nextBook;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _groupModel = Provider.of<GroupModel>(context);
    _currentUser = Provider.of<UserModel>(context);
    if (_groupModel != null) {
      _pickingUser = await DBFuture()
          .getUser(_groupModel.members[_groupModel.indexPickingBook]);
      if (_groupModel.nextBookId != "waiting") {
        _nextBook = await DBFuture()
            .getCurrentBook(_groupModel.id, _groupModel.nextBookId);
      }

      if (this.mounted) {
        setState(() {});
      }
    }
  }

  void _goToAddBook(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OurAddBook(
          onGroupCreation: false,
          onError: false,
          currentUser: _currentUser,
        ),
      ),
    );
  }

  Widget _displayText() {
    Widget retVal;

    if (_pickingUser != null) {
      if (_groupModel.nextBookId == "waiting") {
        if (_pickingUser.uid == _currentUser.uid) {
          retVal = RaisedButton(
            child: Text("Select Next Book"),
            onPressed: () {
              _goToAddBook(context);
            },
          );
        } else {
          retVal = Text(
            "Waiting for " + _pickingUser.fullName + " to pick",
            style: TextStyle(
              fontSize: 30,
              color: Colors.grey[600],
            ),
          );
        }
      } else {
        retVal = Column(
          children: [
            Text(
              "Next Book Is:",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              (_nextBook != null) ? _nextBook.name : "loading..",
              style: TextStyle(
                fontSize: 30,
                color: Colors.grey[600],
              ),
            ),
            Text(
              (_nextBook != null) ? _nextBook.author : "loading..",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[600],
              ),
            ),
          ],
        );
      }
    } else {
      retVal = Text(
        "Loading...",
        style: TextStyle(
          fontSize: 30,
          color: Colors.grey[600],
        ),
      );
    }

    return retVal;
  }

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: _displayText(),
      ),
    );
  }
}
