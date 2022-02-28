import 'package:debtmanager/authentication/sign_in.dart';
import 'package:debtmanager/home/friends/friendsDebts.dart';
import 'package:debtmanager/home/profile.dart';
import 'package:debtmanager/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '/generated/l10n.dart';
import 'stats.dart';
import 'home.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  Future<String> loggout() async {
    await FirebaseAuth.instance.signOut();
    return "worked";
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              const Color(0x00000000),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: const [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const SizedBox(
              height: 60,
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: Text(S.of(context).homescreen),
              onTap: () => {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Home(isFriendsDebts: false,)))
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(S.of(context).settings),
              onTap: () => {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Settings()))
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(S.of(context).profile),
              onTap: () => {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Profile()))
              },
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: Text("Friends Debts"),
              onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Home(isFriendsDebts: true)))
              },
            ),
            ListTile(
              leading: const Icon(Icons.show_chart),
              title: Text(S.of(context).stats),
              onTap: () => {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Stats()))
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text(S.of(context).logout),
              onTap: () => {
                loggout().then((value) => {
                      if (value == "worked")
                        {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => SignIn()))
                        }
                    })
              },
            ),
          ],
        ),
      ),
    );
  }
}
