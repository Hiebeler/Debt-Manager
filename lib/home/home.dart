import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debtmanager/home/add_debt.dart';
import 'package:debtmanager/home/friends/friendsDebts.dart';
import 'package:debtmanager/home/homeDebts.dart';
import 'package:debtmanager/home/side_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '/generated/l10n.dart';
import 'data_repository.dart';

class Home extends StatefulWidget {
  final bool isFriendsDebts;
  bool isIOwe = true;
  Home({required this.isFriendsDebts});


  Home.fromAddDebt(this.isIOwe, this.isFriendsDebts);

  @override
  State<Home> createState() => _HomeState(this.isIOwe);
}

class _HomeState extends State<Home> {
  final DataRepository repository = DataRepository();
  String IOweOrIGet = "I Owe";
  bool isIOwe = true;
  double iOweMargin = 0;
  int debtId = -1;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  var firebaseUser = FirebaseAuth.instance.currentUser;

  final Color green = const Color.fromRGBO(150, 255, 0, 1.0);
  final Color red = const Color.fromRGBO(255, 58, 0, 1.0);

  Color homeColor = const Color.fromRGBO(255, 57, 0, 1.0);

  _HomeState(bool isIOwe) {
    if (isIOwe == false) {
      this.isIOwe = isIOwe;
      IOweOrIGet = "I Get";
      homeColor = green;
    }
  }

  changeIOweOrIGet(changeValue) {
    setState(() {
      isIOwe = changeValue;

      if (isIOwe == true) {
        homeColor = red;
      } else {
        homeColor = green;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        title: Center(child: Text(S.of(context).debtManager)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: isIOwe
                    ? Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 3, color: homeColor),
                          ),
                        ),
                        child: IGetIOweButton(
                          text: S.of(context).iOwe,
                          isIOwe: true,
                          changeIOweOrIGet: changeIOweOrIGet,
                        ),
                      )
                    : IGetIOweButton(
                        text: S.of(context).iOwe,
                        isIOwe: true,
                        changeIOweOrIGet: changeIOweOrIGet,
                      ),
              ),
              Expanded(
                child: !isIOwe
                    ? Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 3, color: homeColor),
                          ),
                        ),
                        child: IGetIOweButton(
                          text: S.of(context).iGet,
                          isIOwe: false,
                          changeIOweOrIGet: changeIOweOrIGet,
                        ),
                      )
                    : IGetIOweButton(
                        text: S.of(context).iGet,
                        isIOwe: false,
                        changeIOweOrIGet: changeIOweOrIGet,
                      ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: !widget.isFriendsDebts ? HomeDebts(isIOwe: isIOwe, homeColor: homeColor,): FriendsDebts(isIOwe: isIOwe, homeColor: homeColor,),
            ),
          ),
        ],
      ),
      floatingActionButton: !widget.isFriendsDebts ? FloatingActionButton(
          child: const Icon(
            Icons.add,
            color: Color.fromRGBO(121, 121, 121, 1),
          ),
          onPressed: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddDebt(
                          color: homeColor,
                      isIOwe: isIOwe,
                        )))
              },
          backgroundColor: Theme.of(context).colorScheme.background,
          shape: CircleBorder(
            side: BorderSide(
              color: homeColor,
              width: 1,
            ),
          )): Container(),
    );
  }
}

class IGetIOweButton extends StatelessWidget {
  final String text;
  final Function changeIOweOrIGet;
  final bool isIOwe;

  const IGetIOweButton({
    required this.text,
    required this.isIOwe,
    required this.changeIOweOrIGet,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {changeIOweOrIGet(isIOwe)},
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      style: ElevatedButton.styleFrom(
        onPrimary: Theme.of(context).colorScheme.primaryVariant,
        primary: Theme.of(context).colorScheme.background,
        fixedSize: const Size(200, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        textStyle: const TextStyle(
          fontSize: 12,
        ),
      ),
    );
  }
}
