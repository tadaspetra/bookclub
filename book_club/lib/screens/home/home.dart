import 'dart:async';

import 'package:book_club/screens/addBook/addBook.dart';
import 'package:book_club/screens/review/review.dart';
import 'package:book_club/screens/root/root.dart';
import 'package:book_club/states/currentGroup.dart';
import 'package:book_club/states/currentUser.dart';
import 'package:book_club/utils/timeLeft.dart';
import 'package:book_club/widgets/ourContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _timeUntil = List(2);
  // [0] - Time until book is due
  // [1] - Time until next book is revealed

  Timer _timer;

  void _startTimer(CurrentGroup currentGroup) {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _timeUntil = OurTimeLeft().timeLeft(currentGroup.getCurrentGroup.currentBookDue.toDate());
      });
    });
  }

  @override
  void initState() {
    super.initState();
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    CurrentGroup _currentGroup = Provider.of<CurrentGroup>(context, listen: false);
    _currentGroup.updateStateFromDatabase(
        _currentUser.getCurrentUser.groupId, _currentUser.getCurrentUser.uid);
    _startTimer(_currentGroup);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _goToAddBook(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OurAddBook(
          onGroupCreation: false,
        ),
      ),
    );
  }

  void _goToReview() {
    CurrentGroup _currentGroup = Provider.of<CurrentGroup>(context, listen: false);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OurReview(
          currentGroup: _currentGroup,
        ),
      ),
    );
  }

  void _signOut(BuildContext context) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await _currentUser.signOut();
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
            child: OurContainer(
              child: Consumer<CurrentGroup>(
                builder: (BuildContext context, value, Widget child) {
                  return Column(
                    children: <Widget>[
                      Text(
                        value.getCurrentBook.name ?? "loading..",
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.grey[600],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Due In: ",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.grey[600],
                              ),
                            ),
                            Expanded(
                              child: Text(
                                _timeUntil[0] ?? "loading...",
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      RaisedButton(
                        child: Text(
                          "Finished Book",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: value.getDoneWithCurrentBook ? null : _goToReview,
                      )
                    ],
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: OurContainer(
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
                      _timeUntil[1] ?? "loading...",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
