import 'package:flutter/material.dart';
import 'package:rafroid/res.dart' as Res;

class Utils {

  static showMessage(BuildContext context, String message) {
    Scaffold
        .of(context)
        .showSnackBar(SnackBar(
        backgroundColor: Res.Colors.snackbar,
        content: Text(message, style: Res.TextStyles.snackbar)
    ));
  }
}