// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Task Management';

  @override
  String get condition => '   Done! ✅  ';

  @override
  String get task => 'Task';

  @override
  String get delete_task => '\'Are You Sure .  Delete This Task ?\',';

  @override
  String get mode => 'Mode';

  @override
  String get delete => 'Delete';

  @override
  String get addtask => 'Add New Task';

  @override
  String get title_ => 'Title';

  @override
  String get no_task => 'No Tasks Yet!';

  @override
  String get try_again => 'Try Again';

  @override
  String get error_loading => 'Error Loading Tasks Try Again Later';

  @override
  String get valid_title => 'Please Enter a valid Title';

  @override
  String get title_length => 'Title should be at least a 3 characters';

  @override
  String get valid_desc => 'Please Enter a valid Description';

  @override
  String get desc_length => 'Description should be at least a 3 characters';

  @override
  String get yes => 'Yes';

  @override
  String get ok => 'Ok';

  @override
  String get task_insert => 'Task Inserted Successfully';

  @override
  String get task_error => 'Error Inserting Task';

  @override
  String get loading => 'Loading';

  @override
  String get cancel => 'Cancel';

  @override
  String get desc => 'Description';

  @override
  String get date => 'Date';

  @override
  String get time => 'Time';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get edit => 'Edit Task';

  @override
  String get save => 'Save Changes';

  @override
  String get english => 'English';

  @override
  String get arabic => 'Arabic';

  @override
  String get rating => 'Rating';

  @override
  String get add => 'Submit';
}
