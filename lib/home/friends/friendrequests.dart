import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debtmanager/home/data_repository.dart';
import 'package:debtmanager/home/friends/profile_picture.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FriendRequestCard extends StatelessWidget {
  final String uid;

  FriendRequestCard({required this.uid});

  var firebaseUser = FirebaseAuth.instance.currentUser;
  DataRepository repository = DataRepository();

  void acceptFriendRequest(String username, String friendsUid) {
    addFriend(friendsUid, firebaseUser!.uid);
    addFriend(firebaseUser!.uid, friendsUid);
    removeFriendsRequest(friendsUid,firebaseUser!.uid, "sentFriendRequests");
    removeFriendsRequest(firebaseUser!.uid, friendsUid,"receivedFriendRequests");
  }

  void removeFriendsRequest(String documentUid, String contentUid, String sentUidOrReceived) async {
    Map rightData = {"uid": contentUid};
    print(rightData);
    FirebaseFirestore.instance.collection("users").doc(documentUid).update({
      sentUidOrReceived: FieldValue.arrayRemove([rightData])
    }).whenComplete(() => print("Friend request deleted"));
  }

  Future<Map> getFriendsRequest(String uid, List friendRequests) async {
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
        stream: repository.getStream(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            if (data.containsKey("receivedFriendRequests")) {
              List receivedFriendRequests = data["receivedFriendRequests"];

              return Column(
                children: [
                  ...(receivedFriendRequests).map(
                    ((uid) {
                      return StreamBuilder(
                          stream: repository.getStreamFriends(uid["uid"]),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.hasData) {
                              Map<String, dynamic> friendData =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              return Card(
                                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  ProfilePicture(data: friendData, radius: 18, size: 23, imageSize: 35,),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(friendData["username"]),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return checkIfFriendShouldSee(
                                                              uid["uid"],
                                                              friendData[
                                                                  "sentFriendRequests"],
                                                              context);
                                                        },
                                                      );
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
                                                            friendData["username"],
                                                            uid["uid"]);
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
                                    ],
                                  ),
                                ),
                              );
                            }else{
                              return Container();
                            }
                          });
                    }),
                  ),
                ],
              );
            } else {
              return Container();
            }
          } else {
            return Container();
          }
        });
  }

  Widget checkIfFriendShouldSee(
      String friendsUid, List friendRequests, context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          title: Text(
            "Debt settings",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          content: Text(
            "Are You shure you want to decline this friendsrequest",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          actions: [
            ElevatedButton(
              child: Text("No"),
              style: ElevatedButton.styleFrom(primary: Colors.red),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
                child: Text("Yes"),
                style: ElevatedButton.styleFrom(primary: Colors.green),
                onPressed: () {
                  removeFriendsRequest(friendsUid,firebaseUser!.uid, "sentFriendRequests");
                  removeFriendsRequest(firebaseUser!.uid, friendsUid,"receivedFriendRequests");
                  Navigator.of(context).pop();
                }),
          ],
        ));
  }
}
