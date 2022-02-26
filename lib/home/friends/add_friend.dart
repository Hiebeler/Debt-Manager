import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debtmanager/home/data_repository.dart';
import 'package:debtmanager/home/friends/profile_picture.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddFriend {

  AddFriend() {
    getFriendsUsernames();
  }

  List friendsUsernames = [];
  DataRepository repository = DataRepository();

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

  void getFriendsUsernames() {
    repository.getStream().listen((event) {
      List friendsUids = event["friends"];
      friendsUids.forEach((element) {
        repository.getFutureFriends(element["uid"]).then((value) {
          friendsUsernames.add(value["username"]);
        });
      });
    });
  }




  void showModal(context) {
    String username = "";

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
                      stream: repository.getStream(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasData) {
                          Map personalData = snapshot.data!.data() as Map;
                          List friendRequests = personalData["friendRequests"];
                          print(friendsUsernames);
                          return StreamBuilder(
                            stream: repository.getUsernames(username),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                List<Map> uidAndUsername = [];
                                snapshot.data!.docs.forEach((element) {
                                  bool isFriend = false;
                                  bool isOutgoingFriendRequest = false;
                                  friendsUsernames.forEach((friendsUsername) {
                                    if (element["username"] == friendsUsername) {
                                     isFriend = true;
                                    }
                                  });
                                  friendRequests.forEach((friendsUid) {
                                    if (element.id == friendsUid["uid"]) {
                                      isOutgoingFriendRequest = true;
                                    }
                                  });
                                  if (personalData["username"] != element["username"] && !isFriend && !isOutgoingFriendRequest) {
                                    uidAndUsername.add({
                                      "uid": element.id,
                                      "username": element["username"]
                                    });
                                  }
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
                                                    leading: ProfilePicture(data: debt),
                                                    title: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(debt["username"], style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),),
                                                        GestureDetector(
                                                          onTap: () {
                                                            addFriendRequest(
                                                                debt["uid"]);
                                                            toast(context);
                                                          },
                                                          child: const Icon(Icons
                                                              .person_add_alt_1),
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
                          );
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

  void toast(context) {
    Fluttertoast.showToast(
        msg: "Sent Friendrequest",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
