import 'package:debtmanager/sign-in/sign_in.dart';
import 'package:flutter/material.dart';
import 'sign-up/sign_up.dart';

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
        backgroundColor: const Color.fromRGBO(18, 19, 20, 1),
        primaryColor: const Color.fromRGBO(75, 29, 82, 1),
        hintColor: const Color.fromRGBO(121, 121, 121, 1),
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Color.fromRGBO(121, 121, 121, 1), fontSize: 17,)
        )
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(39, 39, 39, 1),
          title: const Center(
            child: Text("Sign-Up")
          ),
        ),
        body: SignUp(),
      )
    );
  }
}
