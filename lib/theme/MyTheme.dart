import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';
import 'custom_theme.dart';

class MyTheme with ChangeNotifier {
  static bool _isDark = true;

  MyTheme() {
    if (box.containsKey("theme")) {
      _isDark = box.get("theme");
    } else {
      box.put("theme", _isDark);
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
      box.put("theme", true);
    } else {
      box.put("theme", false);
    }
    _isDark = !_isDark;
    notifyListeners();
  }
}
