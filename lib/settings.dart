import 'package:debtmanager/home/home.dart';
import 'package:flutter/material.dart';
import 'generated/l10n.dart';
import 'home/Side_bar.dart';
import 'theme/config.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int _value = currentTheme.currentThemeInt();
  String dropdownValue = "";

  @override
  void didChangeDependencies() {
    String language = Localizations.localeOf(context).toString();

    switch (language.substring(0, 2)) {
      case "en":
        dropdownValue = S.of(context).english;
        break;
      case "de":
        dropdownValue = S.of(context).german;
        break;
      default:
        dropdownValue = S.of(context).english;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavDrawer(),
        appBar: AppBar(
          title: Center(child: Text(S.of(context).settings)),
          backgroundColor: Theme.of(context).colorScheme.onBackground,
        ),
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                S.of(context).theme,
                style: Theme.of(context).textTheme.headline2,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: SizedBox(
                  height: 40,
                  child: ListTile(
                    contentPadding: const EdgeInsets.only(
                        left: 0.0, right: 0.0, bottom: 0.0),
                    title: Text(S.of(context).darkMode,
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
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: SizedBox(
                  height: 40,
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.only(left: 0.0, right: 0.0),
                    title: Text(
                      S.of(context).lightMode,
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
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                    S.of(context).language,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  DropdownButton(
                    value: dropdownValue,
                    elevation: 16,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                    underline: Container(
                      height: 2,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                        if (newValue == S.of(context).german) {
                          currentLanguage.changeLocale("de");
                        } else {
                          currentLanguage.changeLocale("en");
                        }
                      });
                    },
                    items: <String>[S.of(context).german, S.of(context).english]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
