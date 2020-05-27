import 'package:book_club/models/groupModel.dart';
import 'package:book_club/models/userModel.dart';
import 'package:book_club/screens/addBook/addBook.dart';
import 'package:book_club/screens/root/root.dart';
import 'package:book_club/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'local_widgets/secondCard.dart';
import 'local_widgets/topCard.dart';

class InGroup extends StatefulWidget {
  @override
  InGroupState createState() => InGroupState();
}

class InGroupState extends State<InGroup> {
  GroupModel _groupModel;
  UserModel _userModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userModel = Provider.of<UserModel>(context);
    _groupModel = Provider.of<GroupModel>(context);
  }

  void _goToAddBook(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OurAddBook(
          onGroupCreation: false,
          currentUser: _userModel,
        ),
      ),
    );
  }

  void _signOut(BuildContext context) async {
    String _returnString = await Auth().signOut();
    if (_returnString == "success") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => OurRoot(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TopCard(groupModel: _groupModel),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SecondCard(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            child: RaisedButton(
              child: Text(
                "Book Club History",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => _goToAddBook(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: RaisedButton(
              child: Text("Sign Out"),
              onPressed: () => _signOut(context),
              color: Theme.of(context).canvasColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(
                  color: Theme.of(context).secondaryHeaderColor,
                  width: 2,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
