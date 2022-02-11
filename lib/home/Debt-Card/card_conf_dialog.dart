import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home.dart';

class Card_conf_dialog extends StatefulWidget {
  final int debtId;
  final String field;

  Card_conf_dialog({required this.debtId, required this.field});

  @override
  State<Card_conf_dialog> createState() => _Card_conf_dialogState();
}

class _Card_conf_dialogState extends State<Card_conf_dialog> {
  Future<bool> removeDebt() async {
    var collection = FirebaseFirestore.instance.collection('users');
    var firebaseUser = FirebaseAuth.instance.currentUser;
    var docSnapshot = await collection.doc(firebaseUser!.uid).get();
    if (docSnapshot.exists) {
      List<dynamic> data = docSnapshot.data()![widget.field];
      Map rightData = {};
      for (Map i in data) {
        if (i["id"] == widget.debtId) {
          rightData = i;
        }
      }

      collection.doc(firebaseUser.uid).update({
        widget.field: FieldValue.arrayRemove([rightData])
      }).whenComplete(() => print("Debt deleted"));
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          title: Text(
            "Debt settings",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          content: Text(
            "Do you want to delete it or change it",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text("Delete"),
              style: ElevatedButton.styleFrom(primary: Colors.red),
              onPressed: () {
                removeDebt();
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("Change"),
              style: ElevatedButton.styleFrom(primary: Colors.green),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("Cancel"),
              style: ElevatedButton.styleFrom(primary: Colors.grey),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}
