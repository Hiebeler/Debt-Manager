import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debtmanager/home/data_repository.dart';
import 'package:flutter/material.dart';

class AddFriend {
  void showModal(context) {
    String username = "";
    DataRepository repository = DataRepository();

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height * .80,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Add Friend",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    onChanged: (input) {
                      username = input;
                    },
                    decoration: InputDecoration(
                      hintText: "Username",
                      enabledBorder:
                          Theme.of(context).inputDecorationTheme.enabledBorder,
                      focusedBorder:
                          Theme.of(context).inputDecorationTheme.focusedBorder,
                    ),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  StreamBuilder(
                      stream: repository.getUsernames(username),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          List<String> usernames = [];
                          snapshot.data!.docs.forEach((element) {
                            usernames.add(element["username"]);
                          });
                          print("list" + usernames.toString());
                          return Column(
                            children: [
                              ...(usernames).map((debt) {
                                return Text(debt);
                              })
                            ],
                          );
                        } else {
                          return Text("loading");
                        }
                      }),
                ],
              ),
            ),
          );
        });
  }
}
