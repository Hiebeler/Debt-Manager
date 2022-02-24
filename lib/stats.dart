import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debtmanager/home/data_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'generated/l10n.dart';
import 'home/side_bar.dart';

class Stats extends StatelessWidget {
  Stats({Key? key}) : super(key: key);

  DataRepository repository = DataRepository();

  double getTotalIowe(data){
    double sumiowe = 0;

    if (data["debts_Iowe"] != null) {
      List iget = data["debts_Iowe"];
      iget.forEach((element) {
        sumiowe += element["value"];
      });
    }

    return sumiowe;
  }

  double getTotalIget(data){
    double sumiget = 0;

    if (data["debts_Iget"] != null) {
      List iget = data["debts_Iget"];
      iget.forEach((element) {
        sumiget += element["value"];
      });
    }
    return sumiget;
  }

  double getTotalDebts(data) {
    double sum = 0;
    sum = getTotalIget(data) - getTotalIowe(data);
    return sum;
  }

  Color textColor(double sum, context) {
    Color textcolor = Theme.of(context).colorScheme.secondaryVariant;
    if (sum >= 0) {
      textcolor = Theme.of(context).colorScheme.secondary;
    }
    return textcolor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: Center(child: Text(S.of(context).stats)),
        backgroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30,30, 30,0),
        child: StreamBuilder(
            stream: repository.getStream(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData) {
                String uid = snapshot.data!.id;
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                double sum = getTotalDebts(data);
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total demands: "),
                        Text(getTotalIget(data).toString(),
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Theme.of(context).colorScheme.secondary))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total liabilities : "),
                        Text(getTotalIowe(data).toString(),
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Theme.of(context).colorScheme.secondaryVariant))
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Total: "),
                          Text(sum.toString(),
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(color: textColor(sum, context))),
                        ])
                  ],
                );
              } else {
                return Column(
                  children: const [Text("not connected to the Internet")],
                );
              }
            }),
      ),
    );
  }
}
