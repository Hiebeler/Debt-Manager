import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debtmanager/error_dialog.dart';
import 'package:debtmanager/home/home.dart';
import 'package:debtmanager/sign-in/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '/generated/l10n.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String confpassword = "";

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  get user => _auth.currentUser;

  errorDialog(BuildContext context, explanation) {
    ErrorDialog alert = ErrorDialog("Error", explanation);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<bool> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
      print("success google");
      addUser();
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return false;
    }
  }

  void addUser() {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    print(FirebaseFirestore.instance.collection("users").doc(firebaseUser!.uid));
    FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser.uid)
        .set({"email": email}).then((_) => print("success added User"));
  }

  //SIGN UP METHOD
  Future<bool> signUp(BuildContext context) async {
    bool worked = false;

    if (email == "" || password == "" || confpassword == "") {
      print("nicht alle felder ausgefüllt");
      errorDialog(context, "Missing arguments");
      return false;
    } else if (password != confpassword) {
      errorDialog(context, "your passwords don't match");
      return false;
    }
    if (!email.contains('@')) {
      errorDialog(context, "email isnt right");
      return false;
    }
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("success");
      addUser();
      worked = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        errorDialog(context, "Weak password");
      } else if (e.code == "email-already-in-use") {
        errorDialog(context, "An Account with this E-Mail already exists");
      }
    } catch (e) {
      print(e);
    }

    return worked;
  }

  Future<bool> checkifsucceeded() async {
    print(FirebaseAuth.instance.currentUser);
    if (await FirebaseAuth.instance.currentUser != null) {
      print("true");
      return true;
    }
    print("false");
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        title: Center(child: Text(S.of(context).signUp)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => {
                          signInwithGoogle().then((value) => {
                                if (value)
                                  {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => Home()))
                                  }
                              })
                        },
                        child: Text(S.of(context).signUp_google,
                            style: Theme.of(context).textTheme.bodyText1),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.only(top: 17, bottom: 17),
                          primary: Theme.of(context).scaffoldBackgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: const BorderSide(
                                color: Color.fromRGBO(121, 121, 121, 1),
                                width: 2.7),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Text(S.of(context).or,
                    style: Theme.of(context).textTheme.bodyText1),
                const SizedBox(height: 30),
                const SizedBox(height: 20),
                TextField(
                  onChanged: (input) {
                    email = input;
                  },
                  decoration: InputDecoration(
                    hintText: S.of(context).email,
                    enabledBorder:
                        Theme.of(context).inputDecorationTheme.enabledBorder,
                    focusedBorder:
                        Theme.of(context).inputDecorationTheme.focusedBorder,
                  ),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 20),
                TextField(
                  onChanged: (input) {
                    password = input;
                  },
                  decoration: InputDecoration(
                    hintText: S.of(context).password,
                    enabledBorder:
                        Theme.of(context).inputDecorationTheme.enabledBorder,
                    focusedBorder:
                        Theme.of(context).inputDecorationTheme.focusedBorder,
                  ),
                  style: Theme.of(context).textTheme.bodyText1,
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                TextField(
                  onChanged: (input) {
                    confpassword = input;
                  },
                  decoration: InputDecoration(
                    hintText: S.of(context).confirmpassword,
                    enabledBorder:
                        Theme.of(context).inputDecorationTheme.enabledBorder,
                    focusedBorder:
                        Theme.of(context).inputDecorationTheme.focusedBorder,
                  ),
                  style: Theme.of(context).textTheme.bodyText1,
                  obscureText: true,
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => {
                          signUp(context).then((value) => {
                                if (value == true)
                                  {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => Home()))
                                  }
                              }),
                        },
                        child: Text(S.of(context).signUp,
                            style: TextStyle(
                                color: Color.fromRGBO(160, 160, 160, 1))),
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).colorScheme.primary,
                          padding: const EdgeInsets.only(top: 17, bottom: 17),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(S.of(context).alreadyHaveAcc,
                        style: Theme.of(context).textTheme.bodyText1),
                    const SizedBox(
                      width: 10,
                    ),
                    MaterialButton(
                      onPressed: () => {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => SignIn()))
                      },
                      child: Text(
                        S.of(context).signIn,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
