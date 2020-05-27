import 'package:book_club/screens/signUp/local_widgets/signUpForm.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    BackButton(),
                  ],
                ),
                SizedBox(
                  height: 40.0,
                ),
                SignUpForm(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
