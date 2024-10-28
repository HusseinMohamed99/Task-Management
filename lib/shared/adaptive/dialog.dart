part of './../../core/helpers/export_manager/export_manager.dart';

class MyDialog {
  static void showLoadingDialog(
    BuildContext context,
    String message, {
    bool isDismissible = true,
  }) {
    if (!context.mounted) return;

    showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (context) {
        return AlertDialog.adaptive(
          content: Row(
            children: [
              const AdaptiveIndicator(),
              const SizedBox(width: 15),
              Text(
                message,
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
    if (!context.mounted) return;

    List<Widget> actions = _buildDialogActions(
      context,
      posActionTitle,
      posAction,
      negActionTitle,
      negAction,
    );

    showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (context) {
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
      },
    );
  }

  static List<Widget> _buildDialogActions(
    BuildContext context,
    String? posActionTitle,
    VoidCallback? posAction,
    String? negActionTitle,
    VoidCallback? negAction,
  ) {
    List<Widget> actions = [];

    if (posActionTitle != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(posActionTitle),
        ),
      );
    }

    if (negActionTitle != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            negAction?.call();
          },
          child: Text(negActionTitle),
        ),
      );
    }

    return actions;
  }

  static void hideDialog(BuildContext context) {
    if (context.mounted) {
      Navigator.pop(context);
    }
  }
}
