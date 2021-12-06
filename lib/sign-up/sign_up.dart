import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 0, top: 0, right: 10, bottom: 0),
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
                    padding:
                        EdgeInsets.only(left: 10, top: 0, right: 0, bottom: 0),
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
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
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
          ),
        ],
      ),
    );
  }
}
