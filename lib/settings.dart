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
  bool isChecked = currentTheme.get_isDark();

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
      body: Column(
        children: [
          Row(
            children: [
              const Text("dark mode"),
              Switch(
                value: isChecked,
                onChanged: (bool value) {
                  currentTheme.switchTheme();
                  isChecked = value;
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
