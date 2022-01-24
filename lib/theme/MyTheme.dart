import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';
import 'custom_theme.dart';

class MyTheme with ChangeNotifier {
  static bool _isDark = true;

  MyTheme() {
    if (boxTheme.containsKey("theme")) {
      _isDark = boxTheme.get("theme");
    } else {
      boxTheme.put("theme", _isDark);
    }
  }

  ThemeData currentTheme() {
    return _isDark ? CustomTheme.darkTheme : CustomTheme.lightTheme;
  }

  int currentThemeInt() {
    return _isDark ? 1 : 2;
  }

  switchTheme(i) {

    if(i == 1) {
      boxTheme.put("theme", true);
    } else {
      boxTheme.put("theme", false);
    }
    _isDark = !_isDark;
    notifyListeners();
  }
}
