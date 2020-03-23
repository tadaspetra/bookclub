import 'package:book_club/states/currentUser.dart';
import 'package:book_club/widgets/ourContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OurSignUpForm extends StatefulWidget {
  @override
  _OurSignUpFormState createState() => _OurSignUpFormState();
}

class _OurSignUpFormState extends State<OurSignUpForm> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  void _signUpUser(String email, String password, BuildContext context) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    try {
      String _returnString = await _currentUser.signUpUser(email, password);
      if (_returnString == "success") {
        Navigator.pop(context);
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(_returnString),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OurContainer(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
            child: Text(
              "Sign Up",
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextFormField(
            controller: _fullNameController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person_outline),
              hintText: "Full Name",
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.alternate_email),
              hintText: "Email",
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_outline),
              hintText: "Password",
            ),
            obscureText: true,
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: _confirmPasswordController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock_open),
              hintText: "Confirm Password",
            ),
            obscureText: true,
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Text(
                "Sign Up",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            onPressed: () {
              if (_passwordController.text == _confirmPasswordController.text) {
                _signUpUser(_emailController.text, _passwordController.text, context);
              } else {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Passwords do not match"),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
