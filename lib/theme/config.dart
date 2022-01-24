library config.globals;

import 'package:debtmanager/languageChangeProvider.dart';
import 'package:debtmanager/theme/MyTheme.dart';
import 'package:hive/hive.dart';

MyTheme currentTheme = MyTheme();
Box boxTheme = Hive.box('theme');
LanguageChangeProvider currentLanguage = LanguageChangeProvider();
Box boxLanguage = Hive.box('language');
