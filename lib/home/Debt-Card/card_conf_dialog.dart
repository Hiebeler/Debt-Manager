import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../add_debt.dart';

class Card_conf_dialog extends StatefulWidget {
  final int debtId;
  final String field;
  final Color color;

  Card_conf_dialog(
      {required this.debtId, required this.field, required this.color});

  @override
  State<Card_conf_dialog> createState() => _Card_conf_dialogState();
}

class _Card_conf_dialogState extends State<Card_conf_dialog> {
  var collection = FirebaseFirestore.instance.collection('users');
  var firebaseUser = FirebaseAuth.instance.currentUser;
  bool isIOwe = false;

  bool getIsIOwe() {
    if(widget.field == "debts_Iowe") {
      return true;
    }
    return false;
  }

  void isFriendsDebt() async{
    var docSnapshot = await collection.doc(firebaseUser!.uid).get();
    List friendsDebts = docSnapshot.data()!["friendsDebts"];
    friendsDebts.forEach((element) {
      if (element["IOweOrIGet"] == widget.field && element["id"] == widget.debtId) {
        removeFriendsDebt(element);
        return;
      }
    });
  }

  void removeFriendsDebt(Map friendsDebt) {
    collection.doc(firebaseUser?.uid).update({
      "friendsDebts": FieldValue.arrayRemove([friendsDebt])
    }).whenComplete(() => print("Friends debt deleted"));
  }

  Future<bool> removeDebt() async {
    Map rightData = await getDebt();
    collection.doc(firebaseUser?.uid).update({
      widget.field: FieldValue.arrayRemove([rightData])
    }).whenComplete(() => print("Debt deleted"));
    isFriendsDebt();
    return true;
  }

  Future<Map> getDebt() async {
    var docSnapshot = await collection.doc(firebaseUser!.uid).get();
    Map rightData = {};
    if (docSnapshot.exists) {
      List<dynamic> data = docSnapshot.data()![widget.field];
      for (Map i in data) {
        if (i["id"] == widget.debtId) {
          rightData = i;
        }
      }
    }
    return rightData;
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
              style: ElevatedButton.styleFrom(primary: Theme.of(context).colorScheme.secondaryVariant),
              onPressed: () {
                removeDebt()
                    .then((value) => Navigator.of(context).pop());
              },
            ),
            ElevatedButton(
              child: Text("Change"),
              style: ElevatedButton.styleFrom(primary: Theme.of(context).colorScheme.secondary),
              onPressed: () {
                getDebt().then((value) => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddDebt.changeDebt(
                              widget.color, value["person"], value["description"], value["value"], value["id"], getIsIOwe())))
                    });
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
