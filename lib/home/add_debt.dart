import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debtmanager/home/debt_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'SideBar.dart';

class AddDebt extends StatelessWidget {
  final Color color;

  AddDebt({required this.color});

  var person = "";
  var description = "";
  double value = 0;

  void addDebttoDB() {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser!.uid)
        .update({
      "debts": FieldValue.arrayUnion([
        {"person": person, "description": description, "value": value}
      ])
    }).then((value) => print("success"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        title: const Center(child: Text("Debt Manager")),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextField(
                  onChanged: (input) => {person = input},
                  decoration: InputDecoration(
                    hintText: 'Person',
                    enabledBorder:
                        Theme.of(context).inputDecorationTheme.enabledBorder,
                    focusedBorder:
                        Theme.of(context).inputDecorationTheme.focusedBorder,
                  ),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  onChanged: (input) => {description = input},
                  decoration: InputDecoration(
                    hintText: 'Description',
                    enabledBorder:
                        Theme.of(context).inputDecorationTheme.enabledBorder,
                    focusedBorder:
                        Theme.of(context).inputDecorationTheme.focusedBorder,
                  ),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: (input) => {value = double.parse(input)},
                  decoration: InputDecoration(
                    hintText: 'Value',
                    enabledBorder:
                        Theme.of(context).inputDecorationTheme.enabledBorder,
                    focusedBorder:
                        Theme.of(context).inputDecorationTheme.focusedBorder,
                  ),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 35),
                ElevatedButton(
                  onPressed: () => {addDebttoDB()},
                  child: Text("Add new Debt",
                      style: Theme.of(context).textTheme.bodyText1),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(340, 50),
                    maximumSize: const Size(340, 50),
                    primary: color,
                    padding: const EdgeInsets.only(top: 17, bottom: 17),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: const TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
