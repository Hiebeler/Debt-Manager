import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debtmanager/home/data_repository.dart';
import 'package:debtmanager/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '/generated/l10n.dart';
import '../error_dialog.dart';

class AddDebt extends StatefulWidget {
  Color color;
  String person = "";
  String description = "";
  double value = 0;
  int id = -1;
  bool isIOwe = false;

  AddDebt({required this.color, required this.isIOwe});

  AddDebt.changeDebt(this.color, this.person, this.description, this.value,
      this.id, this.isIOwe);

  @override
  State<AddDebt> createState() =>
      _AddDebtState(person, description, value, id, isIOwe);
}

class _AddDebtState extends State<AddDebt> {
  bool isIOwe = false;
  bool isIGet = true;
  var person = "";
  var description = "";
  double value = 0;
  int id = -1;

  _AddDebtState(this.person, this.description, this.value, this.id, this.isIOwe) {
    isIGet = !isIOwe;
  }

  var collection = FirebaseFirestore.instance.collection('users');
  var firebaseUser = FirebaseAuth.instance.currentUser;
  final DataRepository repository = DataRepository();
  List<String> friends = [];

  @override
  void initState() {
    getAllFriends();
    super.initState();
  }

  void getAllFriends() async {
    List<dynamic> friendsMapList = [];
    await repository.getCurrentDocument().then((value) {
      try {
        friendsMapList = value["friends"];
      } catch (e) {
        print("no Friends");
      }
    });
    friendsMapList.forEach((element) {
      repository.getStreamFriends(element["uid"]).listen((event) {
        friends.add(event["username"]);
      });
    });
  }

  String getIOweOrIGet() {
    if (isIOwe) {
      return "debts_Iowe";
    } else {
      return "debts_Iget";
    }
  }

  Future<Map> getDebt() async {
    int maxId = 0;
    Map rightDebt = {};
    var docSnapshot = await collection.doc(firebaseUser!.uid).get();
    if (docSnapshot.exists && docSnapshot.data()![getIOweOrIGet()] != null) {
      List<dynamic> data = docSnapshot.data()![getIOweOrIGet()];
      if (data.isEmpty) {
        return rightDebt;
      }
      rightDebt = data[0];
      for (Map i in data) {
        print(i["id"]);
        if (id != -1) {
          if (i["id"] == id) {
            rightDebt = i;
          }
        } else {
          if (i["id"] > maxId) {
            maxId = i["id"];
            rightDebt = i;
          }
        }
      }
      return rightDebt;
    } else {
      return rightDebt;
    }
  }

  Future<bool> removeDebt() async {
    Map rightData = await getDebt();
    collection.doc(firebaseUser?.uid).update({
      getIOweOrIGet(): FieldValue.arrayRemove([rightData])
    }).whenComplete(() => print("Debt deleted"));
    return true;
  }

  Future<int> debtId() async {
    if (id == -1) {
      int maxId = 0;
      await getDebt().then((value) => {
            if (value["id"] != null) {maxId = value["id"] + 1}
          });
      return maxId;
    } else {
      await removeDebt();
      return id;
    }
  }

