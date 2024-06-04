import 'package:flutter/material.dart';
import 'package:todo_app/my_theme.dart';

class DialogUtils {
  static void showLoading({
    required BuildContext context,
    required String actionName,
    bool isDismissible = true,
  }) {
    showDialog(
        barrierDismissible: isDismissible,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircularProgressIndicator(
                  color: AppTheme.primaryColor,
                ),
                Text(
                  actionName,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: AppTheme.primaryColor),
                ),
              ],
            ),
          );
        });
  }

  static void hideLoading({required BuildContext context}) {
    Navigator.of(context).pop();
  }

  static showMessage(
      {required BuildContext context,
      bool isDismissible = true,
      String? title,
      String? posAction,
      String? negAction,
      Function? posActionFunction,
      Function? negAtionFunction,
      required String message}) {
    List<Widget> actions = [];
    if (posAction != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            if (posActionFunction != null) {
              posActionFunction.call();
            }
          },
          child: Text(posAction)));
    }
    if (negAction != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            if (negAtionFunction != null) {
              negAtionFunction.call();
            }
          },
          child: Text(negAction)));
    }
    showDialog(
        barrierDismissible: isDismissible,
        context: context,
        builder: (context) {
          return AlertDialog(
              actions: actions,
              title: Text(title ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.black)),
              content: Text(message,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.black)));
        });
  }
}
