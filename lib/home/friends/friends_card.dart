import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debtmanager/home/data_repository.dart';
import 'package:debtmanager/home/friends/get_profile_image.dart';
import 'package:flutter/material.dart';

class FriendsCard extends StatelessWidget {
  final Map<String, dynamic> data;

  FriendsCard({required this.data});

  final DataRepository repository = DataRepository();

  @override
  Widget build(BuildContext context) {
    return data["friends"] != null
        ? Column(
            children: [
              ...(data["friends"] as List).map((friends) {
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
                                color:
                                    Theme.of(context).colorScheme.onSecondary),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                StreamBuilder(
                                    stream: repository
                                        .getStreamFriends(friends["uid"]),
                                    builder: (builder,
                                        AsyncSnapshot<DocumentSnapshot>
                                            snapshot) {
                                      if (snapshot.hasData) {
                                        Map<String, dynamic> data =
                                            snapshot.data!.data()
                                                as Map<String, dynamic>;

                                        return Row(
                                          children: [
                                            FutureBuilder(
                                                future: GetProfileImage()
                                                    .getImageFromFirebase(
                                                        data["profilePicture"]),
                                                builder: (builder, snapshot) {
                                                  print(snapshot.data);
                                                  if (snapshot.data == "" ||
                                                      snapshot.data == null) {
                                                    return CircleAvatar(
                                                      backgroundColor:
                                                          const Color(
                                                              0xff626262),
                                                      radius: 15,
                                                      child: Icon(
                                                        Icons.person,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSecondary,
                                                        size: 20,
                                                      ),
                                                    );
                                                  } else {
                                                    return Container(
                                                        width: 30.0,
                                                        height: 30.0,
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            image: DecorationImage(
                                                                fit:
                                                                    BoxFit.fill,
                                                                image: NetworkImage(
                                                                    snapshot
                                                                        .data
                                                                        .toString()))));
                                                  }
                                                }),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Text(data["username"]),
                                          ],
                                        );
                                      }
                                      return Container();
                                    }),
                              ],
                            ),
                          ),
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