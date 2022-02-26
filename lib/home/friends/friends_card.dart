import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debtmanager/home/data_repository.dart';
import 'package:debtmanager/home/friends/get_profile_image.dart';
import 'package:debtmanager/home/friends/profile_picture.dart';
import 'package:flutter/material.dart';

class Friends extends StatelessWidget {
  final Map<String, dynamic> data;

  Friends({required this.data});

  final DataRepository repository = DataRepository();

  @override
  Widget build(BuildContext context) {
    return data["friends"] != null
        ? Column(
            children: [
              ...(data["friends"] as List).map((friends) {
                return Card(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Expanded(
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
                                            ProfilePicture(data: data),
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
                      ],
                    ),
                  ),
                );
              })
            ],
          )
        : Container();
  }
}
