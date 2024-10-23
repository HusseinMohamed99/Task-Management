// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_management/generated/intl/messages_all.dart';

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

  /// `Task Management`
  String get title {
    return Intl.message(
      'Task Management',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `   Done! ✅  `
  String get condition {
    return Intl.message(
      '   Done! ✅  ',
      name: 'condition',
      desc: '',
      args: [],
    );
  }

  /// `Task`
  String get task {
    return Intl.message(
      'Task',
      name: 'task',
      desc: '',
      args: [],
    );
  }

  /// `'Are You Sure .  Delete This Task ?',`
  String get delete_task {
    return Intl.message(
      '\'Are You Sure .  Delete This Task ?\',',
      name: 'delete_task',
      desc: '',
      args: [],
    );
  }

  /// `Mode`
  String get mode {
    return Intl.message(
      'Mode',
      name: 'mode',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Add New Task`
  String get addtask {
    return Intl.message(
      'Add New Task',
      name: 'addtask',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title_ {
    return Intl.message(
      'Title',
      name: 'title_',
      desc: '',
      args: [],
    );
  }

  /// `No Tasks Yet!`
  String get no_task {
    return Intl.message(
      'No Tasks Yet!',
      name: 'no_task',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get try_again {
    return Intl.message(
      'Try Again',
      name: 'try_again',
      desc: '',
      args: [],
    );
  }

  /// `Error Loading Tasks Try Again Later`
  String get error_loading {
    return Intl.message(
      'Error Loading Tasks Try Again Later',
      name: 'error_loading',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter a valid Title`
  String get valid_title {
    return Intl.message(
      'Please Enter a valid Title',
      name: 'valid_title',
      desc: '',
      args: [],
    );
  }

  /// `Title should be at least a 3 characters`
  String get title_length {
    return Intl.message(
      'Title should be at least a 3 characters',
      name: 'title_length',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter a valid Description`
  String get valid_desc {
    return Intl.message(
      'Please Enter a valid Description',
      name: 'valid_desc',
      desc: '',
      args: [],
    );
  }

  /// `Description should be at least a 3 characters`
  String get desc_length {
    return Intl.message(
      'Description should be at least a 3 characters',
      name: 'desc_length',
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

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Task Inserted Successfully`
  String get task_insert {
    return Intl.message(
      'Task Inserted Successfully',
      name: 'task_insert',
      desc: '',
      args: [],
    );
  }

  /// `Error Inserting Task`
  String get task_error {
    return Intl.message(
      'Error Inserting Task',
      name: 'task_error',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get loading {
    return Intl.message(
      'Loading',
      name: 'loading',
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

  /// `Description`
  String get desc {
    return Intl.message(
      'Description',
      name: 'desc',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
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

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
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

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Edit Task`
  String get edit {
    return Intl.message(
      'Edit Task',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get save {
    return Intl.message(
      'Save Changes',
      name: 'save',
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

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get add {
    return Intl.message(
      'Submit',
      name: 'add',
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
