import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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

                TextField(
                  onChanged: (input) {},
                  decoration: const InputDecoration(
                    hintText: 'User-Name',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(121, 121, 121, 1),
                            width: 2.7)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(121, 121, 121, 1),
                            width: 2.7)),
                  ),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 20),
                TextField(
                  onChanged: (input) {},
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
                        onPressed: () => {},
                        child: const Text("Sign-in",
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
                    const Text("Don't have an Account?"),
                    const SizedBox(
                      width: 10,
                    ),
                    MaterialButton(
                      onPressed: () => {},
                      child: Text(
                        "Sign-Up",
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