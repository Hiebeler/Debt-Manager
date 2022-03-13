import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debtmanager/home/data_repository.dart';
import 'package:debtmanager/home/friends/profile_picture.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Friends extends StatelessWidget {
  final Map<String, dynamic> data;
  var user = FirebaseAuth.instance.currentUser;
  Friends({required this.data});

  final DataRepository repository = DataRepository();

  void deleteFriends(String friendsUid) {
    deleteFriendsAtFriend(friendsUid);
    deleteFriendsAtMe(friendsUid);
  }

  void deleteFriendsAtFriend(String friendsUid) {
    Map rightData = {"uid": user!.uid};
    print(rightData);
    FirebaseFirestore.instance.collection("users").doc(friendsUid).update({
      "friends": FieldValue.arrayRemove([rightData])
    }).whenComplete(() => print("Friend deleted"));
  }

  void deleteFriendsAtMe(String friendsUid) {
    Map rightData = {"uid": friendsUid};
    print(rightData);
    FirebaseFirestore.instance.collection("users").doc(user!.uid).update({
      "friends": FieldValue.arrayRemove([rightData])
    }).whenComplete(() => print("Friend deleted"));
  }

  @override
  Widget build(BuildContext context) {
    return data["friends"] != null
        ? Column(
            children: [
              ...(data["friends"] as List).map((friends) {
                return Card(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StreamBuilder(
                                stream:
                                    repository.getStreamFriends(friends["uid"]),
                                builder: (builder,
                                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                                  if (snapshot.hasData) {
                                    Map<String, dynamic> data = snapshot.data!
                                        .data() as Map<String, dynamic>;

                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                            leading: ProfilePicture(data: data, radius: 18, size: 23, imageSize: 35,),
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  data["username"],
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onSecondary),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    deleteFriends(friends["uid"]);
                                                  },
                                                  child: Icon(
                                                      Icons.person_remove, color: Theme.of(context).colorScheme.secondaryVariant,),
                                                ),
                                              ],
                                            )),
                                      ],
                                    );
                                  }
                                  return Container();
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              })
            ],
          )
        : Container();
  }
}
