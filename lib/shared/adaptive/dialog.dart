part of './../../core/helpers/export_manager/export_manager.dart';

class MyDialog {
  static void showLoadingDialog(
    BuildContext context,
    String message, {
    bool isDismissible = true,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          content: Row(
            children: [
              const AdaptiveIndicator(),
              const Space(
                width: 15,
                height: 0,
              ),
              Text(
                message,
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          ),
        );
      },
      barrierDismissible: isDismissible,
    );
  }

  static void showMessage(
    BuildContext context,
    String message, {
    bool isDismissible = true,
    String? posActionTitle,
    VoidCallback? posAction,
    String? negActionTitle,
    VoidCallback? negAction,
  }) {
    List<Widget> actions = [];
    if (posActionTitle != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            if (posAction != null) {
              posAction();
            }
          },
          child: Text(
            posActionTitle,
          )));
    }
    if (negActionTitle != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            if (negAction != null) {
              negAction();
            }
          },
          child: Text(
            negActionTitle,
          )));
    }
    showDialog(
      context: context,
      builder: (context) {
        if (Platform.operatingSystem == 'android') {
          return AlertDialog(
            content: Text(
              message,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            actions: actions,
          );
        }

        return CupertinoAlertDialog(
          content: Text(
            message,
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          actions: actions,
        );
      },
      barrierDismissible: false,
    );
  }

  static void hideDialog(BuildContext context) {
    pop(context);
  }
}
