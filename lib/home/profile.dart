import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debtmanager/home/friends/add_friend.dart';
import 'package:debtmanager/home/friends/friendrequest_card.dart';
import 'package:debtmanager/home/friends/friends_card.dart';
import 'package:debtmanager/home/friends/get_profile_image.dart';
import 'package:debtmanager/home/side_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'data_repository.dart';

class Friends extends StatefulWidget {
  const Friends({Key? key}) : super(key: key);

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  final DataRepository repository = DataRepository();

  String friendRequestOrFriends = "Friends";
  bool _friendRequestIsSelected = false;
  bool _friendsIsSelected = true;
  File? image;

  Future getImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final File? imageTemporary = File(image.path);
      this.image = imageTemporary;
    } on PlatformException catch (e) {
      print("failed to pick image $e");
    }
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

  double getTotalDebts(data) {
    double sum = 0;
    double sumiget = 0;
    double sumiowe = 0;

    if (data["debts_Iget"] != null) {
      List iget = data["debts_Iget"];
      iget.forEach((element) {
        sumiget += element["value"];
      });
    }
    if (data["debts_Iowe"] != null) {
      List iget = data["debts_Iowe"];
      iget.forEach((element) {
        sumiowe += element["value"];
      });
    }
    sum = sumiget - sumiowe;
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
        title: const Center(child: Text("Friends")),
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
                            uploadProfileImage(data["username"])
                                .then((value) => setState(() {}));
                          });
                        },
                        child: FutureBuilder(
                            future: GetProfileImage()
                                .getImageFromFirebase(data["profilePicture"]),
                            builder: (context, snapshot) {
                              if (snapshot.data == "" ||
                                  snapshot.data == null) {
                                return CircleAvatar(
                                  backgroundColor: const Color(0xff626262),
                                  radius: 60,
                                  child: Icon(
                                    Icons.person,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                    size: 80,
                                  ),
                                );
                              } else {
                                return Container(
                                    width: 130.0,
                                    height: 130.0,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                                snapshot.data.toString()))));
                              }
                            }),
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
                            Text("email: ",
                                style: Theme.of(context).textTheme.bodyText1),
                            const SizedBox(width: 20),
                            Text(data["email"],
                                style: Theme.of(context).textTheme.bodyText1),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Balance: ",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ChoiceChip(
                        label: const Text("Friends"),
                        selected: _friendsIsSelected,
                        selectedColor: Theme.of(context).colorScheme.primary,
                        onSelected: (newBoolValue) {
                          setState(() {
                            _friendsIsSelected = true;
                            _friendRequestIsSelected = false;
                            friendRequestOrFriends = "Friends";
                          });
                        },
                      ),
                      ChoiceChip(
                        label: const Text("Friend Request"),
                        selected: _friendRequestIsSelected,
                        selectedColor: Theme.of(context).colorScheme.primary,
                        onSelected: (newBoolValue) {
                          setState(() {
                            _friendRequestIsSelected = true;
                            _friendsIsSelected = false;
                            friendRequestOrFriends = "Friend Requests";
                          });
                        },
                      )
                    ],
                  ),
                  friendRequestOrFriends == "Friends"
                      ? FriendsCard(
                          data: data,
                        )
                      : FriendRequestCard(
                          uid: uid,
                        ),
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
          child: const Text("add friend")),
    );
  }
}