  Future personIsFriend(int debtId) async {
    bool isFriend = false;
    await repository.getFriendsFromUsername(person).then((value) {
      String uid = "";
      value.docs.forEach((element) {
        isFriend = true;
        uid = element.id;
      });
      if (isFriend) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return checkIfFriendShouldSee(debtId, uid, person);
          },
        );
      } else {
        addDebtToDB(debtId);
        Navigator.of(context).pop();
      }
    });
  }

  void addDebtToFriends(String friendsUID, int debtId) async {
    String myName = "";
    await repository
        .getCurrentDocument()
        .then((value) => myName = value["username"]);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser!.uid)
        .update({
      "friendsDebts": FieldValue.arrayUnion([
        {
          "id": debtId,
          "person": myName,
          "description": description,
          "value": value,
          "friendsUid": friendsUID,
          "IOweOrIGet": getIOweOrIGet(),
        }
      ])
    }).then((value) => {print("success")});
  }

  void addDebtToDB(int debtId) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseUser!.uid)
        .update({
      getIOweOrIGet(): FieldValue.arrayUnion([
        {
          "id": debtId,
          "person": person,
          "description": description,
          "value": value
        }
      ])
    }).then((value) => {print("success")});
  }

  Future addDebt() async {
    int id = await debtId();
    personIsFriend(id);

    return true;
  }

  errorDialog(BuildContext context, explanation) {
    ErrorDialog alert = ErrorDialog("Error", explanation);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        title: Center(child: Text(S.of(context).debtManager)),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  id == -1
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ChoiceChip(
                              label: Text("I Owe", style: Theme.of(context).textTheme.bodyText1,),
                              selected: isIOwe,
                              selectedColor:
                                  Theme.of(context).colorScheme.secondaryVariant,
                              onSelected: (newBoolValue) {
                                setState(() {
                                  widget.color = Theme.of(context).colorScheme.secondaryVariant;
                                  isIOwe = true;
                                  isIGet = false;

                                });
                              },
                            ),
                            ChoiceChip(
                              label: Text("I Get", style: Theme.of(context).textTheme.bodyText1,),
                              selected: isIGet,
                              selectedColor:
                                  Theme.of(context).colorScheme.secondary,
                              onSelected: (newBoolValue) {
                                setState(() {
                                  widget.color = Theme.of(context).colorScheme.secondary;
                                  isIOwe = false;
                                  isIGet = true;
                                });
                              },
                            )
                          ],
                        )
                      : Container(),
                  const SizedBox(height: 20),
                  Autocomplete(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable<String>.empty();
                    }
                    return friends.where((String option) {
                      return option
                          .contains(textEditingValue.text.toLowerCase());
                    });
                  }, fieldViewBuilder:
                          (context, controller, focusNode, onEditingComplete) {
                    controller.text = person;
                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      onEditingComplete: onEditingComplete,
                      onChanged: (input) => {person = input},
                      decoration: InputDecoration(
                        hintText: S.of(context).person,
                      ),
                      style: Theme.of(context).textTheme.bodyText1,
                    );
                  }, onSelected: (String selection) {
                    debugPrint('You just selected $selection');
                    person = selection;
                  }),
                  const SizedBox(height: 20),
                  TextField(
                    controller: TextEditingController(text: description),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: (input) => {description = input},
                    decoration: InputDecoration(
                      hintText: S.of(context).description,
                      enabledBorder:
                          Theme.of(context).inputDecorationTheme.enabledBorder,
                      focusedBorder:
                          Theme.of(context).inputDecorationTheme.focusedBorder,
                    ),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: TextEditingController(
                        text: value != 0 ? value.toString() : ""),
                    keyboardType: TextInputType.number,
                    onChanged: (input) => {
                      if (input != "") {value = double.parse(input)}
                    },
                    decoration: InputDecoration(
                      hintText: S.of(context).value,
                      enabledBorder:
                          Theme.of(context).inputDecorationTheme.enabledBorder,
                      focusedBorder:
                          Theme.of(context).inputDecorationTheme.focusedBorder,
                    ),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(height: 35),
                  ElevatedButton(
                    onPressed: () => {
                      addDebt().then((value) => {if (value) {}}),
                    },
                    child: Text(S.of(context).addNewDebt,
                        style: Theme.of(context).textTheme.bodyText1),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(340, 50),
                      maximumSize: const Size(340, 50),
                      primary: widget.color,
                      padding: const EdgeInsets.only(top: 17, bottom: 17),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: const TextStyle(fontSize: 17),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget checkIfFriendShouldSee(int debtId, String friendsUid, String person) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          title: Text(
            "Debt settings",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          content: Text(
            "Do You Want $person to see it",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          actions: [
            ElevatedButton(
              child: Text("No"),
              style: ElevatedButton.styleFrom(primary: Theme.of(context).colorScheme.secondaryVariant),
              onPressed: () {
                addDebtToDB(debtId);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Home.fromAddDebt(isIOwe, false)));
              },
            ),
            ElevatedButton(
                child: Text("Yes"),
                style: ElevatedButton.styleFrom(primary: Theme.of(context).colorScheme.secondary),
                onPressed: () {
                  addDebtToDB(debtId);
                  addDebtToFriends(friendsUid, debtId);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Home.fromAddDebt(isIOwe, false)));
                }),
            ElevatedButton(
              child: Text("Cancel"),
              style: ElevatedButton.styleFrom(primary: Colors.grey),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}
