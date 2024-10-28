part of './../../core/helpers/export_manager/export_manager.dart';

void pop(BuildContext context) {
  Navigator.pop(context);
}

void navigateTo(BuildContext context,
    {required String routeName, Object? arguments}) {
  Navigator.pushNamed(
    context,
    routeName,
    arguments: arguments,
  );
}

void navigateAndFinish(
  BuildContext context, {
  required String routeName,
  Object? arguments,
}) {
  Navigator.pushNamedAndRemoveUntil(
    context,
    routeName,
    arguments: arguments,
    (route) => false,
  );
}
