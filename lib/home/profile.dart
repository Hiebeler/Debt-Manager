import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debtmanager/generated/l10n.dart';
import 'package:debtmanager/home/friends/add_friend.dart';
import 'package:debtmanager/home/friends/friend_friendrequest_switch.dart';
import 'package:debtmanager/home/friends/friendrequests.dart';
import 'package:debtmanager/home/friends/friends_card.dart';
import 'package:debtmanager/home/friends/get_profile_image.dart';
import 'package:debtmanager/home/friends/profile_picture.dart';
import 'package:debtmanager/home/side_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'data_repository.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final DataRepository repository = DataRepository();
  File? image;

  Future<bool> getImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery, maxHeight: 1000, maxWidth: 1000);
      if (image == null) return false;

      final File? imageTemporary = File(image.path);
      this.image = imageTemporary;
      return true;
    } on PlatformException catch (e) {
      print("failed to pick image $e");
    }
    return false;
  }

  Future uploadProfileImage(String username) async {
    String url = "/profilePictures/$username.jpg";

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref("/profilePictures/$username.jpg")
          .delete();
    } catch (e) {
      print("doesnt already exists");
    }

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref("profilePictures/$username.jpg")
          .putFile(image!);
    } catch (e) {
      print(e);
    }

    await saveToDb(url);
  }

  Future saveToDb(String url) async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser!.uid)
        .update({"profilePicture": url});
  }

  double getTotalIowe(data){
    double sumiowe = 0;

    if (data["debts_Iowe"] != null) {
      List iget = data["debts_Iowe"];
      iget.forEach((element) {
        sumiowe += element["value"];
      });
    }

    return sumiowe;
  }

  double getTotalIget(data){
    double sumiget = 0;

    if (data["debts_Iget"] != null) {
      List iget = data["debts_Iget"];
      iget.forEach((element) {
        sumiget += element["value"];
      });
    }
    return sumiget;
  }

  double getTotalDebts(data) {
    double sum = 0;
    sum = getTotalIget(data) - getTotalIowe(data);
    return sum;
  }

  Color textColor(double sum) {
    Color textcolor = Theme.of(context).colorScheme.secondaryVariant;
    if (sum >= 0) {
      textcolor = Theme.of(context).colorScheme.secondary;
    }
    return textcolor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: Center(child: Text(S.of(context).profile)),
        backgroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: StreamBuilder(
          stream: repository.getStream(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData) {
              String uid = snapshot.data!.id;
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              double sum = getTotalDebts(data);
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          getImage().then((value) {
                            if (value) {
                              uploadProfileImage(data["username"])
                                  .then((value) => setState(() {}));
                            }
                          });
                        },
                        child: ProfilePicture(data: data, radius: 60, size: 80, imageSize: 130,)
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(data["username"],
                                style: Theme.of(context).textTheme.headline3),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(S.of(context).email + ": ",
                                style: Theme.of(context).textTheme.bodyText1),
                            const SizedBox(width: 20),
                            Text(data["email"],
                                style: Theme.of(context).textTheme.bodyText1),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(S.of(context).balance + ": ",
                                style: Theme.of(context).textTheme.bodyText1),
                            const SizedBox(width: 20),
                            Text(sum.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(color: textColor(sum))),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  FriendFriendrequestSwitch(data: data,uid: uid,),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            AddFriend addFriend = AddFriend();
            addFriend.showModal(context);
          },
          child: Text(S.of(context).addFriend)),
    );
  }
}
