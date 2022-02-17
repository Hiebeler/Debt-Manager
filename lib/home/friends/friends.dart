import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debtmanager/home/friends/add_friend.dart';
import 'package:debtmanager/home/side_bar.dart';
import 'package:flutter/material.dart';

import '../data_repository.dart';

class Friends extends StatelessWidget {
  Friends({Key? key}) : super(key: key);
  final DataRepository repository = DataRepository();

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
                      Text(
                        "Friends",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        "Friend Requests",
                        style: Theme.of(context).textTheme.bodyText2,
                      )
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
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(const Radius.circular(3)),
                            border: Border.all(
                                width: 1.5,
                                color:
                                    Theme.of(context).colorScheme.onSecondary),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: Row(
                              children: const [
                                Icon(Icons.person),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("kim"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: ElevatedButton(onPressed: () {
        AddFriend addFriend = AddFriend();
        addFriend.showModal(context);
      }, child: const Text("add friend")
    ),
    );
  }
}
