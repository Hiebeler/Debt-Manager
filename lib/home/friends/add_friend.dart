import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debtmanager/home/data_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddFriend {
  void addFriendRequest(String uid) {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser!.uid)
        .update({
      "friendRequests": FieldValue.arrayUnion([
        {"uid": uid}
      ])
    }).then((value) => {print("success")});
  }

  void showModal(context) {
    String username = "";
    DataRepository repository = DataRepository();

    showModalBottomSheet(
      enableDrag: false,
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
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: StreamBuilder(
                      stream: repository.getUsernames(username),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          List<Map> uidAndUsername = [];
                          snapshot.data!.docs.forEach((element) {
                            uidAndUsername.add({
                              "uid": element.id,
                              "username": element["username"]
                            });
                          });
                          if (username != "" && uidAndUsername == []) {
                            return const Text("no Users found");
                          } else if (username != "") {
                            return Column(
                              children: [
                                ...(uidAndUsername).map((debt) {
                                  return Center(
                                    child: Card(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                              leading: const Icon(Icons.person),
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(debt["username"]),
                                                  GestureDetector(
                                                    onTap: () => {
                                                      addFriendRequest(
                                                          debt["uid"])
                                                    },
                                                    child: const Icon(
                                                        Icons.person_add_alt_1),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
