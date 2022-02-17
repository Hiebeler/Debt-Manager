import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debtmanager/home/friends/add_friend.dart';
import 'package:debtmanager/home/friends/friendrequest_card.dart';
import 'package:debtmanager/home/friends/friends_card.dart';
import 'package:debtmanager/home/side_bar.dart';
import 'package:flutter/material.dart';

import '../data_repository.dart';

class Friends extends StatefulWidget {
  Friends({Key? key}) : super(key: key);

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  final DataRepository repository = DataRepository();

  String friendRequestOrFriends = "Friends";

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
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.person,
                        color: Theme.of(context).colorScheme.onSecondary,
                        size: 100,
                      ),
                      Text(data["username"],
                          style: Theme.of(context).textTheme.headline3)
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("email: ",
                          style: Theme.of(context).textTheme.bodyText1),
                      const SizedBox(width: 20),
                      Text(data["email"],
                          style: Theme.of(context).textTheme.bodyText1),
                    ],
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => {
                          setState(() {
                            friendRequestOrFriends = "Friends";
                          })
                        },
                        child: Text(
                          "Friends",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {
                          setState(() {
                            friendRequestOrFriends = "Friend Requests";
                          })
                        },
                        child: Text(
                          "Friend Requests",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Expanded(
                          child: Divider(
                        color: Colors.white,
                      ))
                    ],
                  ),

                  friendRequestOrFriends == "Friends"
                      ? FriendsCard(data: data,)
                      : FriendRequestCard(
                          data: data,
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
