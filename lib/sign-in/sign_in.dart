import 'package:debtmanager/home/home.dart';
import 'package:debtmanager/sign-up/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);

  String email = "";
  String password = "";

  final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;

  //SIGN UP METHOD
  Future<bool> signIn() async {
    bool worked = false;
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      print("successfull");
      worked =  true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return worked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(39, 39, 39, 1),
          title: const Center(child: Text("Sign-In")),
          automaticallyImplyLeading: false,
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
                            onPressed: () => {},
                            child: const Text(
                              "Sign-up with Google",
                              style: TextStyle(
                                color: Color.fromRGBO(121, 121, 121, 1),
                                fontSize: 17,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.only(top: 17, bottom: 17),
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
                    const Text(
                      "or",
                      style: TextStyle(
                        color: Color.fromRGBO(160, 160, 160, 1),
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      onChanged: (input) {
                        email = input;
                      },
                      decoration: const InputDecoration(
                        hintText: 'User-Name',
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(121, 121, 121, 1),
                                width: 2.7)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(121, 121, 121, 1),
                                width: 2.7)),
                      ),
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      onChanged: (input) {
                        password = input;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(121, 121, 121, 1),
                                width: 2.7)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(121, 121, 121, 1),
                                width: 2.7)),
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
                              signIn().then((value) => {
                                if (value == true)
                                  {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const Home()))
                                  }
                              }),
                            },
                            child: const Text("Sign-in",
                                style: TextStyle(
                                    color: Color.fromRGBO(160, 160, 160, 1))),
                            style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor,
                              padding:
                                  const EdgeInsets.only(top: 17, bottom: 17),
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
                        const Text(
                          "Don't have an Account?",
                          style: TextStyle(
                              color: Color.fromRGBO(121, 121, 121, 1)),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        MaterialButton(
                          onPressed: () => {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SignUp()))
                          },
                          child: Text(
                            "Sign-Up",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
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
        ),
    );
  }
}
