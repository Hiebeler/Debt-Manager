import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'get_profile_image.dart';

class ProfilePicture extends StatelessWidget {
  final Map data;
  final int radius;
  final int size;
  final int imageSize;
  const ProfilePicture({Key? key, required this.data, required this.radius, required this.size, required this.imageSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      return FutureBuilder(
          future:
              GetProfileImage().getImageFromFirebase(data["profilePicture"]),
          builder: (builder, snapshot) {
            print(snapshot.data);
            if (snapshot.data == "" || snapshot.data == null) {
              return CircleAvatar(
                backgroundColor: const Color(0xff1f1f1f),
                radius: radius.toDouble(),
                child: Icon(
                  Icons.person,
                  color: Theme.of(context).colorScheme.onSecondary,
                  size: size.toDouble(),
                ),
              );
            } else {
              return Container(
                  width: imageSize.toDouble(),
                  height: imageSize.toDouble(),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(snapshot.data.toString()))));
            }
          });
    } catch (e) {
      return Container();
    }
  }
}
