import 'package:debtmanager/home/Debt-Card/debt_card.dart';
import 'package:debtmanager/home/data_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Side_bar.dart';

class FriendsDebts extends StatefulWidget {
  FriendsDebts({Key? key}) : super(key: key);

  @override
  State<FriendsDebts> createState() => _FriendsDebtsState();
}

class _FriendsDebtsState extends State<FriendsDebts> {
  final DataRepository repository = DataRepository();

  final firebaseUser = FirebaseAuth.instance.currentUser;

  List friendsDebts = [];

  void getFriendDebts(data) async {
    List friendDebtslocal = [];
    List friends = data["friends"];
    friends.forEach((element) async {
      await repository.getFutureFriends(element["uid"]).then((value) {
        List everyFriendsDebts = value["friendsDebts"];
        everyFriendsDebts.forEach((element) {
          if (element["friendsUid"] == firebaseUser!.uid) {
            friendDebtslocal.add(element);
          }
        });
        setState(() {
          friendsDebts = friendDebtslocal;
        });
      });
    });
  }

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
            stream: repository.getStream(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                getFriendDebts(snapshot.data);
                Color valueColor = Theme.of(context).colorScheme.secondary;
                print(friendsDebts);
                return Column(
                  children: [
                    ...(friendsDebts).map((e) {
                      if (e["value"] > 0) {
                        valueColor = Theme.of(context).colorScheme.secondaryVariant;
                      }
                      return DebtCard(
                          debtId: e["id"],
                          field: "IOwe",
                          person: e["person"],
                          description: e["description"],
                          value: e["value"],
                          color: valueColor,
                      isFriendsDebt: true,);
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
