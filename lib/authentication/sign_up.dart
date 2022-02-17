import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debtmanager/authentication/sign_in.dart';
import 'package:debtmanager/error_dialog.dart';
import 'package:debtmanager/home/data_repository.dart';
import 'package:debtmanager/home/entity/debt_user.dart';
import 'package:debtmanager/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '/generated/l10n.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String firstName = "";

  String lastName = "";

  String username = "";

  String? email = "";

  String password = "";

  String confpassword = "";

  Color usernameBorderColor = const Color.fromRGBO(121, 121, 121, 1);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  late StreamSubscription subscription;

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
      checkIfUserExists();
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return false;
    }
  }

  void checkIfUserExists() {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser!.uid)
        .get()
        .then((value) => {if (!value.exists) addUser()});
  }

  void addUser() {
    final DataRepository repository = DataRepository();
    if (email == "") {
      email = _auth.currentUser?.email;
    }
    DebtUser user = DebtUser(email: email.toString(), username: username);
    repository.addUser(user);
  }

  Future<bool> checkIfParametersAreRight(BuildContext context) async {
    if (username == "" || email == "" || password == "" || confpassword == "") {
      errorDialog(context, "Missing arguments");
      return false;
    } else if (password != confpassword) {
      errorDialog(context, "your passwords don't match");
      return false;
    }
    if (!email.toString().contains('@')) {
      errorDialog(context, "email isnt right");
      return false;
    }

    subscription = FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .snapshots()
        .listen((data) {
      if (data.docs.isNotEmpty) {
        errorDialog(context, "username already exits safsadfasdfasdf");
      }
    });

    return true;
  }

  //SIGN UP METHOD
  Future<bool> signUp(BuildContext context) async {
    bool worked = false;

    bool parametersAreRight = await checkIfParametersAreRight(context);
    if (!parametersAreRight) {
      return false;
    }
    subscription.cancel();

    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.toString(),
        password: password,
      );
      addUser();
      worked = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        errorDialog(context, "Weak password");
      } else if (e.code == "email-already-in-use") {
        errorDialog(context, "An Account with this E-Mail already exists");
      }
    } catch (e) {
      errorDialog(context, "An error occured");
    }

    return worked;
  }

  Future<bool> checkifsucceeded() async {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    }
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
                    username = input;
                  },
                  onSubmitted: (input) {
                    FirebaseFirestore.instance
                        .collection('users')
                        .where('username', isEqualTo: username)
                        .snapshots().listen((data) {
                      if (data.docs.isNotEmpty) {
                        errorDialog(context, "username already exits");
                        setState(() {
                          usernameBorderColor =
                              Theme.of(context).colorScheme.secondaryVariant;
                        });
                      } else {
                        setState(() {
                          usernameBorderColor =
                              Theme.of(context).colorScheme.onSecondary;
                        });
                      }
                    });
                  },
                  decoration: InputDecoration(
                    hintText: S.of(context).username,
                    enabledBorder: Theme.of(context)
                        .inputDecorationTheme
                        .enabledBorder
                        ?.copyWith(
                          borderSide: BorderSide(
                              color: usernameBorderColor, width: 2.7),
                        ),
                    focusedBorder: Theme.of(context)
                        .inputDecorationTheme
                        .enabledBorder
                        ?.copyWith(
                          borderSide: BorderSide(
                              color: usernameBorderColor, width: 2.7),
                        ),
                  ),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
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
