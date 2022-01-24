import 'package:debtmanager/theme/config.dart';
import 'package:flutter/cupertino.dart';

class LanguageChangeProvider extends ChangeNotifier {
  String language = "not set";

  LanguageChangeProvider() {
    if (boxLanguage.containsKey("language")) {
      language = boxLanguage.get("language");
    } else {
      boxLanguage.put("language", language);
    }
  }

  bool isSet() {
    if (language == "not set") {
      return false;
  }
    return true;
}

  void changeLocale(String _locale) {
    language = _locale;
    boxLanguage.put("language", language);
    notifyListeners();
  }

  Locale get currentLocale {
    return Locale(language);
  }

  String get currentLocaleString {
    return language;
  }
}
