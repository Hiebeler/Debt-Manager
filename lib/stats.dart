import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debtmanager/home/data_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'generated/l10n.dart';
import 'home/side_bar.dart';

class Stats extends StatelessWidget {
  Stats({Key? key}) : super(key: key);

  DataRepository repository = DataRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: Center(child: Text(S.of(context).stats)),
        backgroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                      border: Border.all(
                          width: 1.5,
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Balance: "),
                        StreamBuilder(
                            stream: repository.getStream(),
                            builder: (BuildContext build,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.hasData) {
                                Map<String, dynamic> data = snapshot.data!
                                    .data() as Map<String, dynamic>;
                                double sum = 0;
                                double sumiget = 0;
                                double sumiowe = 0;

                                if (data["debts_Iget"] != null) {
                                  List iget = data["debts_Iget"];
                                  iget.forEach((element) {
                                    sumiget += element["value"];
                                  });
                                }
                                if (data["debts_Iowe"] != null) {
                                  List iget = data["debts_Iowe"];
                                  iget.forEach((element) {
                                    sumiowe += element["value"];
                                  });
                                }
                                sum = sumiget - sumiowe;
                                Color textcolor = Theme.of(context).colorScheme.secondaryVariant;
                                if(sum >= 0){
                                  textcolor = Theme.of(context).colorScheme.secondary;
                                }
                                return Text(sum.toString(),
                                style: TextStyle(color: textcolor));
                              }
                              return Container();
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
