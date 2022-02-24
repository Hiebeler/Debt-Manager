import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debtmanager/home/Debt-Card/debt_card.dart';
import 'package:debtmanager/home/data_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Side_bar.dart';

class FriendsDebts extends StatelessWidget {
  FriendsDebts({Key? key}) : super(key: key);

  final DataRepository repository = DataRepository();
  final firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Center(child: Text("Friends")),
        backgroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: repository.getFriendsDebts(firebaseUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                List friendsDebts = [];
                snapshot.data!.docs.forEach((element) {
                  friendsDebts.add(element["friendsDebts"]);
                });
                return Column(
                  children: [
                    ...(friendsDebts).map((e) {
                      return DebtCard(
                          debtId: e["id"],
                          field: "IOwe",
                          person: e["person"],
                          description: e["description"],
                          value: e["value"],
                          color: Colors.red);
                    })
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
