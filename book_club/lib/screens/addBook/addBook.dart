import 'package:book_club/models/book.dart';
import 'package:book_club/models/userModel.dart';
import 'package:book_club/screens/root/root.dart';
import 'package:book_club/services/dbFuture.dart';
import 'package:book_club/widgets/shadowContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';

class OurAddBook extends StatefulWidget {
  final bool onGroupCreation;
  final bool onError;
  final String groupName;
  final UserModel currentUser;

  OurAddBook({
    this.onGroupCreation,
    this.onError,
    this.groupName,
    this.currentUser,
  });
  @override
  _OurAddBookState createState() => _OurAddBookState();
}

class _OurAddBookState extends State<OurAddBook> {
  final addBookKey = GlobalKey<ScaffoldState>();

  TextEditingController _bookNameController = TextEditingController();
  TextEditingController _authorController = TextEditingController();
  TextEditingController _lengthController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  initState() {
    super.initState();
    _selectedDate = DateTime(_selectedDate.year, _selectedDate.month,
        _selectedDate.day, _selectedDate.hour, 0, 0, 0, 0);
  }

  Future<void> _selectDate() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2222));

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = DateTime(picked.year, picked.month, picked.day,
            _selectedDate.hour, 0, 0, 0, 0);
      });
    }
  }

  Future _selectTime() async {
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.integer(
          minValue: 0,
          maxValue: 23,
          initialIntegerValue: 0,
          infiniteLoop: true,
        );
      },
    ).then((num value) {
      if (value != null) {
        setState(() {
          _selectedDate = DateTime(_selectedDate.year, _selectedDate.month,
              _selectedDate.day, value, 0, 0, 0, 0);
        });
      }
    });
  }

  void _addBook(BuildContext context, String groupName, BookModel book) async {
    String _returnString;

    if (_selectedDate.isAfter(DateTime.now().add(Duration(days: 1)))) {
      if (widget.onGroupCreation) {
        _returnString =
            await DBFuture().createGroup(groupName, widget.currentUser, book);
      } else if (widget.onError) {
        _returnString =
            await DBFuture().addCurrentBook(widget.currentUser.groupId, book);
      } else {
        _returnString =
            await DBFuture().addNextBook(widget.currentUser.groupId, book);
      }

      if (_returnString == "success") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => OurRoot(),
            ),
            (route) => false);
      }
    } else {
      addBookKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Due date is less that a day from now!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: addBookKey,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[BackButton()],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ShadowContainer(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _bookNameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.book),
                      hintText: "Book Name",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _authorController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_outline),
                      hintText: "Author",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: _lengthController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.format_list_numbered),
                      hintText: "Length",
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(DateFormat.yMMMMd("en_US").format(_selectedDate)),
                  Text(DateFormat("H:00").format(_selectedDate)),
                  Row(
                    children: [
                      Expanded(
                        child: FlatButton(
                          child: Text("Change Date"),
                          onPressed: () => _selectDate(),
                        ),
                      ),
                      Expanded(
                        child: FlatButton(
                          child: Text("Change Time"),
                          onPressed: () => _selectTime(),
                        ),
                      ),
                    ],
                  ),
                  RaisedButton(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 100),
                      child: Text(
                        "Create",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    onPressed: () {
                      BookModel book = BookModel();
                      if (_bookNameController.text == "") {
                        addBookKey.currentState.showSnackBar(SnackBar(
                          content: Text("Need to add book name"),
                        ));
                      } else if (_authorController.text == "") {
                        addBookKey.currentState.showSnackBar(SnackBar(
                          content: Text("Need to add author"),
                        ));
                      } else if (_lengthController.text == "") {
                        addBookKey.currentState.showSnackBar(SnackBar(
                          content: Text("Need to add book length"),
                        ));
                      } else {
                        book.name = _bookNameController.text;
                        book.author = _authorController.text;
                        book.length = int.parse(_lengthController.text);
                        book.dateCompleted = Timestamp.fromDate(_selectedDate);

                        _addBook(context, widget.groupName, book);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
