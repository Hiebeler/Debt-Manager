import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../error_dialog.dart';
import '/generated/l10n.dart';
import 'home.dart';

class AddDebt extends StatefulWidget {
  final Color color;

  AddDebt({required this.color});

  @override
  State<AddDebt> createState() => _AddDebtState();
}

class _AddDebtState extends State<AddDebt> {
  bool isIOwe = false;

  var person = "";

  var description = "";

  double value = 0;

  void addDebttoDB() {
    final String debt;
    if (isIOwe) {
      debt = "debts_Iowe";
    } else {
      debt = "debts_Iget";
    }

    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser!.uid)
        .update({
      debt: FieldValue.arrayUnion([
        {"person": person, "description": description, "value": value}
      ])
    }).then((value) => {print("success")});
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        title: Center(child: Text(S.of(context).debtManager)),
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
                Row(children: [
                  const Text("I owe Somebody?"),
                  Switch(
                    value: isIOwe,
                    onChanged: (bool value) {
                      setState(() {
                        isIOwe = value;
                      });
                    },
                  )
                ]),
                TextField(
                  onChanged: (input) => {person = input},
                  decoration: InputDecoration(
                    hintText: S.of(context).person,
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
                    hintText: S.of(context).description,
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
                    hintText: S.of(context).value,
                    enabledBorder:
                        Theme.of(context).inputDecorationTheme.enabledBorder,
                    focusedBorder:
                        Theme.of(context).inputDecorationTheme.focusedBorder,
                  ),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(height: 35),
                ElevatedButton(
                  onPressed: () => {
                    addDebttoDB(),
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Home()))
                  },
                  child: Text(S.of(context).addNewDebt,
                      style: Theme.of(context).textTheme.bodyText1),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(340, 50),
                    maximumSize: const Size(340, 50),
                    primary: widget.color,
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
