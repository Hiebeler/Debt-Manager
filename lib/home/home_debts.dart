import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debtmanager/home/data_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Debt-Card/debt_card.dart';

class HomeDebts extends StatelessWidget {
  final Color homeColor;
  final bool isIOwe;

  HomeDebts({required this.homeColor, required this.isIOwe});

  final DataRepository repository = DataRepository();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: repository.getStream(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            String field = "debts_Iget";
            if (isIOwe) {
              field = "debts_Iowe";
            }
            Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;
            if (data[field] == null) {
              return Container();
            }
            return Column(
              children: [
                ...(data[field]).map((debt) {
                  return DebtCard(
                    field: field,
                    debtId: debt["id"],
                    person: debt["person"],
                    description: debt["description"],
                    value: debt["value"].toDouble(),
                    color: homeColor,
                    isFriendsDebt: false,
                  );
                })
              ],
            );
          }
          return const CircularProgressIndicator();
        });
  }
}
