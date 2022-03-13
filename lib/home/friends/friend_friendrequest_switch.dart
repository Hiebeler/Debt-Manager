import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import 'friendrequests.dart';
import 'friends_card.dart';

class FriendFriendrequestSwitch extends StatefulWidget {
  final Map<String, dynamic> data;
  final String uid;
  const FriendFriendrequestSwitch({required this.data, required this.uid});

  @override
  State<FriendFriendrequestSwitch> createState() => _FriendFriendrequestSwitchState();
}

class _FriendFriendrequestSwitchState extends State<FriendFriendrequestSwitch> {

  String friendRequestOrFriends = "Friends";
  bool _friendRequestIsSelected = false;
  bool _friendsIsSelected = true;

  @override
  Widget build(BuildContext context) {
    return Column(children: [Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ChoiceChip(
          label: Text(S.of(context).friends),
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
          label: Text(S.of(context).friendRequests),
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
          ? Friends(
        data: widget.data,
      )
          : FriendRequestCard(
        uid: widget.uid,
      ),],);

  }
}
