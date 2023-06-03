import 'package:flutter/material.dart';
import 'package:news_universe/src/core/theming/theme_colors.dart';

enum SnackbarColor { primary, error }

class SnackBarMessage {
  static SnackBar create({
    required String message,
    required SnackbarColor type,
    required BuildContext context,
    required VoidCallback onUndo,
  }) {
    final Map<SnackbarColor, Color> displayColor = {
      SnackbarColor.primary: kNewsPrimary60,
      SnackbarColor.error: kNewsError50,
    };

    return SnackBar(
      backgroundColor: displayColor[type],
      content: Text(
        message,
        style: Theme.of(context)
            .textTheme
            .displayLarge!
            .copyWith(fontWeight: FontWeight.w600),
      ),
      action: SnackBarAction(
        label: 'Undo',
        textColor: kNewsWhite,
        onPressed: onUndo,
      ),
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackbar(
      {required SnackBar snackBar, required BuildContext context}) {
    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
