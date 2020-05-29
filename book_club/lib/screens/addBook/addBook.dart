import 'package:book_club/models/authModel.dart';
import 'package:book_club/models/book.dart';
import 'package:book_club/models/userModel.dart';
import 'package:book_club/screens/root/root.dart';
import 'package:book_club/services/dbFuture.dart';
import 'package:book_club/widgets/shadowContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OurAddBook extends StatefulWidget {
  final bool onGroupCreation;
  final String groupName;
  final UserModel currentUser;

  OurAddBook({
    this.onGroupCreation,
    this.groupName,
    this.currentUser,
  });
  @override
  _OurAddBookState createState() => _OurAddBookState();
}

class _OurAddBookState extends State<OurAddBook> {
  TextEditingController _bookNameController = TextEditingController();
  TextEditingController _authorController = TextEditingController();
  TextEditingController _lengthController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await DatePicker.showDateTimePicker(context, showTitleActions: true);
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _addBook(BuildContext context, String groupName, BookModel book) async {
    AuthModel _auth = Provider.of<AuthModel>(context, listen: false);
    String _returnString;

    if (widget.onGroupCreation) {
      _returnString = await DBFuture().createGroup(groupName, _auth.uid, book);
    } else {
      _returnString = await DBFuture().addNextBook(widget.currentUser.groupId, book);
    }

    if (_returnString == "success") {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => OurRoot(),
          ),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Text(DateFormat("H:mm").format(_selectedDate)),
                  FlatButton(
                    child: Text("Change Date"),
                    onPressed: () => _selectDate(context),
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
                      book.name = _bookNameController.text;
                      book.author = _authorController.text;
                      book.length = int.parse(_lengthController.text);
                      book.dateCompleted = Timestamp.fromDate(_selectedDate);

                      _addBook(context, widget.groupName, book);
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
