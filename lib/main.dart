import 'package:debtmanager/sign-in/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'custom_theme.dart';
import 'home/home.dart';
import 'sign-up/sign_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<bool> checkIfSignedIn() async {
    var test = FirebaseAuth.instance.currentUser;
    if (test == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: CustomTheme.darkTheme,
        home: Scaffold(
            body: FutureBuilder(
          future: checkIfSignedIn(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == true) {
                return Home();
              } else {
                return SignUp();
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        )));
  }
}
