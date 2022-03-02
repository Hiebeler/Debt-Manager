import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'generated/l10n.dart';
import 'theme/config.dart';
import 'home/home.dart';
import 'authentication/sign_up.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("theme");
  boxTheme = Hive.box("theme");
  await Hive.initFlutter();
  await Hive.openBox("language");
  boxLanguage = Hive.box("language");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
    currentLanguage.addListener(() {
      setState(() {});
    });
  }

  Future<bool> checkIfSignedIn() async {
    var test = FirebaseAuth.instance.currentUser;
    if (test == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],

      locale: currentLanguage.isSet() ? currentLanguage.currentLocale : null,
      supportedLocales: S.delegate.supportedLocales,
      theme: currentTheme.currentTheme(),
      home: Scaffold(
        body: FutureBuilder(
          future: checkIfSignedIn(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == true) {
                return Home(isFriendsDebts: false,);
              } else {
                return SignUp();
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
