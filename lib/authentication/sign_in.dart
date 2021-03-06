import 'package:debtmanager/authentication/auth_with_google.dart';
import 'package:debtmanager/authentication/sign_up.dart';
import 'package:debtmanager/error_dialog.dart';
import 'package:debtmanager/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '/generated/l10n.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = "";

  String password = "";

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isHidden = true;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  get user => _auth.currentUser;

  //SIGN UP METHOD
  Future<bool> signIn(BuildContext context) async {
    bool worked = false;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print("successfull");
      worked = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorDialog(context, "User not found");
      } else if (e.code == 'wrong-password') {
        errorDialog(context, "Wrong Password");
      } else if (e.code == "invalid-email") {
        errorDialog(context, "Invalid Email Address");
      } else if (e.code == "user-disabled") {
        errorDialog(context, "this user is blocked");
      }
    }
    return worked;
  }

  errorDialog(BuildContext context, explanation) {
    ErrorDialog alert = ErrorDialog("Error", explanation);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        title: Center(child: Text(S.of(context).signIn)),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        height: double.infinity,
        child: Padding(
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
                            AuthWithGoogle()
                                .signInwithGoogle()
                                .then((value) => {
                                      if (value)
                                        {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) => Home(
                                                        isFriendsDebts: false,
                                                      )))
                                        }
                                    })
                          },
                          child: Text(
                            S.of(context).signIn_google,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.only(top: 17, bottom: 17),
                            primary: Theme.of(context).backgroundColor,
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
                  TextField(
                    onChanged: (input) => {email = input},
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
                    onChanged: (input) => {password = input},
                    decoration: InputDecoration(
                      hintText: S.of(context).password,
                      enabledBorder:
                          Theme.of(context).inputDecorationTheme.enabledBorder,
                      focusedBorder:
                          Theme.of(context).inputDecorationTheme.focusedBorder,
                      suffixIcon: InkWell(
                        onTap: _togglePasswordView,
                        child: Icon(
                          _isHidden
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                    style: Theme.of(context).textTheme.bodyText1,
                    obscureText: _isHidden,
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => {
                            signIn(context).then((value) => {
                                  print(value),
                                  if (value == true)
                                    {
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                              builder: (context) => Home(
                                                    isFriendsDebts: false,
                                                  )))
                                    }
                                }),
                          },
                          child: Text(S.of(context).signIn,
                              style: const TextStyle(
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
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(S.of(context).dontHaveAcc,
                            style: Theme.of(context).textTheme.bodyText1),
                        const SizedBox(
                          width: 10,
                        ),
                        MaterialButton(
                          onPressed: () => {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => SignUp()))
                          },
                          child: Text(
                            S.of(context).signUp,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
