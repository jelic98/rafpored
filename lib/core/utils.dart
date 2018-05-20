import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/view/page/login/login_page.dart';
import 'package:rafpored/view/page/list/list_page.dart';

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