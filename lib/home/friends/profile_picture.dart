import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'get_profile_image.dart';

class ProfilePicture extends StatelessWidget {
  final Map data;
  const ProfilePicture({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
                  0xff1f1f1f),
              radius: 18,
              child: Icon(
                Icons.person,
                color: Theme.of(context)
                    .colorScheme
                    .onSecondary,
                size: 23,
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
        });
  }
}
