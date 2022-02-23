import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debtmanager/home/data_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FriendRequestCard extends StatelessWidget {
  final String uid;

  FriendRequestCard({required this.uid});

  var firebaseUser = FirebaseAuth.instance.currentUser;
  DataRepository repository = DataRepository();

  void acceptFriendRequest(String username, String friendsUid, List friendRequests) {
    addFriend(friendsUid, firebaseUser!.uid);
    addFriend(firebaseUser!.uid, friendsUid);
    removeDebt(friendsUid, friendRequests);
  }

  void removeDebt(String uid, List friendRequests) async {
    Map rightData = await getDebt(uid, friendRequests);
    print(rightData);
    FirebaseFirestore.instance.collection("users").doc(uid).update({
      "friendRequests": FieldValue.arrayRemove([rightData])
    }).whenComplete(() => print("Debt deleted"));
  }

  Future<Map> getDebt(String uid, List friendRequests) async {
    for (Map friendRequest in friendRequests) {
      if (friendRequest["uid"] == firebaseUser!.uid) {
        return friendRequest;
      }
    }
    return {};
  }

  void addFriend(String uid, String uidAdding) {
    FirebaseFirestore.instance.collection("users").doc(uid).update({
      "friends": FieldValue.arrayUnion([
        {"uid": uidAdding}
      ])
    }).then((value) => {print("success")});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: repository.getStreamFriendRequests(uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            List<Map> friendRequests = [];
            snapshot.data!.docs.forEach((element) {
              friendRequests.add({
                "username": element["username"],
                "uid": element.id,
                "friendRequests": element["friendRequests"]
              });
            });
            print(friendRequests);
            return Column(
              children: [
                ...(friendRequests).map(
                  ((username) {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(3)),
                                border: Border.all(
                                    width: 1.5,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.person),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(username["username"]),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            print("decline");
                                          },
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              print("accept");
                                              acceptFriendRequest(
                                                  username["username"],
                                                  username["uid"],
                                                  username["friendRequests"]);
                                            },
                                            child: const Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            );
          } else {
            return Container();
          }
        });
  }
}