import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debtmanager/home/Debt-Card/debt_card.dart';
import 'package:debtmanager/home/data_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FriendsDebts extends StatefulWidget {
  final bool isIOwe;
  final Color homeColor;

  const FriendsDebts({required this.isIOwe, required this.homeColor});

  @override
  State<FriendsDebts> createState() => _FriendsDebtsState();
}

class _FriendsDebtsState extends State<FriendsDebts> {
  final DataRepository repository = DataRepository();

  final firebaseUser = FirebaseAuth.instance.currentUser;

  bool IOweOrIGet(String IoweIGet) {
    if (IoweIGet == "debts_Iget" && !widget.isIOwe) {
      return true;
    } else if (IoweIGet == "debts_Iowe" && widget.isIOwe) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: repository.getStream(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              ...(snapshot.data!["friends"] as List).map((e) {
                return FutureBuilder(
                    future: repository.getFutureFriends(e["uid"]),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasData) {
                        Map<String, dynamic> friendsData =
                            snapshot.data!.data() as Map<String, dynamic>;
                        if (friendsData.containsKey("friendsDebts")) {
                          return Column(
                            children: [
                              ...(snapshot.data!["friendsDebts"]).map((e) {
                                return e["friendsUid"] == firebaseUser!.uid && IOweOrIGet(e["IOweOrIGet"])
                                    ? DebtCard(
                                        debtId: e["id"],
                                        field: "IOwe",
                                        person: e["person"],
                                        description: e["description"],
                                        value: e["value"],
                                        color: widget.homeColor,
                                        isFriendsDebt: true,
                                      )
                                    : Container();
                              })
                            ],
                          );
                        }
                      }
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
    );
  }
}
