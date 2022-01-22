import 'package:debtmanager/theme/custom_theme.dart';
import 'package:debtmanager/home/home.dart';
import 'package:flutter/material.dart';

import 'theme/config.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int _value = currentTheme.currentThemeInt();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Home()));
            },
            child: const Icon(
              Icons.arrow_back, // add custom icons also
            ),
          ),
          title: const Center(child: Text("Settings")),
          backgroundColor: Theme.of(context).colorScheme.onBackground,
        ),
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Theme:",
                style: Theme.of(context).textTheme.headline2,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: SizedBox(
                  height: 40,
                  child: ListTile(
                    contentPadding: const EdgeInsets.only(
                        left: 0.0, right: 0.0, bottom: 0.0),
                    title: Text('Dark Mode',
                        style: Theme.of(context).textTheme.bodyText1),
                    leading: SizedBox(
                      width: 20,
                      height: 20,
                      child: Radio(
                        value: 1,
                        groupValue: _value,
                        activeColor: Theme.of(context).colorScheme.primary,
                        onChanged: (value) {
                          setState(() {
                            _value = int.parse(value.toString());
                            currentTheme.switchTheme(1);
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: SizedBox(
                  height: 40,
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.only(left: 0.0, right: 0.0),
                    title: Text(
                      'Light Mode',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    leading: SizedBox(
                      width: 20,
                      height: 20,
                      child: Radio(
                        value: 2,
                        groupValue: _value,
                        activeColor: Theme.of(context).colorScheme.primary,
                        onChanged: (value) {
                          setState(() {
                            _value = int.parse(value.toString());
                            currentTheme.switchTheme(2);
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Language :",
                style: Theme.of(context).textTheme.headline2,
              ),
            ],
          ),
        ));
  }
}
