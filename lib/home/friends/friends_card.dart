import 'package:flutter/material.dart';

class FriendsCard extends StatelessWidget {
  final Map<String, dynamic> data;

  FriendsCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return data["friends"] != null ? Column(
      children: [
        ...(data["friends"] as List).map((friends) {
          return Container(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(3)),
                      border: Border.all(
                          width: 1.5,
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.person),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(friends["name"]),
                            ],
                          ),
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
    ) : Container();
  }
}
