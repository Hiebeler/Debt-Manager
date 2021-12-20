import 'package:debtmanager/home/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  String firstName = "";
  String lastName = "";
  String email = "";
  String password = "";

  final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;

  //SIGN UP METHOD
  Future<bool> signUp() async {
    bool worked = false;
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

  Future<bool> checkifsucceeded() async{
    print(FirebaseAuth.instance.currentUser);
    if(await FirebaseAuth.instance.currentUser != null){
      print("true");
      return true;
    }
    print("false");
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
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
                        //icon: ImageIcon("Icons/googelIcon.svg"),
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
                const Text(
                  "or",
                  style: TextStyle(
                    color: Color.fromRGBO(160, 160, 160, 1),
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 0, top: 0, right: 10, bottom: 0),
                        child: TextField(
                          onChanged: (input) {},
                          decoration: const InputDecoration(
                            hintText: 'First-Name',
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
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 0, right: 0, bottom: 0),
                        child: TextField(
                          onChanged: (input) {},
                          decoration: const InputDecoration(
                            hintText: 'Last-Name',
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
                                  width: 2.7),
                            ),
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
                  decoration: const InputDecoration(
                    hintText: 'E-Mail',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(121, 121, 121, 1),
                            width: 2.7)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(
                          color: Color.fromRGBO(121, 121, 121, 1), width: 2.7),
                    ),
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
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(121, 121, 121, 1),
                            width: 2.7)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(
                          color: Color.fromRGBO(121, 121, 121, 1), width: 2.7),
                    ),
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
                          signUp().then((value) => {
                            if(value == true){
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Home()))
                            }
                          }),

                        },
                        child: const Text("Sign-up",
                            style: TextStyle(
                                color: Color.fromRGBO(160, 160, 160, 1))),
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
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
                    const Text(
                      "Already have an Account?",
                      style: TextStyle(color: Color.fromRGBO(121, 121, 121, 1)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    MaterialButton(
                      onPressed: () => {},
                      child: Text(
                        "Sign-In",
                        style: TextStyle(color: Theme.of(context).primaryColor),
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
