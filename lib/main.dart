import 'package:flutter/material.dart';
import 'sign-up/sign-up.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Color.fromRGBO(18, 19, 20, 1),
        primaryColor: Color.fromRGBO(75, 29, 82, 1),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(39, 39, 39, 1),
          title: Center(
            child: Text("Sign-Up")
          ),
        ),
        body: SignUp(),
      )
    );
  }
}
