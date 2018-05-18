import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:rafroid/core/res.dart' as Res;
import 'package:rafroid/view/page/login/login_page.dart';
import 'package:rafroid/view/page/list/list_page.dart';

class Utils {

  static showMessage(BuildContext context, String message) {
    Scaffold
        .of(context)
        .showSnackBar(SnackBar(
        backgroundColor: Res.Colors.snackbar,
        content: Text(message, style: Res.TextStyles.snackbar)
    ));
  }

  static Future<Widget> firstPage() async {
    String username;

    await SharedPreferences.getInstance().then((prefs) => username = prefs.getString("username") ?? "");

    return (username.isEmpty) ? LoginPage() : ListPage();
  }
}