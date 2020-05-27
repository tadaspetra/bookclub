import 'package:book_club/screens/login/local_widgets/loginForm.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
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
                Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Image.asset("assets/logo.png"),
                ),
                SizedBox(
                  height: 20.0,
                ),
                LoginForm(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
