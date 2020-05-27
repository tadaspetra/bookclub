import 'package:book_club/screens/root/root.dart';
import 'package:book_club/services/auth.dart';
import 'package:book_club/utils/ourTheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/authModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AuthModel>.value(
      value: Auth().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: OurTheme().buildTheme(),
        home: OurRoot(),
      ),
    );
  }
}
