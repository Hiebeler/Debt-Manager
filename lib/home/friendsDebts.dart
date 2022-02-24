import 'package:cloud_firestore/cloud_firestore.dart';
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
    print(friends);
    friends.forEach((element) async {
      await repository.getFutureFriends(element["uid"]).then((value) {
        List everyFriendsDebts = value["friendsDebts"];
        everyFriendsDebts.forEach((element) {
          if (element["friendsUid"] == firebaseUser!.uid) {
            friendDebtslocal.add(element);
          }
        });
      });
    });
    friendsDebts = friendDebtslocal;
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
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData) {
                getFriendDebts(snapshot.data);
                Color valueColor = Theme.of(context).colorScheme.secondary;
                return Column(
                  children: [
                    ...(snapshot.data!["friends"] as List).map((e) {
                      return FutureBuilder(
                          future: repository.getFutureFriends(e["uid"]),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            print(snapshot.data!["friendsDebts"]);
                            print(e["uid"]);
                            print(firebaseUser!.uid);

                            return Column(
                              children: [
                                ...(snapshot.data!["friendsDebts"]).map((e) {
                                  return e["friendsUid"] == firebaseUser!.uid
                                      ? DebtCard(
                                          debtId: e["id"],
                                          field: "IOwe",
                                          person: e["person"],
                                          description: e["description"],
                                          value: e["value"],
                                          color: Colors.red,
                                          isFriendsDebt: true,
                                        )
                                      : Container();
                                })
                              ],
                            );

                            return Container();
                          });
                    }),

/*                    */
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
