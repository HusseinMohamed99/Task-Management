import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management/shared/components/navigator.dart';
import 'package:task_management/shared/components/size_box.dart';

class MyDialog {
  static void showLoadingDialog(
      BuildContext context,
      String message, {
        bool isDismissible = true,
      }) {
    showDialog(
      context: context,
      builder: (context) {
        if (Platform.operatingSystem == 'android') {
          return AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(),
                const Space(width: 15, height: 0),
                Text(
                  message,
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              ],
            ),
          );
        }

        return CupertinoAlertDialog(
          content: Row(
            children: [
              const CupertinoActivityIndicator(),
              const Space(width: 15, height: 0),
              Text(
                message,
                style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
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
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
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
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 20,
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