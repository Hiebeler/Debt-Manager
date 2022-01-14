import 'package:debtmanager/error_dialog.dart';
import 'package:debtmanager/home/home.dart';
import 'package:debtmanager/sign-in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";
  String confpassword = "";

  final FirebaseAuth _auth = FirebaseAuth.instance;

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
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("success");
      worked = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        print("weak password");
      } else if (e.code == "email-already-in-use") {
        print("Email already exists");
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
        title: const Center(child: Text("Sign-Up")),
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
                        onPressed: () => {},
                        child: const Text(
                          "Sign-up with Google",
                          style: TextStyle(
                            color: Color.fromRGBO(121, 121, 121, 1),
                            fontSize: 17,
                          ),
                        ),
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
                Text("or", style: Theme.of(context).textTheme.bodyText1),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 0, top: 0, right: 10, bottom: 0),
                        child: TextField(
                          onChanged: (input) {},
                          decoration: InputDecoration(
                            hintText: 'First-Name',
                            enabledBorder: Theme.of(context)
                                .inputDecorationTheme
                                .enabledBorder,
                            focusedBorder: Theme.of(context)
                                .inputDecorationTheme
                                .focusedBorder,
                          ),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 0, right: 0, bottom: 0),
                        child: TextField(
                          onChanged: (input) {},
                          decoration: InputDecoration(
                            hintText: 'Last-Name',
                            enabledBorder: Theme.of(context)
                                .inputDecorationTheme
                                .enabledBorder,
                            focusedBorder: Theme.of(context)
                                .inputDecorationTheme
                                .focusedBorder,
                          ),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  onChanged: (input) {
                    email = input;
                  },
                  decoration: InputDecoration(
                    hintText: 'E-Mail',
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
                    hintText: 'Password',
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
                    hintText: 'confirm Password',
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
                        child: const Text("Sign-up",
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
                    Text("Already have an Account?",
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
                        "Sign-In",
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
