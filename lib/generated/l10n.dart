// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Sign up`
  String get signUp {
    return Intl.message(
      'Sign up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Sign up with Google`
  String get signUp_google {
    return Intl.message(
      'Sign up with Google',
      name: 'signUp_google',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message(
      'or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get firstname {
    return Intl.message(
      'First name',
      name: 'firstname',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get lastname {
    return Intl.message(
      'Last name',
      name: 'lastname',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm your Password`
  String get confirmpassword {
    return Intl.message(
      'Confirm your Password',
      name: 'confirmpassword',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAcc {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAcc',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signIn {
    return Intl.message(
      'Sign in',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get signIn_google {
    return Intl.message(
      'Sign in with Google',
      name: 'signIn_google',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an Account?`
  String get dontHaveAcc {
    return Intl.message(
      'Don\'t have an Account?',
      name: 'dontHaveAcc',
      desc: '',
      args: [],
    );
  }

  /// `Debt-Manager`
  String get debtManager {
    return Intl.message(
      'Debt-Manager',
      name: 'debtManager',
      desc: '',
      args: [],
    );
  }

  /// `I Owe`
  String get iOwe {
    return Intl.message(
      'I Owe',
      name: 'iOwe',
      desc: '',
      args: [],
    );
  }

  /// `I Get`
  String get iGet {
    return Intl.message(
      'I Get',
      name: 'iGet',
      desc: '',
      args: [],
    );
  }

  /// `Add Debt`
  String get addDebt {
    return Intl.message(
      'Add Debt',
      name: 'addDebt',
      desc: '',
      args: [],
    );
  }

  /// `Person`
  String get person {
    return Intl.message(
      'Person',
      name: 'person',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Value`
  String get value {
    return Intl.message(
      'Value',
      name: 'value',
      desc: '',
      args: [],
    );
  }

  /// `Add new Debt`
  String get addNewDebt {
    return Intl.message(
      'Add new Debt',
      name: 'addNewDebt',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `Light Mode`
  String get lightMode {
    return Intl.message(
      'Light Mode',
      name: 'lightMode',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `German`
  String get german {
    return Intl.message(
      'German',
      name: 'german',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Friends`
  String get friends {
    return Intl.message(
      'Friends',
      name: 'friends',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get homescreen {
    return Intl.message(
      'Home',
      name: 'homescreen',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get stats {
    return Intl.message(
      'Statistics',
      name: 'stats',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Assigned to me`
  String get assignedToMe {
    return Intl.message(
      'Assigned to me',
      name: 'assignedToMe',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get balance {
    return Intl.message(
      'Balance',
      name: 'balance',
      desc: '',
      args: [],
    );
  }

  /// `Friend Requests`
  String get friendRequests {
    return Intl.message(
      'Friend Requests',
      name: 'friendRequests',
      desc: '',
      args: [],
    );
  }

  /// `Add Friend`
  String get addFriend {
    return Intl.message(
      'Add Friend',
      name: 'addFriend',
      desc: '',
      args: [],
    );
  }

  /// `sent Friend Request`
  String get sentFriendRequest {
    return Intl.message(
      'sent Friend Request',
      name: 'sentFriendRequest',
      desc: '',
      args: [],
    );
  }

  /// `Do you want `
  String get wantOtherPersonToSeeDebt1 {
    return Intl.message(
      'Do you want ',
      name: 'wantOtherPersonToSeeDebt1',
      desc: '',
      args: [],
    );
  }

  /// ` to see this Debt`
  String get wantOtherPersonToSeeDebt2 {
    return Intl.message(
      ' to see this Debt',
      name: 'wantOtherPersonToSeeDebt2',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
