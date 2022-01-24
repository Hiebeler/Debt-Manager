import 'package:debtmanager/settings.dart';
import 'package:debtmanager/sign-in/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/generated/l10n.dart';

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
              const Color(0x000),
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
              leading: const Icon(Icons.settings),
              title: Text(S.of(context).settings),
              onTap: () => {Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Settings()))},
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
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
