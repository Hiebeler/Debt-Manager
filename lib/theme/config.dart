library config.globals;

import 'package:debtmanager/theme/MyTheme.dart';
import 'package:hive/hive.dart';

MyTheme currentTheme = MyTheme();
Box box = Hive.box('theme');